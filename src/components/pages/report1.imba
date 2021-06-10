import {fromToServer} from '../util/fromToServer'
import {Conf} from '../../server'

export tag Report1

    let tableData=[]
    let tableConfig=[]
    let server = <fromToServer>
    let mode = window.TARGET_ENV
    let _path =  mode!='production' ? '' : window.PUBLIC_PATH

    def get_report1 sText
        if mode=="production"
            console.log 'ddd'
        else
            tableData = await Conf("get_data_table_r1")
            
    def get_chart sText
        let ctx = document.getElementsByClassName("myChart").item(0)
        let conf = {
            type: 'bar',
            data: {
                labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
                datasets: [{
                    label: '# of Votes',
                    data: [12, 19, 3, 5, 2, 3],
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(153, 102, 255, 0.2)',
                        'rgba(255, 159, 64, 0.2)'
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(255, 159, 64, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero: true
                        }
                    }]
                }
            }
        }
        let myChart=new Chart(ctx, conf)

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
                            <tr>
                                <td css:width="300px"> item:vacancies
                                <td css:width="100px"> item:active_vacancies
                                <td css:width="150px"> item:total_vacancies
            <div>
                <canvas.myChart>
            <button.btn.btn--middle .arg_footer-btn :click=(do get_chart)> "chart"

