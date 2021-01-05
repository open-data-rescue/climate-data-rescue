<template>
  <div>
    <div
      v-for="transcription in transcriptions"
      :key="transcription.id"
    >
      <b-link
        :href="transcription.links.admin_detail"
      >
        #{{ transcription.id }} ({{ transcription.attributes.percent_complete }}%)
      </b-link>
    </div>
  </div>
</template>

<script>
export default {
  name: 'TableCellPageTranscriptions',
  props: {
    transcriptions: {
      type: Array,
      required: true
    }
  }
}
</script>

<style scoped lang="scss">

</style>
