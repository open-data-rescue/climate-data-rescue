import Vue from 'vue'
import { BootstrapVue, IconsPlugin } from 'bootstrap-vue'
import 'stylesheets/theme.scss'

Vue.use(BootstrapVue)
Vue.use(IconsPlugin)

import {store} from '../store/model.store'
import Pages from '../pages/Pages'

const app = new Vue({
  components: {
    Pages
  },
  store
})

document.addEventListener('DOMContentLoaded', () => {
  app.$mount('#pages-app')
})
