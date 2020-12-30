import Vue from 'vue'
import router from '../router'
import store from '../store'

import AdminApp from '../components/AdminApp.vue'

Vue.config.productionTip = false

document.addEventListener('DOMContentLoaded', () => {
  const el = document.getElementById('admin-app')
  new Vue({
    el,
    router,
    store,
    render: h => h(AdminApp)
  }).$mount(el)
})
