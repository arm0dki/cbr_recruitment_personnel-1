import './index.styl'
import 'imba-router'
import 'chart.js'
import MainPage as MP from './components/pages/main_page.imba'

var mode = window.TARGET_ENV

if mode=="production"
    Imba.mount(<MP>, document.getElementsByClassName("zone-main-wrapper").item(0))
else
    Imba.mount <MP>

