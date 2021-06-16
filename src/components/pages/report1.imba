import {fromToServer} from '../util/fromToServer'
import {Conf} from '../../server'

export tag Report1

    let tableData=[]
    let arrSubdivisions=[]
    let objData={}
    let tableConfig=[]
    let server = <fromToServer>
    let mode = window.TARGET_ENV
    let int_active_vacancies = 0
    let int_total_vacancies = 0
    let selected_sub_opt
    let myChart

    def get_subdivisions
        if mode=="production"
            server.load("&action=get_subdivisions").then do |data|
                arrSubdivisions = data:data
                Imba.commit
        else
            arrSubdivisions = [{subdivisions_1: 'роль 1'}, {subdivisions_1: 'роль 2'}, {subdivisions_1: 'роль 3'}]

    def changeSubdivisions e
        selected_sub_opt= e:_event:target:value
        get_report1 selected_sub_opt

    def get_report1 sText
        let params_subdivisions
        if mode=="production"
            params_subdivisions = (sText == "Все подрозделения" ? undefined : sText)
            params = '&'+ URLSearchParams.new({report: '1', subdivision: params_subdivisions}).toString
            server.load("&action=get_report"+params).then do |data|
                tableData = data:data
                setTimeout(&,100) do get_chart tableData
                Imba.commit
        else
            objData = await Conf("get_data_table_r1")
            tableData = objData
            params_subdivisions = (sText == "Все подрозделения" ? undefined : sText)
            console.log params_subdivisions
            addDataChart myChart, tableData
            # removeDataChart chart
            Imba.commit

    def get_chart
        let ctx = document:getElementById('myChart')
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
                text: '',
                fontSize: 16
            },
            legend: {
                display: true,
                position: 'right'
            },
            scales: {
                xAxes: [{
                    stacked: true,
                    ticks: {
                        beginAtZero: true
                    }
                }],
                yAxes: [{
                    stacked: true
                }]
            }
        }

        let conf = {
            type: 'horizontalBar',
            data: chart_data,
            options: chart_options
        }

        myChart=Chart.new ctx, conf
        # myChart:destroy()

    def addDataChart chart, data
        console.log 'addDataChart'
        console.log chart
        console.log data

        chart:data:labels:push(data:labels)
        chart:data:datasets:forEach(do |dataset|
            if dataset:order == 1
                dataset:data:push(data:active_vacancies)
            else if dataset:order == 2
                dataset:data:push(data:total_vacancies)
        )
        console.log 'update'
        console.log chart
        chart:update()

    def removeDataChart chart
        chart:data:labels:pop()
        chart:data:datasets:forEach(do |dataset|
            dataset:data:pop()
        )
        chart:update()

    def mount
        selected_sub_opt = undefined
        tableConfig = await Conf("get_conf_table_r1")
        get_chart
        get_subdivisions
        get_report1

    def render
        <self>
            <div.filter>
                <fieldset>
                    <legend>
                        <b> "Фильтр"
                    <select.select-css :change.changeSubdivisions>
                        <option selected=(selected_sub_opt==undefined)> "Все подрозделения"
                        for item in arrSubdivisions
                            <option selected=(selected_sub_opt==item:subdivisions_1) value=item:subdivisions_1> item:subdivisions_1
            <div.content_table>
                <table.table>
                    <thead.font--small=(tableConfig:length>6)>
                        <tr>
                            for item in tableConfig
                                <th css:width="{item:width}">
                                    if item:title
                                        <span> item:title
                    <tbody>
                        for item in tableData:data
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
                        
            <div.content_chart>
                <canvas id="myChart">

