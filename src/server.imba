var mode = window.TARGET_ENV
var publicPath =  mode!='production' ? '' : window.PUBLIC_PATH

export var oConfTableReport1=[
	{title:'Вакансии', width:'30vw'},
	{title:'Активных вакансий', width:'5vw'},
	{title:'Всего вакансий', width:'5vw'}
]

export var oConfTableReport2=[
	{title:'Вакансии', width:'30vw'},
	{title:'Направлено заказчик', width:'5vw'},
	{title:'Интервью с заказчик', width:'5vw'},
	{title:'Количество по полю финансы', width:'5vw'}
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
	{vacancies: 'Главный эксперт', resume: 2, interview: 5, finalists: 0},
	{vacancies: 'Ведущий эксперт', resume: 3, interview: 5, finalists: 4},
	{vacancies: 'Эксперт', resume: 4, interview: 5, finalists: 5},
	{vacancies: 'Общий итог', resume: 9, interview: 15, finalists: 9}], 
labels: ['Главный экспер', 'Ведущий экспер', 'Эксперт'], 
resume: [2,3,4], 
interview: [5,5,5],
finalists: [0,4,5]
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
			