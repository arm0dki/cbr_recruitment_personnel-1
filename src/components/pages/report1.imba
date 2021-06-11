import {fromToServer} from '../util/fromToServer'
import {Conf} from '../../server'

export tag Report1

    let tableData=[]
    let objData={}
    let tableConfig=[]
    let server = <fromToServer>
    let mode = window.TARGET_ENV
    let _path =  mode!='production' ? '' : window.PUBLIC_PATH
    let int_active_vacancies = 0
    let int_total_vacancies = 0

    def get_report1 sText
        if mode=="production"
            console.log 'ddd'
        else
            objData = await Conf("get_data_table_r1")
            tableData = objData:data
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
        tableConfig = await Conf("get_conf_table_r1")
        get_report1

    def render
        <self>
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
                                    <td> item:active_vacancies
                                    <td> item:total_vacancies
                            else
                                <tr>
                                    <td css:background="#e1e4f1"> item:vacancies
                                    <td css:background="#e1e4f1"> item:active_vacancies
                                    <td css:background="#e1e4f1"> item:total_vacancies
                        
            <div.content_chart>
                <canvas id="myChart" width="500" height="100">

