<template>
  <div id="admin-app">
    <transcriptions></transcriptions>
  </div>
</template>

<script>
import Transcriptions from '../transcriptions/Transcriptions'

export default {
  name: 'AdminApp',
  components: {
    Transcriptions
  },
  data: function () {
    return {
    }
  }
}
</script>

<style lang="scss">
</style>
