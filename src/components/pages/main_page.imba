import './main_page.styl'
import {ListExceptions} from './list_exceptions.imba'
import {ListUser} from './list_users.imba'
import {StartPage} from './start_page'

var mode = window.TARGET_ENV
var _path =  mode!='production' ? '' : 'view_doc.html?mode=sued_exceptions_v2&page='

export tag MainPage

	def render
		<self>
			<div.admin_exceptions_header-title>
				<h1> 'Администрирование исключений СУЭД'
			<div.admin_exceptions_menu>
				<span route-to="/{_path}list_exceptions"> "Список исключений"
				<span route-to="/{_path}list_users"> "Список всех пользователей"
			<div.admin_exceptions_content>
				# <StartPage route="/{_path.replace('&page=','')}/*$">
				<StartPage route="/{_path}start_page">
				<ListExceptions route="/{_path}list_exceptions">
				<ListUser route="/{_path}list_users">