import { mapState } from 'vuex'

const UrlHelpers = {
  computed: {
    ...mapState(['locale'])
  },
  methods: {
    localizedPath (path) {
      return `/${this.locale}${path}`
    }
  }
}

export default UrlHelpers
