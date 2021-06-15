var mode = window.TARGET_ENV
var publicPath =  mode!='production' ? '' : window.PUBLIC_PATH

export var oConfTableReport1=[
	{title:'Вакансии', width:'30vw'},
	{title:'Активных вакансий', width:'10vw'},
	{title:'Всего вакансий', width:'10vw'}
]

export var oConfTableReport2=[
	{title:'Вакансии', width:'30vw'},
	{title:'Направлено заказчик', width:'10vw'},
	{title:'Интервью с заказчик', width:'10vw'},
	{title:'Количество по полю финансы', width:'10vw'}
]

export var tableDataReport1={data: [
	{vacancies: 'Главный эксперт', active_vacancies: 2, total_vacancies: 10},
	{vacancies: 'Ведущий эксперт', active_vacancies: 5, total_vacancies: 10},
	{vacancies: 'Эксперт', active_vacancies: 8, total_vacancies: 10},
	{vacancies: 'Общий итог', active_vacancies: 15, total_vacancies: 30}], 
labels: ['Главный экспер', 'Ведущий экспер', 'Эксперт'], 
active_vacancies: [3,5,8], 
total_vacancies: [10,10,10]
}

export var tableDataReport2={data: [
	{vacancies: 'Главный эксперт', resume: 20, interview: 50, finalists: 0},
	{vacancies: 'Ведущий эксперт', resume: 30, interview: 50, finalists: 40},
	{vacancies: 'Эксперт', resume: 40, interview: 50, finalists: 50},
	{vacancies: 'Общий итог', resume: 90, interview: 150, finalists: 90}], 
labels: ['Главный экспер', 'Ведущий экспер', 'Эксперт'], 
resume: [20,30,40], 
interview: [50,50,50],
finalists: [0,40,50]
}

var endpoints = {
	'get_conf_table_r1': oConfTableReport1,
	'get_data_table_r1': tableDataReport1,
	'get_conf_table_r2': oConfTableReport2,
	'get_data_table_r2': tableDataReport2
}

export def Conf url
	Promise.new do |resolve,reject|
		let data = endpoints[url]
		if data
			setTimeout(&,50) do resolve(data)
		else
			resolve(null)
			