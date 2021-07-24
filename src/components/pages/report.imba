import {fromToServer} from '../util/fromToServer'
import {arraySum} from '../util/helpers'
import {Conf} from '../../server'

const ChartDataLabels = require('chartjs-plugin-datalabels')

export tag Report

    let tableData1=[]
    let tableData2=[]    
    let arr_report_options=[]
    let arr_options_sub2=[]
    let objData={}
    let tableConfig1=[]
    let tableConfig2=[]   
    let server = <fromToServer>
    let mode = window.TARGET_ENV
    let int_active_vacancies = 0
    let int_total_vacancies = 0
    let selected_opt_sub1
    let selected_opt_sub2
    let selected_opt_period    
    let myChart_rep1
    let myChart_rep2
    let button_title = 'График'
    let is_show_chart = false
    let display_table1 = 'none'
    let display_table2 = 'none'

    def ger_report_options
        if mode=="production"
            server.load("&action=get_report_options").then do |data|
                arr_report_options = data:data
                Imba.commit
        else
            arr_report_options = await Conf("get_report_options")
            Imba.commit

    def change_opt_sub1 e
        selected_opt_sub1= e:_event:target:value
        arr_options_sub2=arr_report_options:subdivisions_3:filter(do |el| el:subdivisions_2_id==selected_opt_sub1)
        selected_opt_sub2 = 'all'
        get_report1
        get_report2
    def change_opt_sub2 e
        selected_opt_sub2= e:_event:target:value
        get_report1
        get_report2
    def change_opt_period e
        selected_opt_period= e:_event:target:value
        get_report2             

    def get_report1
        if mode=="production"
            params = '&'+ URLSearchParams.new({report: '1', sub1: selected_opt_sub1, sub2: selected_opt_sub2, period: selected_opt_period}).toString
            server.load("&action=get_report"+params).then do |data|
                tableData1 = data:data
                if tableData1 != undefined
                    total tableData1
                    removeDataChart1 myChart_rep1
                    addDataChart1 myChart_rep1, tableData1
                else
                    removeDataChart1 myChart_rep1 
                Imba.commit
        else
            objData = await Conf("get_data_table_r1")
            if selected_opt_sub1 == 'Подразделение 1'
                objData = await Conf("tableDataReport1_v1")
            tableData1 = objData
            # total tableData
            removeDataChart1 myChart_rep1
            addDataChart1 myChart_rep1, tableData1
            Imba.commit

    def get_report2
        if mode=="production"
            params = '&'+ URLSearchParams.new({report: '2', sub1: selected_opt_sub1, sub2: selected_opt_sub2, period: selected_opt_period}).toString
            server.load("&action=get_report"+params).then do |data|
                tableData2 = data:data
                if tableData2 != undefined
                    total tableData2
                    removeDataChart2 myChart_rep2
                    addDataChart2 myChart_rep2, tableData2
                else
                    removeDataChart2 myChart_rep2
                Imba.commit
        else
            objData = await Conf("get_data_table_r2")
            tableData2 = objData
            # total tableData
            removeDataChart2 myChart_rep2
            addDataChart2 myChart_rep2, tableData2
            Imba.commit

    def get_chart1
        let ctx = document:getElementById('myChart1')
        let chart_data = {
            labels: [],
            datasets: [{
                label: 'Активных',
                data: [],
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                borderColor: 'rgb(75, 192, 192)',
                borderWidth: 1,
                order: 1
            },{
                label: 'Всего',
                data: [],
                backgroundColor: 'rgba(255, 99, 132, 0.2)',
                borderColor: 'rgb(255, 99, 132)',
                borderWidth: 1,
                order: 2
            }]
        }
        let chart_options = {
            plugins: {
                datalabels: {
                    formatter: do |value| return value > 0 ? value : '',
                    font: do |context| return {size: context:dataset:data:length > 20 ? 8 : 10, weight: 'bold'}               
                }
            },            
            title: {
                display: true,
                text: 'Вакансии в подборе',
                fontSize: 16
            },
            legend: {
                labels: {
                    fontSize: 10
                },                
                display: true,
                position: 'top',
                fullSize: true
            },
            scales: {
                xAxes: [{
                    stacked: true,
                    ticks: {
                        beginAtZero: true,
                        fontSize: 10
                    },
                    scaleLabel: {
                        display: true,
                        labelString: 'Количество',
                        fontSize: 10
                    }
                }],
                yAxes: [{
                    ticks: {
                        beginAtZero: true,
                        fontSize: 10
                    },                    
                    stacked: true,
                    scaleLabel: {
                        display: true,
                        labelString: 'Вакансии',
                        fontSize: 10
                    }
                }]
            }
        }

        let conf = {
            type: 'horizontalBar',
            plugins: [ChartDataLabels],
            data: chart_data,
            options: chart_options
        }

        myChart_rep1=Chart.new ctx, conf

    def get_chart2
        let ctx = document:getElementById('myChart2')
        let chart_data = {
            labels: [],
            datasets: [{
                label: 'Направлено реэюме заказчику',
                data: [],
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                borderColor: 'rgb(75, 192, 192)',
                borderWidth: 1,
                order: 1
            },{
                label: 'Интервью с заказчиком',
                data: [],
                backgroundColor: 'rgba(255, 99, 132, 0.2)',
                borderColor: 'rgb(255, 99, 132)',
                borderWidth: 1,
                order: 2
            },{
                label: 'Финалистов',
                data: [],
                backgroundColor: 'rgba(24, 166, 12, 0.2)',
                borderColor: 'rgb(24, 99, 12)',
                borderWidth: 1,
                order: 3
            }]
        }
        let chart_options = {
            responsive: true,
            plugins: {               
                datalabels: {
                    formatter: do |value| return value > 0 ? value : '',
                    font: do |context| return {size: context:dataset:data:length > 20 ? 8 : 10, weight: 'bold'} 
                }                         
            },             
            title: {
                display: true,
                text: 'Статистика за период',
                fontSize: 16
            },
            legend: {
                labels: {
                    fontSize: 10
                },              
                display: true,
                position: 'top',
                fullSize: true
            },
            scales: {
                xAxes: [{
                    ticks: {
                        beginAtZero: true,
                        fontSize: 10
                    },
                    scaleLabel: {
                        display: true,
                        labelString: 'Вакансии',
                        fontSize: 10
                    }
                }],
                yAxes: [{
                    scaleLabel: {
                        display: true,
                        labelString: 'Количество',
                        fontSize: 10
                    }
                }]
            }  
        }

        let conf = {
            type: 'bar',
            plugins: [ChartDataLabels],
            data: chart_data,
            options: chart_options
        }

        myChart_rep2=Chart.new ctx, conf
        console.log myChart_rep2


    def addDataChart1 chart, data
        for item in data:labels
            chart:data:labels:push(item)
        chart:data:datasets:forEach(do |dataset|
            if dataset:order == 1
                for item in data:active_vacancies
                    dataset:data:push(item)
            else if dataset:order == 2
                for item in data:total_vacancies
                    dataset:data:push(item)
        )
        chart:update()

    def removeDataChart1 chart
        chart:data:labels = []
        chart:data:datasets:forEach(do |dataset|
            dataset:data = []
        )
        chart:update()

    def addDataChart2 chart, data
        for item in data:labels
            chart:data:labels:push(item)
        chart:data:datasets:forEach(do |dataset|
            if dataset:order == 1
                for item in data:resume
                    dataset:data:push(item)
            else if dataset:order == 2
                for item in data:interview
                    dataset:data:push(item)
            else if dataset:order == 3
                for item in data:finalists
                    dataset:data:push(item)
        )
        # chart:options:scales:yAxes[0]:scaleLabel:fontSize = chart:config:data:labels:length > 20 ? 10 : 12
        # chart:options:scales:xAxes[0]:scaleLabel:fontSize = chart:config:data:labels:length > 20 ? 10 : 12
        chart:update()

    def removeDataChart2 chart
        chart:data:labels = []
        chart:data:datasets:forEach(do |dataset|
            dataset:data = []
        )
        chart:update()

    def button_selection _block
        if _block == 'left'
            display_table1 = (display_table1 == 'none') ? 'flex' : 'none'
        if _block == 'right'
            display_table2 = (display_table2 == 'none') ? 'flex' : 'none'            


    def total obj
        let total = {}
        total:vacancies = 'Общий итог'
        total:active_vacancies = arraySum obj:active_vacancies
        total:total_vacancies = arraySum obj:total_vacancies
        obj:data:push(total)

    def mount
        selected_opt_sub1 = "all"
        selected_opt_sub2 = "all"
        selected_opt_period = "all"        
        is_show_chart = false
        button_title = 'График'
        tableConfig1 = await Conf("get_conf_table_r1")
        tableConfig2 = await Conf("get_conf_table_r2")
        get_chart1
        get_chart2
        ger_report_options
        get_report1
        get_report2

    def render
        <self>
            <div.report_options>
                <fieldset>
                    <legend>
                        <b> "Фильтр"
                    <div.report_options-div>    
                        <select.select-css :change.change_opt_sub1>
                            <option  selected=(selected_opt_sub1=="all") value="all"> "Все управления"
                            for item in arr_report_options:subdivisions_2
                                <option selected=(selected_opt_sub1==item:subdivisions_2_id) value=item:subdivisions_2_id> item:subdivisions_2_fullname
                        <select.select-css :change.change_opt_sub2>
                            <option  selected=(selected_opt_sub2=="all") value="all"> "Все отделы"
                            for item in arr_options_sub2
                                <option selected=(selected_opt_sub2==item:subdivisions_3_id) value=item:subdivisions_3_id> item:subdivisions_3_fullname                            
                        <select.select-css :change.change_opt_period>
                            <option selected=(selected_opt_period=="all") value="all"> "За весь период"
                            for item in arr_report_options:period
                                <option selected=(selected_opt_period==item:month_id) value=item:month_id> item:month_name                                      
            <div.content_chart>
                <div.content_chart1>
                    # <div.content_button>
                    #    <button.button-css disabled=(tableData1:length==0) :click=(do button_selection 'left')>
                    <canvas id="myChart2">
                    ###
                    <div.content_table css:display="{display_table1}">
                        <table.table>
                            <thead.font--small=(tableConfig1:length>6)>
                                <tr>
                                    for item,index in tableConfig1
                                        <th.th_left=(index==0) css:width="{item:width}">
                                            if item:title
                                                <span> item:title
                            <tbody>
                                for item in tableData1:data
                                    if item:vacancies != 'Общий итог'
                                        <tr>
                                            <td css:width="30vw"> item:vacancies
                                            <td css:text-align="right" css:width="10vw"> item:active_vacancies
                                            <td css:text-align="right" css:width="10vw"> item:total_vacancies
                                    else
                                        <tr>
                                            <td.total css:width="30vw"> item:vacancies
                                            <td.total css:text-align="right" css:width="10vw"> item:active_vacancies
                                            <td.total css:text-align="right" css:width="10vw"> item:total_vacancies 
                    ###                    
                <div.content_chart2> 
                    # <div.content_button>
                    #    <button.button-css disabled=(tableData2:length==0) :click=(do button_selection 'right')>                               
                    <canvas id="myChart1">
                    ###
                    <div.content_table css:display="{display_table2}">
                        <table.table>
                            <thead.font--small=(tableConfig2:length>6)>
                                <tr>
                                    for item,index in tableConfig2
                                        <th.th_left=(index==0) css:width="{item:width}">
                                            if item:title
                                                <span> item:title
                            <tbody>
                                for item in tableData2:data
                                    if item:vacancies != 'Общий итог'
                                        <tr>
                                            <td css:width="30vw"> item:vacancies
                                            <td css:text-align="right" css:width="11vw"> item:resume
                                            <td css:text-align="right" css:width="11vw"> item:interview
                                            <td css:text-align="right" css:width="11vw"> item:finalists
                                    else
                                        <tr>
                                            <td.total css:width="30vw"> item:vacancies
                                            <td.total css:text-align="right" css:width="11vw"> item:resume
                                            <td.total css:text-align="right" css:width="11vw"> item:interview
                                            <td.total css:text-align="right" css:width="11vw"> item:finalists
                    ###                                                       

