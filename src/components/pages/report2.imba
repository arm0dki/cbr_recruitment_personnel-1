import {fromToServer} from '../util/fromToServer'
import {arraySum} from '../util/helpers'
import {Conf} from '../../server'

export tag Report2

    let tableData=[]
    let arrSubdivisions=[]
    let objData={}
    let tableConfig=[]
    let server = <fromToServer>
    let mode = window.TARGET_ENV
    let int_active_vacancies = 0
    let int_total_vacancies = 0
    let selected_sub_opt
    let myChart_rep2
    let button_title = 'График'
    let is_show_chart = false
    let display_table = 'flex'
    let display_chart = 'none'

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
        get_report2 selected_sub_opt

    def get_report2 sText
        if mode=="production"
            params = '&'+ URLSearchParams.new({report: '2', subdivision: sText}).toString
            server.load("&action=get_report"+params).then do |data|
                tableData = data:data
                console.log tableData
                total tableData
                removeDataChart myChart_rep2
                addDataChart myChart_rep2, tableData
                Imba.commit
        else
            objData = await Conf("get_data_table_r2")
            tableData = objData
            console.log sText
            total tableData
            removeDataChart myChart_rep2
            addDataChart myChart_rep2, tableData
            Imba.commit

    def get_chart
        let ctx = document:getElementById('myChart')
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
                text: '',
                fontSize: 16
            },
            legend: {
                display: true,
                position: 'bottom'
            },
            scales: {
                xAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }]
            }
        }

        let conf = {
            type: 'bar',
            data: chart_data,
            options: chart_options
        }

        myChart_rep2=Chart.new ctx, conf

    def addDataChart chart, data
        console.log data
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

    def removeDataChart chart
        chart:data:labels = []
        chart:data:datasets:forEach(do |dataset|
            dataset:data = []
        )
        chart:update()

    def button_selection
        is_show_chart = (is_show_chart) ? false : true
        if is_show_chart
            button_title = 'Таблица'
            display_table = 'none'
            display_chart = 'flex'
        else
            button_title = 'График'
            display_table = 'flex'
            display_chart = 'none'

    def total obj
        let total = {}
        total:vacancies = 'Общий итог'
        total:resume = arraySum obj:resume
        total:interview = arraySum obj:interview
        total:finalists = arraySum obj:finalists
        obj:data:push(total)
            
    def mount
        selected_sub_opt = undefined
        is_show_chart = false
        button_title = 'График'
        tableConfig = await Conf("get_conf_table_r2")
        get_subdivisions
        get_chart
        get_report2

    def unmount
        myChart_rep2:destroy()

    def render
        <self>
            <div.report_options>
                <fieldset>
                    <legend>
                        <b> "Настройки"
                    <div.report_options-div>
                        <select.select-css :change.changeSubdivisions>
                            <option selected=(selected_sub_opt==undefined) value="undefined"> "Все подразделения"
                            for item in arrSubdivisions
                                <option selected=(selected_sub_opt==item:subdivisions_1) value=item:subdivisions_1> item:subdivisions_1
                        <button.button-css.button-svg_table=(is_show_chart == true) :click=(do button_selection) disabled=(tableData:length==0)> button_title
            <div.content_table css:display="{display_table}">
                <table.table>
                    <thead.font--small=(tableConfig:length>6)>
                        <tr>
                            for item,index in tableConfig
                                <th.th_left=(index==0) css:width="{item:width}">
                                    if item:title
                                        <span> item:title
                    <tbody>
                        for item in tableData:data
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
            <div.content_chart css:display="{display_chart}">
                <canvas id="myChart">

