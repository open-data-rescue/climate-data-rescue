
<template>
  <div>
    <b-container fluid>
      <h1>Transcriptions</h1>
      <!-- <b-btn-toolbar class="mb-4">
      </b-btn-toolbar> -->
    </b-container>
    <transcriptions-table></transcriptions-table>
  </div>
</template>

<script>
import TranscriptionsTable from './transcriptions_table'
import UrlHelpers from '../mixins/UrlHelpers'


export default {
  name: 'Transcriptions',
  components: {
    TranscriptionsTable
  },
  mixins: [UrlHelpers]
}
</script>

<style scoped lang="scss">

</style>
