<template>
  <div :id="post.slug">
    <h3 >{{ post.title }}</h3>
    <h7><em> {{ $t('blog.byline', [post.author, $d(post.published_at, 'short')]) }}</em></h7>
    <div v-html="post.content"></div>
  </div>
</template>

<script>

export default {
  name: 'Post',
  props: {
    post: {
      type: Object
    }
  }
}
</script>

<style lang="css" scoped>
</style>
