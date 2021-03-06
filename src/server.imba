var mode = window.TARGET_ENV
var publicPath =  mode!='production' ? '' : window.PUBLIC_PATH

export var oConfTableReport1=[
	{title:'Вакансии', width:'30vw'},
	{title:'Активных вакансий', width:'10vw'},
	{title:'Всего вакансий', width:'10vw'}
]

export var oConfTableReport2=[
	{title:'Вакансии', width:'30vw'},
	{title:'Направлено заказчику', width:'11vw'},
	{title:'Интервью с заказчиком', width:'11vw'},
	{title:'Финалистов', width:'11vw'}
]

export var tableDataReport1={data: [
	{vacancies: 'Главный эксперт', active_vacancies: 2, total_vacancies: 10},
	{vacancies: 'Ведущий эксперт', active_vacancies: 5, total_vacancies: 10},
	{vacancies: 'Эксперт', active_vacancies: 8, total_vacancies: 10}], 
labels: ['Главный экспер', 'Ведущий экспер', 'Эксперт'], 
active_vacancies: [3,5,8], 
total_vacancies: [10,10,10]
}

export var tableDataReport1_v1={data: [
	{vacancies: 'Главный эксперт1', active_vacancies: 5, total_vacancies: 50},
	{vacancies: 'Ведущий эксперт2', active_vacancies: 5, total_vacancies: 50},
	{vacancies: 'Ведущий эксперт3', active_vacancies: 5, total_vacancies: 50},
	{vacancies: 'Ведущий эксперт4', active_vacancies: 5, total_vacancies: 50},
	{vacancies: 'Эксперт1', active_vacancies: 10, total_vacancies: 20}], 
labels: ['Главный экспер1', 'Ведущий экспер1', 'Ведущий экспер2', 'Ведущий экспер3', 'Ведущий экспер4', 'Эксперт1'], 
active_vacancies: [5,5,5,5,5,10], 
total_vacancies: [50,50,50,50,50,20]
}

export var tableDataReport2={data: [
	{vacancies: 'Главный эксперт', resume: 20, interview: 50, finalists: 0},
	{vacancies: 'Ведущий эксперт', resume: 30, interview: 50, finalists: 40},
	{vacancies: 'Эксперт', resume: 40, interview: 50, finalists: 50}], 
labels: ['Главный экспер', 'Ведущий экспер', 'Эксперт'], 
resume: [20,30,40], 
interview: [50,50,50],
finalists: [0,40,50]
}

export var arr_report_options = {subdivisions_1: [
	{subdivisions_1_id: 1111111, subdivisions_1: 'Управление 1'}, 
	{subdivisions_1_id: 1111112, subdivisions_1: 'Управление 2'}, 
	{subdivisions_1_id: 1111113, subdivisions_1: 'Управление 3'}],
subdivisions_2: [
	{subdivisions_2_id: 2222222, subdivisions_1_id: 1111111, subdivisions_2: 'Отдел 1'}, 
	{subdivisions_2_id: 2222221, subdivisions_1_id: 1111111, subdivisions_2: 'Отдел 2'}, 
	{subdivisions_2_id: 2222223, subdivisions_1_id: 1111113, subdivisions_2: 'Отдел 3'}],
period: [
	{month_id: 1, month_name: 'Январь'}, 
	{month_id: 2, month_name: 'февраль'}, 
	{month_id: 3, month_name: 'март'}]
}

var endpoints = {
	'get_conf_table_r1': oConfTableReport1,
	'get_data_table_r1': tableDataReport1,
	'tableDataReport1_v1': tableDataReport1_v1,
	'get_conf_table_r2': oConfTableReport2,
	'get_data_table_r2': tableDataReport2,
	'get_report_options': arr_report_options	
}

export def Conf url
	Promise.new do |resolve,reject|
		let data = endpoints[url]
		if data
			setTimeout(&,50) do resolve(data)
		else
			resolve(null)
			