<template>
  <table-filter-select
    v-model="localSelected"
    :options="localOptions"
    class="page_type_id"
  />
</template>

<script>
import TableFilterSelect from './TableFilterSelect'

export default {
  name: 'TableFilterBoolean',
  components: {
    TableFilterSelect
  },
  props: {
    selected: {
      type: Object,
      default: null
    }
  },
  data () {
    return {
      localOptions: [
        { value: true, text: 'Yes' },
        { value: false, text: 'No' }
      ]
    }
  },
  computed: {
    localSelected: {
      get () { return this.selected },
      set (selected) { this.$emit('input', selected) }
    },
    clearEnabled () {
      return this.selected != null
    }
  },
  methods: {
    resetValue () {
      this.selected = null
    }
  }

}
</script>

<style scoped lang="scss">

  .filter {
    > .input-group-append {
      > button.btn-outline-secondary {
        border: 1px solid #ced4da;

        &:hover {
          background-color: #ced4da;
          color: #6c757d;
        }
      }
    }
  }

</style>
