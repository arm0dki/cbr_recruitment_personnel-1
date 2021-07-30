import './main_page.styl'
import {Report} from './report.imba'
import {Report1} from './report1.imba'
import {Report2} from './report2.imba'
import {StartPage} from './start_page'


var mode = window.TARGET_ENV
var _path =  mode!='production' ? '' : 'view_doc.html?mode=cbr_recruitment_personnel&page='

export tag MainPage

	def render
		<self>
			<div.recruitment_header-title>
				<h1> 'Отчеты по подбору для руководителя СП'
			<div.recruitment_content>
				<Report route="/{_path}report">
