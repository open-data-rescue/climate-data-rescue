import Vue from 'vue'
import { BootstrapVue, IconsPlugin } from 'bootstrap-vue'
import 'stylesheets/theme.scss'

Vue.use(BootstrapVue)
Vue.use(IconsPlugin)

import {store} from '../store/model.store'
import DataEntryAudits from '../data_entry_audits/DataEntryAudits'

const app = new Vue({
  components: {
    DataEntryAudits
  },
  store
})

document.addEventListener('DOMContentLoaded', () => {
  app.$mount('#data-entry-audits-app')
})
