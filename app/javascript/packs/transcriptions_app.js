import Vue from 'vue'
import { BootstrapVue, IconsPlugin } from 'bootstrap-vue'
import 'stylesheets/theme.scss'

Vue.use(BootstrapVue)
Vue.use(IconsPlugin)

import {store} from '../store/model.store'
import Transcriptions from '../transcriptions/Transcriptions'

const app = new Vue({
  components: {
    Transcriptions
  },
  store
})

document.addEventListener('DOMContentLoaded', () => {
  app.$mount('#transcriptions-app')
})
