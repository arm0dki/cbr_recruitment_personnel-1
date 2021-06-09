import './main_page.styl'
import {Report1} from './report1.imba'
import {Report2} from './report2.imba'


var mode = window.TARGET_ENV
var _path =  mode!='production' ? '' : 'view_doc.html?mode=recruitment_personnel&page='

export tag MainPage

	def render
		<self>
			<div.recruitment_header-title>
				<h1> 'Отчётность для рекрутеров'
			<div.recruitment_menu>
				<span route-to="/{_path}report1"> "Отчёт 1"
				<span route-to="/{_path}report2"> "Отчёт 2"
			<div.recruitment_content>
				<Report1 route="/{_path}report1">
				<Report2 route="/{_path}report2">