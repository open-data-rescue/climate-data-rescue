<template>
  <div class="p0">
    <b-input-group>
      <b-input-group-prepend>
        <b-input-group-text>
          <b-icon icon="search" />
        </b-input-group-text>
      </b-input-group-prepend>

      <b-form-input
        type="text"
        v-model="value"
        debounce="500"
        v-on:keyup.enter="onSearch"
      ></b-form-input>

      <b-input-group-append>
        <b-button variant="primary" @click="onSearch">Search</b-button>
      </b-input-group-append>
    </b-input-group>
  </div>
</template>

<script>

export default {
  name: 'SearchVue',
  props: {
    columns: Array,
    stateName: {
      type: String,
      default: null
    }
  },
  data() {
    return {
      value: null,
      query: {}
    }
  },
  computed: {
    rules() {
      let rule_set = []
      // compute based on the columns
      this.columns.forEach(
        (col) => {
          // only cols with types are searchable
          if (col.type) {
            const rule_opts = {
              type: col.type,
              id: col.search_key ? col.search_key : col.key,
              label: col.label,
              component: col.component,
              // TODO stop hard coding dynamic choices in search component
              choices: col.choices === 'dynamic' ? this.dynamicChoices(col.key) : col.choices
            }
            if (col.operators) {
              rule_opts.operators = col.operators;
            }
            rule_set.push(rule_opts)
          }
        }
      )
      return rule_set
    }
  },
  methods: {
    dynamicChoices(key) {
    },
    filter_by_value() {
      return { 'filter[all]': `contains("${this.value}")` }
    },
    onSearch: function (event) {
      let filter = this.filter_by_value()

      this.$emit('change', filter)
    },
  }
}
</script>

<style lang="scss" scoped>
</style>
