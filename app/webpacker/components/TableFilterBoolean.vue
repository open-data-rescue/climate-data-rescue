<template>
  <b-input-group
    class="filter mb-3"
  >
    <b-form-select
      v-model="localSelected"
      :options="options"
      size="sm"
      class="mt-3"
    />
    <b-input-group-append
      v-if="clearEnabled"
    >
      <b-button
        v-b-tooltip.hover
        variant="outline-secondary"
        title="Clear"
        @click="resetValue"
      >
        x
      </b-button>
    </b-input-group-append>
  </b-input-group>
</template>

<script>
export default {
  name: 'TableFilterBoolean',
  props: {
    selected: {
      type: Object,
      default: null
    }
  },
  data () {
    return {
      // selected: null,
      options: [
        { value: null, text: '' },
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
