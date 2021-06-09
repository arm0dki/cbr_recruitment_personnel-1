var mode = window.TARGET_ENV
var publicPath =  mode!='production' ? '' : window.PUBLIC_PATH

export var oConfTableReport1=[
	{title:'Вакансия', width:'300px'},
	{title:'Активных вакансий', width:'100px'},
	{title:'Всего вакансий', width:'100px'}
]

export var tableDataReport1=[
	{vacancies: 'Главный эксперт', active_vacancies: 2, total_vacancies: 10},
	{vacancies: 'Ведущий эксперт', active_vacancies: 5, total_vacancies: 10},
	{vacancies: 'Эксперт', active_vacancies: 8, total_vacancies: 10}

]

var endpoints = {
	'get_conf_table_r1': oConfTableReport1
	'get_data_table_r1': tableDataReport1
}

export def Conf url
	Promise.new do |resolve,reject|
		let data = endpoints[url]
#		
#		if let m = url.match(/\/customers\/(\w+).json/)
#			data = customers.filter(do |item| item:id == m[1])[0]
#
#		if let m = url.match(/\/customers\/(\w+)\/orders.json/)
#			data = orders.filter(do |item| order:custid == m[1])
#
		if data
			setTimeout(&,50) do resolve(data)
		else
			resolve(null)
			