import Vue from 'vue'
import router from '../router'
import {store} from '../store/model.store'

import AdminApp from '../components/AdminApp.vue'

require('@rails/ujs').start()

Vue.config.productionTip = false

document.addEventListener('DOMContentLoaded', () => {
  const el = document.getElementById('admin-app')
  new Vue({
    el,
    store,
    router,
    render: h => h(AdminApp)
  }).$mount(el)
})
