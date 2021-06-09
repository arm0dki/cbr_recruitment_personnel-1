
export tag fromToServer

	var server_path = "custom_web_template.html?object_id=6946060213517098168" 

	def load url
		var res = await window.fetch(server_path+url,
			method: 'GET'
			cache: "no-store"
			headers: {
				'Cache-Control': 'no-cache'
				}
		)
		return res.json

	def send url, _body
		var res = await window.fetch(server_path+url, {
			method: 'POST'
			body: _body
			cache: "no-store"
			headers: {
				'Cache-Control': 'no-cache'
				}
			})
		return res.json
	def post url, _body
		var res = await window.fetch(server_path+url, {
			method: 'POST'
			body: _body
			cache: "no-store"
			headers: {
				'Cache-Control': 'no-cache'
				}
			})
		var oRes = {};

		if(!res:ok)
			window.alert "���! ���-�� ����� �� ���. ���������� ������� ��� �������� ������ � ����"
		else
			oRes = await res.json
			if oRes:show_mess
				window.alert oRes:user_mess
				return false
			else
				return oRes