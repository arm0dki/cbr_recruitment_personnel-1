import {fromToServer} from '../util/fromToServer'
import {arraySum} from '../util/helpers'
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
            arrSubdivisions = [{subdivisions_1: 'роль 1'}, {subdivisions_1: 'роль 2'}, {subdivisions_1: 'роль 3'}]
            Imba.commit

    def changeSubdivisions e
        selected_sub_opt= e:_event:target:value
        get_report1 selected_sub_opt

    def get_report1 sText
        if mode=="production"
            params = '&'+ URLSearchParams.new({report: '1', subdivision: sText}).toString
            server.load("&action=get_report"+params).then do |data|
                tableData = data:data
                total tableData
                removeDataChart myChart
                addDataChart myChart, tableData
                Imba.commit
        else
            objData = await Conf("get_data_table_r1")
            tableData = objData
            console.log sText
            total tableData
            removeDataChart myChart
            addDataChart myChart, tableData
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

    def addDataChart chart, data
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
        total:active_vacancies = arraySum obj:active_vacancies
        total:total_vacancies = arraySum obj:total_vacancies
        obj:data:push(total)

    def mount
        selected_sub_opt = undefined
        is_show_chart = false
        button_title = 'График'
        tableConfig = await Conf("get_conf_table_r1")
        get_chart
        get_subdivisions
        get_report1

    def render
        <self>
            <div.report_options>
                <fieldset>
                    <legend>
                        <b> "Настройки"
                    <select.select-css :change.changeSubdivisions>
                        <option  selected=(selected_sub_opt==undefined) value="undefined"> "Все подрозделения"
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
                                    <td css:text-align="right" css:width="10vw"> item:active_vacancies
                                    <td css:text-align="right" css:width="10vw"> item:total_vacancies
                            else
                                <tr>
                                    <td.total css:width="30vw"> item:vacancies
                                    <td.total css:text-align="right" css:width="10vw"> item:active_vacancies
                                    <td.total css:text-align="right" css:width="10vw"> item:total_vacancies            
            <div.content_chart css:display="{display_chart}">
                <canvas id="myChart">

