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
