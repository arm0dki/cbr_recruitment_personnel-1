import './index.styl'
import './ui-kit.styl'
import 'line-awesome/dist/line-awesome/css/line-awesome.css'
import 'imba-router'
import MainPage as MP from './components/pages/main_page.imba'

var mode = window.TARGET_ENV

if mode=="production"
    Imba.mount(<MP>, document.getElementsByClassName("zone-main-wrapper").item(0))
else
    Imba.mount <MP>

