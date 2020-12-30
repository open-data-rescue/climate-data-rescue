<template>
  <b-input-group
    class="filter mb-3"
  >
    <b-form-input
      v-model="localValue"
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
  name: 'TableTextFilter',
  props: {
    value: {
      type: String,
      default: '',
      required: true
    }
  },
  computed: {
    localValue: {
      get () { return this.value },
      set (localValue) { this.$emit('input', localValue) }
    },
    clearEnabled () {
      return this.localValue.length > 0
    }
  },
  methods: {
    resetValue () {
      this.localValue = ''
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
