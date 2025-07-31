import { SELECTED, SELECT, UNSELECT, FETCH,  CLEAR, SEARCH } from "./model.store";
import { mapActions } from 'vuex';

export const modelMixinNoProp = {
  computed: {
    selected() {
      return this.$store.getters[SELECTED]({model: this.model})
    },
    collection() {
      return Object.values(this.$store.getters['jv/get']({_jv: { type: this.model }}))
    }
  },
  methods: {
    ...mapActions('jv', ['get']),
    ...mapActions('jv', ['search']),
    select(itemOrId) {
      this.$store.commit(SELECT, {model: this.model, itemOrId});
    },
    unselect() {
      this.$store.commit(UNSELECT, {model: this.model});
    },
    fetch(params, url = null) {
      console.debug("FFFFFF")
      return this.$store.dispatch(FETCH, {model: this.model, url: url, params});
    },
    search(params) {
      return this.$store.dispatch(SEARCH, {model: this.model, params});
    },
    clear() {
      // NOTE: this is a sync tx not async, it is not trigerring the computed collection?
      this.$store.commit(CLEAR, {model: this.model});
    },
  }
}

export const modelMixin = {
  mixins:[
    modelMixinNoProp
  ],
  props: {
    model: {
      type: String,
      required: true
    }
  },
}

/**
 * Returns a mixin that provides a mirrored copy of the given field in
 * currently selected model, which updates when the selected
 * model updates.
 *
 * Provides:
 * data: { [field]: null }
 * mounted & watch on selected[field]
 *
 *  See people/people_admin_tab.vue for a good example
 *
 * @param {string} field
 * @returns The field mixin.
 */
export const makeSelectedFieldMixin = (field) => ({
  mixins: [
    modelMixinNoProp
  ],
  data: () => ({
    [field]: null
  }),
  mounted() {
    if (this.selected) {
      this[field] = this.selected[field];
    }
  },
  watch: {
    selected(newVal, oldVal) {
      if (newVal && (!oldVal || oldVal[field] !== newVal[field])) {
        this[field] = newVal[field];
      }
    }
  }
})

export default modelMixin;
