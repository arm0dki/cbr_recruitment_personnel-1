var mode = window.TARGET_ENV
var publicPath =  mode!='production' ? '' : window.PUBLIC_PATH

export var oConfTableReport1=[
	{title:'Вакансии', width:'30vw'},
	{title:'Активных вакансий', width:'5vw'},
	{title:'Всего вакансий', width:'5vw'}
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

var endpoints = {
	'get_conf_table_r1': oConfTableReport1
	'get_data_table_r1': tableDataReport1
}

export def Conf url
	Promise.new do |resolve,reject|
		let data = endpoints[url]
		if data
			setTimeout(&,50) do resolve(data)
		else
			resolve(null)
			