import {fromToServer} from '../util/fromToServer'
import {Conf} from '../../server'

export tag Report1

    let tableData=[]
    let arrSubdivisions=[]
    let objData={}
    let tableConfig=[]
    let server = <fromToServer>
    let mode = window.TARGET_ENV
    let _path =  mode!='production' ? '' : window.PUBLIC_PATH
    let int_active_vacancies = 0
    let int_total_vacancies = 0
    let selected_sub_opt

    def get_subdivisions
        if mode=="production"
            server.load("&action=get_subdivisions").then do |data|
                arrSubdivisions = data:data
                Imba.commit
        else
            arrSubdivisions = ['роль 1', 'роль 2', 'роль 3']

    def changeSubdivisions e
        selected_sub_opt= e:_event:target:value
        get_report1 selected_sub_opt

    def get_report1 sText
        let params_subdivisions
        if mode=="production"
            params_subdivisions = (sText == "Все подрозделения" ? undefined : sText)
            params = '&'+ URLSearchParams.new({report: '1', subdivision: params_subdivisions}).toString
            server.load("&action=get_report_data"+params).then do |data|
                tableData = data:data
                Imba.commit
                setTimeout(&,100) do get_chart tableData
        else
            objData = await Conf("get_data_table_r1")
            tableData = objData:data
            params_subdivisions = (sText == "Все подрозделения" ? undefined : sText)
            console.log params_subdivisions
            Imba.commit
            setTimeout(&,100) do get_chart objData
            
    def get_chart oData
        let ctx = document.getElementById('myChart');
        let conf = {
            type: 'horizontalBar',
            data: {
                labels: oData:labels,
                datasets: [{
                    label: 'Активных',
                    data: oData:active_vacancies,
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    borderColor: 'rgb(75, 192, 192)',
                    borderWidth: 1,
                    order: 1
                },{
                    label: 'Всего',
                    data: oData:total_vacancies,
                    backgroundColor: 'rgba(255, 99, 132, 0.2)',
                    borderColor: 'rgb(255, 99, 132)',
                    borderWidth: 1,
                    order: 2
                }]
            },
            options: {
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
        }
        let myChart=Chart.new ctx, conf

    def mount
        selected_sub_opt = undefined
        tableConfig = await Conf("get_conf_table_r1")
        get_report1
        get_subdivisions

    def render
        <self>
            <div.filter>
                <fieldset>
                    <legend>
                        <b> "Фильтр"
                    <select.select-css :change.changeSubdivisions>
                        <option selected=(selected_sub_opt==undefined)> "Все подрозделения"
                        for item in get_subdivisions
                            <option selected=(selected_sub_opt==item) value=item> item
            <div.content_table>
                <table.table>
                    <thead.font--small=(tableConfig:length>6)>
                        <tr>
                            for item in tableConfig
                                <th css:width="{item:width}">
                                    if item:title
                                        <span> item:title
                    <tbody>
                        for item in tableData
                            if item:vacancies != 'Общий итог'
                                <tr>
                                    <td> item:vacancies
                                    <td css:text-align="right"> item:active_vacancies
                                    <td css:text-align="right"> item:total_vacancies
                            else
                                <tr>
                                    <td.total> item:vacancies
                                    <td.total css:text-align="right"> item:active_vacancies
                                    <td.total css:text-align="right"> item:total_vacancies
                        
            <div.content_chart>
                <canvas id="myChart" width="500" height="100">

