import {store, SET_LOCALE} from '../store/model.store'
import Vue from 'vue'
import VueRouter from 'vue-router'

import { BootstrapVue, IconsPlugin } from 'bootstrap-vue'
import 'stylesheets/theme.scss'

import Pages from '../pages/Pages'
import Transcriptions from '../transcriptions/Transcriptions'
import DataEntryAudits from '../data_entry_audits/DataEntryAudits'

// Install BootstrapVue
Vue.use(BootstrapVue)
// Optionally install the BootstrapVue icon components plugin
Vue.use(IconsPlugin)

Vue.use(VueRouter)

// Make sure to *not* prepend your paths with a `/`!
const routes = [
  {
    path: 'admin',
    component: {
      // Inline declaration of a component that renders our <router-view>
      render: (c) => c('router-view')
    },
    children: [
      {
        path: 'pages',
        component: Pages,
        name: 'pages',
        meta: {
          title: 'Pages | DRAW',
          metaTags: [
            {
              name: 'description',
              content: 'The list of pages'
            },
            {
              property: 'og:description',
              content: 'The list of pages'
            }
          ]
        }
      },
      {
        path: 'transcriptions',
        component: Transcriptions,
        name: 'transcriptions',
        meta: {
          title: 'Transcriptions | DRAW',
          metaTags: [
            {
              name: 'description',
              content: 'The list of transcriptions'
            },
            {
              property: 'og:description',
              content: 'The list of transcriptions'
            }
          ]
        }
      },
      {
        path: 'data_entry_audit',
        component: DataEntryAudits,
        name: 'data_entry_audit',
        meta: {
          title: 'Date Entry Audit | DRAW',
          metaTags: [
            {
              name: 'description',
              content: 'Audit of the Data Entries'
            },
            {
              property: 'og:description',
              content: 'Audit of the Data Entries'
            }
          ]
        }
      }
    ]
  }
]

const router = new VueRouter({
  mode: 'history',
  routes: [{
    path: '/:locale(en|fr)?',
    component: {
      beforeRouteEnter: setLocale,
      beforeRouteUpdate: setLocale,
      render (h) { return h('router-view') }
    },
    children: routes
  }]
})

function setLocale (to, from, next) {
  let { locale } = to.params

  if (!locale) {
    locale = store.state.locale
  }

  // Do something with locale, check availability of messages etc.
  store.commit(SET_LOCALE, locale)
  next()
}

// This callback runs before every route change, including on page load.
router.beforeEach((to, from, next) => {
  // This goes through the matched routes from last to first, finding the closest route with a title.
  // eg. if we have /some/deep/nested/route and /some, /deep, and /nested have titles, nested's will be chosen.
  const nearestWithTitle = to.matched.slice().reverse().find(r => r.meta && r.meta.title)

  // Find the nearest route element with meta tags.
  const nearestWithMeta = to.matched.slice().reverse().find(r => r.meta && r.meta.metaTags)

  // If a route with a title was found, set the document (page) title to that value.
  if (nearestWithTitle) document.title = nearestWithTitle.meta.title

  // Remove any stale meta tags from the document using the key attribute we set below.
  Array.from(document.querySelectorAll('[data-vue-router-controlled]')).map(el => el.parentNode.removeChild(el))

  // Skip rendering meta tags if there are none.
  if (!nearestWithMeta) return next()

  // Turn the meta tag definitions into actual elements in the head.
  nearestWithMeta.meta.metaTags.map(tagDef => {
    const tag = document.createElement('meta')

    Object.keys(tagDef).forEach(key => {
      tag.setAttribute(key, tagDef[key])
    })

    // We use this to track which meta tags we create, so we don't interfere with other ones.
    tag.setAttribute('data-vue-router-controlled', '')

    return tag
  })
  // Add the meta tags to the document head.
    .forEach(tag => document.head.appendChild(tag))

  next()
})

export default router
