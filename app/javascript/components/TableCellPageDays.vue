<template>
  <div>
    <div
      v-for="page_day in page_days"
      :key="page_day.id"
    >
      {{ page_day.attributes.date_datestring }} ({{ page_day.attributes.num_observations }})
    </div>
  </div>
</template>

<script>
export default {
  name: 'TableCellPageDays',
  props: {
    page_days: {
      type: Array,
      required: true
    }
  }
}
</script>

<style scoped lang="scss">

</style>
