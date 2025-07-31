import { BootstrapVue, IconsPlugin } from 'bootstrap-vue'
import '@/stylesheets/theme.scss'
import Vue from 'vue'
import { createApp } from 'vue';
import {store} from '@/store/model.store'

import Blog from '@/blog/blog.vue'
import i18n from "@/i18n/index.js";


Vue.use(BootstrapVue)
Vue.use(IconsPlugin)

const app = createApp({
  components: {
    Blog
  }
})
app.use(i18n)
app.use(store)
app.mount('#blog-app')
