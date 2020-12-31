
<template>
  <div>
    <b-container fluid>
      <h1>Pages</h1>
      <b-btn-toolbar class="mb-4">
        <b-btn
          variant="primary"
          :href="this.localizedPath('/admin/pages/new')"
        >
          Upload Pages
        </b-btn>
      </b-btn-toolbar>
    </b-container>
    <PagesTable />
  </div>
</template>

<script>
import PagesTable from '../components/PagesTable'
import UrlHelpers from '../mixins/UrlHelpers'

export default {
  name: 'Pages',
  components: {
    PagesTable
  },
  mixins: [UrlHelpers]
}
</script>

<style scoped lang="scss">

</style>
