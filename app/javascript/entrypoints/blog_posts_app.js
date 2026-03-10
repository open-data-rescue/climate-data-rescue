import { BootstrapVue, IconsPlugin } from 'bootstrap-vue'
import '@/stylesheets/theme.scss'
import Vue from 'vue'
import { createApp } from 'vue';
import {store} from '@/store/model.store'

// TODO
import BlogPosts from '@/blog/blog_posts.vue'

Vue.use(BootstrapVue)
Vue.use(IconsPlugin)

const app = createApp(BlogPosts)

app.use(store)
app.mount('#blog-posts-app')
