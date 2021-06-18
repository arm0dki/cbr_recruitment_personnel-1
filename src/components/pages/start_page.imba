let mode = window.TARGET_ENV
let _path =  mode!='production' ? '' : window.PUBLIC_PATH

export tag StartPage < div
	
	def render
		<self>
			<div.startpage_content>
				<img src="{_path}./image/start.png">