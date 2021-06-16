import {fromToServer} from '../util/fromToServer'
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

    def get_subdivisions
        if mode=="production"
            server.load("&action=get_subdivisions").then do |data|
                arrSubdivisions = data:data
                Imba.commit
        else
            arrSubdivisions = ['роль 1', 'роль 2', 'роль 3']

    def changeSubdivisions e
        selected_sub_opt= e:_event:target:value
        get_report2 selected_sub_opt

    def get_report2 sText
        let params_subdivisions
        if mode=="production"
            params_subdivisions = (sText == "Все подрозделения" ? undefined : sText)
            params = '&'+ URLSearchParams.new({report: '2', subdivision: params_subdivisions}).toString
            server.load("&action=get_report"+params).then do |data|
                console.log data
                tableData = data:data
                Imba.commit
                setTimeout(&,100) do get_chart tableData
        else
            objData = await Conf("get_data_table_r2")
            tableData = objData
            params_subdivisions = (sText == "Все подрозделения" ? undefined : sText)
            console.log params_subdivisions
            Imba.commit
            setTimeout(&,100) do get_chart objData
            
    def get_chart oData
        let ctx = document.getElementById('myChart');
        let conf = {
            type: 'bar',
            data: {
                labels: oData:labels,
                datasets: [{
                    label: 'Направлено реэюме заказчику',
                    data: oData:resume,
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    borderColor: 'rgb(75, 192, 192)',
                    borderWidth: 1,
                    order: 1
                },{
                    label: 'Интервью с заказчиком',
                    data: oData:interview,
                    backgroundColor: 'rgba(255, 99, 132, 0.2)',
                    borderColor: 'rgb(255, 99, 132)',
                    borderWidth: 1,
                    order: 2
                },{
                    label: 'Финалисты',
                    data: oData:finalists,
                    backgroundColor: 'rgba(24, 166, 12, 0.2)',
                    borderColor: 'rgb(24, 99, 12)',
                    borderWidth: 1,
                    order: 3
                }]
            },
            options: {
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
        }
        let myChart=Chart.new ctx, conf

    def mount
        selected_sub_opt = undefined
        tableConfig = await Conf("get_conf_table_r2")
        get_report2
        get_subdivisions

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
                                    <td> item:vacancies
                                    <td css:text-align="right"> item:resume
                                    <td css:text-align="right"> item:interview
                                    <td css:text-align="right"> item:finalists
                            else
                                <tr>
                                    <td.total> item:vacancies
                                    <td.total css:text-align="right"> item:resume
                                    <td.total css:text-align="right"> item:interview
                                    <td.total css:text-align="right"> item:finalists
                        
            <div.content_chart>
                <canvas id="myChart" width="500" height="200">

