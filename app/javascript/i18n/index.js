import { createI18n } from "vue-i18n"
// import pluralRules from "./rules/pluralization"
// import numberFormats from "./rules/numbers.js"
// import datetimeFormats from "./rules/datetime.js"
import en from "./locales/en.json"
import fr from "./locales/fr.json"

const datetimeFormats = {
  'en': {
    short: {
      year: 'numeric', month: 'short', day: 'numeric'
    },
    long: {
      year: 'numeric', month: 'short', day: 'numeric',
      weekday: 'short', hour: 'numeric', minute: 'numeric'
    }
  },
  'fr': {
    short: {
      year: 'numeric', month: 'short', day: 'numeric'
    },
    long: {
      year: 'numeric', month: 'short', day: 'numeric',
      weekday: 'short', hour: 'numeric', minute: 'numeric'
    }
  }
}

const i18n = createI18n({
  legacy: false,
  globalInjection: true,
  locale: import.meta.env.VITE_DEFAULT_LOCALE, //'en',
  fallbackLocale: import.meta.env.VITE_FALLBACK_LOCALE,
  messages: {
    en: en,
    fr: fr
  },
  runtimeOnly: false,
  // pluralRules,
  // numberFormats,
  datetimeFormats
})

export default i18n;
