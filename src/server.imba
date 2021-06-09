var mode = window.TARGET_ENV
var publicPath =  mode!='production' ? '' : window.PUBLIC_PATH

export var get_start_page = {
	"data":{"role":"admin","person_id":"6813732291949127927"}
	"mess":"OK"
	"code":"1"
}


export var tu = [
		{id: 1, depart:"ЦА", participant_count:"3",all_count:"15"}
		{id: 2, depart:"ГУ по ЦФО", participant_count:"0",all_count:"0"}
		{id: 3, depart:"Волго-Вятское ГУ", participant_count:"0",all_count:"0"}
		{id: 4, depart:"Дальневосточное ГУ", participant_count:"1",all_count:"15"}
		{id: 5, depart:"Уральское ГУ", participant_count:"3",all_count:"9"}
		{id: 6, depart:"Северо-Западное ГУ", participant_count:"0",all_count:"0"}
		{id: 7, depart:"Сибирское ГУ", participant_count:"2",all_count:"15"}
		{id: 8, depart:"Южное ГУ", participant_count:"0",all_count:"0"}
]

export var member = [
		{depart:"ЦА", fullname:"Иванов Иван Иванович", position:"эксперт"}
		{depart:"ЦА", fullname:"Петров Петр Петрович", position:"эксперт"} 
		{depart:"ЦА", fullname:"Загогулька Иван Сидорович", position:"эксперт"}
		{depart:"Сибирское ГУ", fullname:"Иванов Иван Иванович", position:"эксперт"}
		{depart:"Сибирское ГУ", fullname:"Иванов Иван Иванович", position:"эксперт"}
		{depart:"Дальневосточное ГУ", fullname:"Иванов Иван Иванович", position:"эксперт"}
		{depart:"Уральское ГУ", fullname:"Шипин Сергей Петрович", position:"эксперт"}
		{depart:"Уральское ГУ", fullname:"Хрулин Юрий Андреевич", position:"эксперт"}
		{depart:"Уральское ГУ", fullname:"Уральский Урал Уралович", position:"эксперт"}
]

export var get_agreement = {
	agreement_id: "526985623"
	status: "new" # "new" "on_accept", "refill", "active", "deleted", "finished"
	assign_date: "2021-01-31T12:42:17.317Z"
	mentor:{fullname:"Иванов Иван Иванович", position:"главный инженер",phone:"+7(951)562-44-55",email:"IvanovII@cbr.mail.ru",r_tel:"(232) 19-19", pict_url: publicPath+"./img/man_PNG6526.png"}
	student:{fullname:"Петров Георгий Сергеевич", position:"ведущий специалист",phone:"+7(856)524 22-22",email:"PetrovGS@cbr.mail.ru",r_tel:"(232) 19-63", pict_url: publicPath+"./img/skeleton.png"}
	start_date: "21.12.2020"
	state : {id: "new", name: "Новое", color: ""}
	end_date: "21.12.2021"
	meeting_duration:"Раз в неделю"
	communication_method_mentor: "Корпоративная почта"
	targets:[
		{name:"Освоить основы выпечки", result:"Уметь завести тесто и сделать пирожок"} 
		{name:"Освоить основы выпечки", result:"Уметь завести тесто и сделать пирожок"} 
		{name:"Научиться вышивать крестиком", result:"Уметь вышить по картинке"}
	]
}

export var get_agreement_sub_lists={
	agreement_id: "526985623"
	arr_meetings:["По потребностям","Раз в неделю","Раз в полгода"]
	arr_connections:["Корпоративная почта","Рабочий телефон"]
}	

export var get_techsupport = [
	{link:"123",type:"metod",fullname: "Иванов Иван Иванович", depart:"Департамент кадровой политики", pozition: "Главный эксперт", tel:["21-23","(323) 17-12"]}
	{link:"123",type:"metod",fullname: "Иванов Иван Петрович", depart:"Департамент кадровой политики", pozition: "Главный эксперт", tel:["7-17",""]}
	{link:"123",type:"metod",fullname: "Кирилов Антон Силуанович", depart:"Департамент кадровой политики", pozition: "Ведущий эксперт", tel:["7-23",""]}
	{link:"123",type:"tech",fullname: "Васякин Петр Иванович", depart:"Департамент информатизации", pozition: "Ведущий инженер-программист", tel:["1-15-77",""]}
	{link:"123",type:"tech",fullname: "Пузякин Иван Шишкович", depart:"Департамент информатизации", pozition: "инженер-программист", tel:["1-55-84",""]}
	{link:"123",type:"tech",fullname: "Хренкин Кузьма Иванович", depart:"Департамент информатизации\nОтдел системного администрирования", pozition: "Главный инженер-программист", tel:["1-55-45",""]}
]

export var get_competence_groups = [
	{id:"59669205662", name:"Лидерские компетенции"}
	{id:"59669205663", name:"Профессиональные компетенции"}
	{id:"59669205664", name:"Управленческие компетенции"}
	{id:"59669205665", name:"Наставник для новичка"}
]

export var get_competences_list = [
		{person_id:"60", pict_url: publicPath+"./img/skeleton.png", person_fullname:"Иванов Иван Иванович", position_name: "Инженер программист 1 категории",subdivision_name:"Департамент",competences:[{competence_id: "6574674", competence_name: "Работа в MS Excel"},{competence_id: "6574674", competence_name: "компетенция 2"}]}
		{person_id:"61", pict_url: publicPath+"./img/man_PNG6526.png", person_fullname:"Петров Петр Петрович", position_name: "Инженер программист 1 категории",subdivision_name:"Департамент",competences:[{competence_id: "6574674", competence_name: "Тестирование больших данных"}]}
		{person_id:"61", pict_url: "", person_fullname:"Петров Петр Петрович", position_name: "Инженер программист 1 категории",subdivision_name:"Департамент",competences:[{competence_id: "6574674", competence_name: "компетенция 2"}]}
	]

export var get_member_info = {
	memberinfo:{person_id:"61", pict_url: publicPath+"./img/skeleton.png", person_fullname:"Петров Иван Иванович", position_name: "Инженер программист 1 категории",subdivision_name:"Территориальное управление"}
	mycounter:{vacancy: 3, request: 1, mentored: 2}
	competences:[{group_name:"Лидерские компетенции", competence_name:"Лидерство" },{group:"Управленческие компетенции", name:"Гибкость: открытость для новых способов работы" }]
	myMentored:[{person_id:'60', pict_url: publicPath+"./img/skeleton.png", person_fullname:"Кирилов Антон Силуанович", subdivision_name:"Департамент кадровой политики", position_name: "Ведущий эксперт"},{person_id:'61',pict_url: publicPath+"./img/man_PNG6526.png",person_fullname: "Сивый Андрей Андреевия", subdivision_name:"Сибирское ГУ, Отделение томск, отдел информатизации", position_name: "Ведущий инженер-программист"}]
	aboutme:{
		text_to_students: "Буду рада передать свои знания и опыт сотрудникам, заинтересованным в своем развитии и развитии своих коллективов"
		text_to_mentors: "Хочу научиться"
		arrEducations: ["Сибирский Федеральный университет"," МГУ"]
		arrProjects: ["Проекты по оценке, развитию и обучению руководителей.","Проект 1"]
	}
}



export var aboutme={
	text_to_students: "Буду рада передать свои знания и опыт сотрудникам, заинтересованным в своем развитии и развитии своих коллективов"
	text_to_mentors: "Хочу научиться вышивать крестиком"
	educations: [{name: "Сибирский Федеральный университет"},{name: " МГУ"}]
	my_projects: [{name: "Проекты по оценке, развитию и обучению руководителей."},{name: "Проект 1"}]
}

export var get_my_mentor_data={
		slots_num: 2
		competences:[
			{state_id: 'on_accept', competence_id:"1", name:"Компетенция профессионала", group_name:"Профессиональные компетенции",requests_num: 0}
			{state_id: 'active', competence_id:"2", name:"Следуй за мной", group_name:"Лидерские компетенции",requests_num: 0}
			{state_id: 'active', competence_id:"3", name:"Управление сотрудниками", group_name:"Управленческие компетенции",requests_num: 1}
			{state_id: 'active', competence_id:"4", name:"Новая компетенция", group_name:"Профессиональные компетенции",requests_num: 2}
			{state_id: 'active',  competence_id:"5", name:"Компетенция в ожидании утверждения", group_name:"Профессиональные компетенции",requests_num: 0}
		]
		students:[
			{person_id:"123452", full_name: "Петров Петр Петрович", pict_url: publicPath+"./img/man_PNG6526.png", agreement_id:"86058743",state_id: 'on_accept'}
			{person_id:"345636", full_name: "Сидоров Сидор Сидорович", pict_url: publicPath+"", agreement_id:"345625546", state_id: 'active'}
		]
}	

export var get_my_mentors={
	requests:[
		{agreement_id: "23456773", state_id: 'new', person_id:"123456", person_fullname: "Иванов Иван Иванович", position_name: "Начальник отдела информатизации", subdivision_name: "Отделение Красноярск", pict_url: publicPath+"./img/skeleton.png", comp: "Компетенция 1", group: "Профессиональные компетенции", url:""}
		{agreement_id: "45632343", state_id: 'accepted', person_id:"123456", person_fullname: "Иванов Иван Иванович", position_name: "Начальник отдела информатизации", subdivision_name: "Отделение Красноярск", pict_url: publicPath+"./img/skeleton.png", comp: "Компетенция 1", group: "Профессиональные компетенции", url:""}
		{agreement_id: "45632343", state_id: 'rejected', person_id:"123456", person_fullname: "Иванов Иван Иванович", position_name: "Начальник отдела информатизации", subdivision_name: "Отделение Красноярск", pict_url: publicPath+"./img/skeleton.png", comp: "Компетенция 1", group: "Профессиональные компетенции", url:""}
	]
	mentors:[
		{agreement_id: "23456773", state_id: 'new', person_id:"123456", person_fullname: "Иванов Иван Иванович", position_name: "Начальник отдела информатизации", subdivision_name: "Отделение Красноярск", pict_url: publicPath+"./img/skeleton.png", comp: "Компетенция 1", group: "Профессиональные компетенции", url:""}
		{agreement_id: "45632343", state_id: 'on_accept', person_id:"123456", person_fullname: "Иванов Иван Иванович", position_name: "Начальник отдела информатизации", subdivision_name: "Отделение Красноярск", pict_url: publicPath+"./img/skeleton.png", comp: "Компетенция 1", group: "Профессиональные компетенции", url:""}
		{agreement_id: "45632343", state_id: 'refill', person_id:"123456", person_fullname: "Иванов Иван Иванович", position_name: "Начальник отдела информатизации", subdivision_name: "Отделение Красноярск", pict_url: publicPath+"./img/skeleton.png", comp: "Компетенция 1", group: "Профессиональные компетенции", url:""}
		{agreement_id: "45632343", state_id: 'active', person_id:"123456", person_fullname: "Иванов Иван Иванович", position_name: "Начальник отдела информатизации", subdivision_name: "Отделение Красноярск", pict_url: publicPath+"./img/skeleton.png", comp: "Компетенция 1", group: "Профессиональные компетенции", url:""}
		{agreement_id: "45632343", state_id: 'deleted', person_id:"123456", person_fullname: "Иванов Иван Иванович", position_name: "Начальник отдела информатизации", subdivision_name: "Отделение Красноярск", pict_url: publicPath+"./img/skeleton.png", comp: "Компетенция 1", group: "Профессиональные компетенции", url:""}
		{agreement_id: "45632343", state_id: 'finished', person_id:"123456", person_fullname: "Иванов Иван Иванович", position_name: "Начальник отдела информатизации", subdivision_name: "Отделение Красноярск", pict_url: publicPath+"./img/skeleton.png", comp: "Компетенция 1", group: "Профессиональные компетенции", url:""}
		{agreement_id: "45632343", state_id: 'rejected', person_id:"123456", person_fullname: "Иванов Иван Иванович", position_name: "Начальник отдела информатизации", subdivision_name: "Отделение Красноярск", pict_url: publicPath+"./img/skeleton.png", comp: "Компетенция 1", group: "Профессиональные компетенции", url:""}
	]
}

export var get_groups_with_competences=[
	{
		group_id: 123,		
		group_name: "Лидерские компетенции",
		competences: [
			{id: 1,
			name: 'Компетения 1',
			desc: 'Она поможет вам стать супер героем!'
			state_id: 'on_accept'
			is_assigned: false
			},
			{id: 2,
			name: 'Мыть полы',
			desc: 'Жена будет в восторге!'
			state_id: 'on_accept'
			is_assigned: false
			},
		]		

	},
	{
		group_id: 222,		
		group_name: "Личные компетенции",
		competences: [
			{id: 1,
			name: 'Красить стены' 
			},
			{id: 2,
			name: 'Крыть на стол' 
			},
		]		

	}
]
export var get_groups = [
	{id:1, name:'Лидерство'},
	{id:2, name:'Предпреимчивость'},
	{id:3, name:'Ловкость'},
]
export var get_choices_competences={
		compLider:["Инициативность","Лидерство","Партнерство","Системное мышление","Управление процессами"]
		compUprav:['Управление','Руководство']
		compProfi:['Профессионализм','Компетентность','Навыки']
		compNub:['Введение в специальность']
		arrGroupComp:{multy: false, group: ["Лидерские компетенции"]}
}
export var get_requests= [
	{desc:'adssaddadadadadada',id:1,name:'Запрос 1', person_id:111, person_fullname:'Шигаев Сергей Васильевич',state:{id:'new',name:'Новая',color:'black'}}
	{desc:'adssaddadadadadada',id:2,name:'Запрос 2', person_id:222, person_fullname:'Супаев Петр Иванович',state:{id:'accepted',name:'Согласована',color:'#00CC95'}}
	{desc:'adssaddadadadadada',id:3,name:'Запрос 3', person_id:333, person_fullname:'Кираев Андрей Петрович',state:{id:'rejected',name:'Отклонена',color:'#d00033'}}
	{desc:'adssaddadadadadada',id:4,name:'Запрос 4', person_id:444, person_fullname:'Пиргаев Вадим Игоревич',state:{id:'new',name:'Новая',color:'black'}}
]


export var get_collaborators_list = [
	{id:123,pict_url: publicPath+'../img/man_PNG6526.png', fullname:'Сергеев Артём Вадимович', position_name:'Главный эксперт', subdivision_name:'Департамент кадровой политики'}
	{id:222,pict_url: publicPath+'../img/man_PNG6526.png', fullname:'Антюфеев Алексей Фёдорович', position_name:'Начальник отдела', subdivision_name:'Управление HR-развития'}
	{id:333,pict_url: publicPath+'../img/man_PNG6526.png', fullname:'Малько Игнат Васильевич', position_name:'Эксперт', subdivision_name:'Отдел кадров'}
]
for item in [0...1000]
	get_collaborators_list.push({id:333,pict_url: publicPath+'../img/man_PNG6526.png', fullname:'Малько Игнат Васильевич', position_name:'Эксперт', subdivision_name:'Отдел кадров'})
export var get_choice_student = [
	{competence_id:25896523,student_id:123456,pict_url: publicPath+'../img/man_PNG6526.png', person_fullname:'Сергеев Артём Вадимович', position_name:'Главный эксперт', subdivision_name:'Департамент кадровой политики', explanations_name:"Хочу утиться только у Вас. Хочу двигаться в перед. Хочу развиваться как прфессионально так и духовно.", accept: false}
	{competence_id:25896523,student_id:134566,pict_url: publicPath+'../img/man_PNG6526.png', person_fullname:'Кулев Филип Андреевич', position_name:'Главный эксперт', subdivision_name:'Департамент кадровой политики', explanations_name:"Хочу уметь", accept: false}
	{competence_id:25896523,student_id:154566,pict_url: publicPath+'../img/man_PNG6526.png', person_fullname:'Лесник Андрей Филипович', position_name:'Главный эксперт', subdivision_name:'Департамент кадровой политики', explanations_name:"Хочу уметь", accept: false}
]
export var get_competences_on_accept =[
	{competence_id:1,pict_url: publicPath+'../img/man_PNG6526.png', person_id:123, person_fullname: 'Иванов Иван Фёдорович',position_name:'Эксперт',competence_name:'Компетенция 1'}
	{competence_id:2,pict_url: publicPath+'../img/man_PNG6526.png', person_id:123, person_fullname: 'Иванов Иван Фёдорович',position_name:'Эксперт',competence_name:'Компетенция 2'}
	{competence_id:3,pict_url: publicPath+'../img/man_PNG6526.png', person_id:123, person_fullname: 'Иванов Иван Фёдорович',position_name:'Эксперт',competence_name:'Компетенция 3'}
]
export var get_competences_without_ment = [
	{id:1,name: 'asdad', group_name: '112asdadad', group_id: 123}
	{id:2,name: '1asdad', group_name: '22asdadad', group_id: 123}
	{id:3,name: '2asdad', group_name: '3132asdadad', group_id: 123}
	{id:34,name: '3asdad', group_name: '414asdadad', group_id: 123}
]
export var get_agreements_list = [
	{id:1,competence_name: 'asdad', mentor_fullname: '112asdadad', student_fullname: 123}

]
var endpoints = {
	'/get_start_page.json': get_start_page
	'/get_list_participant_tu.json': tu
	'/get_list_participant_member.json': member
	'/get_agreement.json': get_agreement
	'/get_techsupport.json': get_techsupport
	'/get_competences_list.json': get_competences_list
	'/get_competence_groups.json': get_competence_groups
	'/get_member_info.json': get_member_info
	'/aboutme.json': aboutme
	'/get_my_mentor_data.json': get_my_mentor_data
	'/get_my_mentors.json': get_my_mentors
	'/get_choices_competences.json': get_choices_competences
	'/get_list_requests.json': get_requests
	'/get_collaborators_list.json': get_collaborators_list
	'/get_groups_with_competences.json': get_groups_with_competences
	'/get_groups.json': get_groups
	'/get_agreement_sub_lists.json': get_agreement_sub_lists
	'/get_choice_student.json': get_choice_student
	'/get_competences_on_accept.json': get_competences_on_accept
	'/get_competences_without_ment.json': get_competences_without_ment
	'/get_agreements_list.json': get_agreements_list
}


export def Mock url
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
			