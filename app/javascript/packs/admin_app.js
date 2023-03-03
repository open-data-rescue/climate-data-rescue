import Vue from 'vue'
import { BootstrapVue, IconsPlugin } from 'bootstrap-vue'
import 'stylesheets/theme.scss'

// Install BootstrapVue
Vue.use(BootstrapVue)
// Optionally install the BootstrapVue icon components plugin
Vue.use(IconsPlugin)

import {store} from '../store/model.store'

import AdminApp from '../components/AdminApp.vue'

Vue.config.productionTip = false

document.addEventListener('DOMContentLoaded', () => {
  const el = document.getElementById('admin-app')
  new Vue({
    el,
    store,
    render: h => h(AdminApp)
  }).$mount(el)
})
