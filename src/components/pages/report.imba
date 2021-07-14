import {fromToServer} from '../util/fromToServer'
import {arraySum} from '../util/helpers'
import {Conf} from '../../server'

export tag Report

    let tableData1=[]
    let tableData2=[]    
    let arrSubdivisions=[]
    let objData={}
    let tableConfig1=[]
    let tableConfig2=[]   
    let server = <fromToServer>
    let mode = window.TARGET_ENV
    let int_active_vacancies = 0
    let int_total_vacancies = 0
    let selected_sub_opt
    let myChart_rep1
    let myChart_rep2
    let button_title = 'График'
    let is_show_chart = false
    let display_table1 = 'none'
    let display_table2 = 'none'

    def get_subdivisions
        if mode=="production"
            server.load("&action=get_subdivisions").then do |data|
                arrSubdivisions = data:data
                Imba.commit
        else
            arrSubdivisions = [{subdivisions_1: 'Подразделение 1'}, {subdivisions_1: 'Подразделение 2'}, {subdivisions_1: 'Подразделение 3'}]
            Imba.commit

    def changeSubdivisions e
        selected_sub_opt= e:_event:target:value
        get_report1 selected_sub_opt

    def get_report1 sText
        if mode=="production"
            params = '&'+ URLSearchParams.new({report: '1', subdivision: sText}).toString
            server.load("&action=get_report"+params).then do |data|
                tableData1 = data:data
                total tableData1
                removeDataChart1 myChart_rep1
                addDataChart1 myChart_rep1, tableData1
                Imba.commit
        else
            objData = await Conf("get_data_table_r1")
            if sText == 'Подразделение 1'
                objData = await Conf("tableDataReport1_v1")
            tableData1 = objData
            console.log sText
            # total tableData
            removeDataChart1 myChart_rep1
            addDataChart1 myChart_rep1, tableData1
            Imba.commit

    def get_report2 sText
        if mode=="production"
            params = '&'+ URLSearchParams.new({report: '2', subdivision: sText}).toString
            server.load("&action=get_report"+params).then do |data|
                tableData2 = data:data
                console.log tableData2
                total tableData2
                removeDataChart2 myChart_rep2
                addDataChart2 myChart_rep2, tableData2
                Imba.commit
        else
            objData = await Conf("get_data_table_r2")
            tableData2 = objData
            console.log sText
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
            title: {
                display: true,
                text: 'Отчёт 1',
                fontSize: 16
            },
            legend: {
                display: true,
                position: 'top'
            },
            scales: {
                xAxes: [{
                    stacked: true,
                    ticks: {
                        beginAtZero: true
                    },
                    scaleLabel: {
                        display: true,
                        labelString: 'Количество'
                    }
                }],
                yAxes: [{
                    stacked: true,
                    scaleLabel: {
                        display: true,
                        labelString: 'Вакансии'
                    }
                }]
            }
        }

        let conf = {
            type: 'horizontalBar',
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
            title: {
                display: true,
                text: 'Отчёт 2',
                fontSize: 16
            },
            legend: {
                display: true,
                position: 'top'
            },
            scales: {
                xAxes: [{
                    ticks: {
                        beginAtZero: true
                    },
                    scaleLabel: {
                        display: true,
                        labelString: 'Вакансии'
                    }
                }],
                yAxes: [{
                    scaleLabel: {
                        display: true,
                        labelString: 'Количество'
                    }
                }]
            },
            layout: {
                padding: {
                    left: 50,
                    right: 0,
                    top: 0,
                    bottom: 0
                }
            }   
        }

        let conf = {
            type: 'bar',
            data: chart_data,
            options: chart_options
        }

        myChart_rep2=Chart.new ctx, conf


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
        selected_sub_opt = undefined
        is_show_chart = false
        button_title = 'График'
        tableConfig1 = await Conf("get_conf_table_r1")
        tableConfig2 = await Conf("get_conf_table_r2")
        get_chart1
        get_chart2
        get_subdivisions
        get_report1
        get_report2

    def render
        <self>
            <div.report_options>
                <fieldset>
                    <legend>
                        <b> "Фильтр"
                    <div.report_options-div>    
                        <select.select-css :change.changeSubdivisions>
                            <option  selected=(selected_sub_opt==undefined) value="undefined"> "Все управления"
                            for item in arrSubdivisions
                                <option selected=(selected_sub_opt==item:subdivisions_1) value=item:subdivisions_1> item:subdivisions_1
                        <select.select-css>
                            <option  value="undefined"> "Все отделы"
                        <select.select-css.select-css_big>
                            <option disabled selected=(selected_sub_opt==undefined) value="undefined"> "Резюме, собеседования за период"          
            <div.content_chart>
                <div.content_chart1>
                    <div.content_button>
                        <button.button-css disabled=(tableData1:length==0) :click=(do button_selection 'left')>
                    <canvas id="myChart1">
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
                <div.content_chart2> 
                    <div.content_button>
                        <button.button-css disabled=(tableData2:length==0) :click=(do button_selection 'right')>                               
                    <canvas id="myChart2">
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

