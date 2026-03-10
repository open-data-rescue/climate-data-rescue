<template>
  <div>
    <b-container fluid>
      <h1>Blog Posts</h1>
      <!-- <b-btn-toolbar class="mb-4">
        <b-btn
          variant="primary"
          :href="localizedPath('/admin/pages/new')"
        >
          Upload Pages
        </b-btn>
      </b-btn-toolbar> -->
    </b-container>
    <!-- Table of posts along with the ability to edit in specific languages -->
    <blog-posts-table></blog-posts-table>
  </div>
</template>

<script>
// import BlogPostssTable from './blog_posts_table.vue'
import UrlHelpers from '../mixins/UrlHelpers'

export default {
  name: 'BlogPosts',
  components: {
    // BlogPostssTable
  },
  mixins: [UrlHelpers]
}
</script>

<style scoped lang="scss">

</style>
