
<template>
  <div>
    <b-container fluid>
      <h1>Pages</h1>
      <b-btn-toolbar class="mb-4">
        <b-btn
          variant="primary"
          :href="localizedPath('/admin/pages/new')"
        >
          Upload Pages
        </b-btn>
      </b-btn-toolbar>
    </b-container>
    <TablePages />
  </div>
</template>

<script>
import TablePages from '../components/TablePages'
import UrlHelpers from '../mixins/UrlHelpers'

export default {
  name: 'Pages',
  components: {
    TablePages
  },
  mixins: [UrlHelpers]
}
</script>

<style scoped lang="scss">

</style>
