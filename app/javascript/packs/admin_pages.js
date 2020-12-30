import Vue from 'vue'
import router from '../router'
import store from '../store'

import PagesTable from '../components/PagesTable.vue'

Vue.config.productionTip = false

document.addEventListener('DOMContentLoaded', () => {
  const el = document.getElementById('admin-pages-table-container')
  new Vue({
    el,
    router,
    store,
    render: h => h(PagesTable)
  }).$mount(el)
})
