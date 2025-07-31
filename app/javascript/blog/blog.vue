
<template>
  <div>
    <button class="nav-button" @click="scrollToTop">{{ $t("blog.navto-top")}}</button>
    <b-container fluid class="mb-3">
      <b-row class="blog-content">
        <b-col cols="2" class="left-nav">
          <h6 class="mt-4"><b>{{ $t("blog.index-title")}}</b></h6>
          <dl>
            <dd v-for="post in sortedCollection" :key="post.id">
              <a :href="'#' + post.slug">{{ post.title }}</a>
            </dd>  
          </dl>
        </b-col>
        <b-col>
          <h1 class="text-center">{{ $t("blog.title") }}</h1>
          <p class="text-center"><em>{{ $t('blog.sub') }}</em></p>
          <p>{{ $t('blog.intro') }}</p>
          <div v-for="post in sortedCollection" :key="post.id">
            <post :post="post"></post>
          </div>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>

<script>
import modelMixin from '../store/model.mixin';
import tableMixin from '../store/table.mixin';
import Post from './post.vue'
import Tr from "@/i18n/translation"

import { blogPostModel } from '@/store/blog_post.store'

export default {
  name: 'Blog',
  mixins: [
    modelMixin,
    tableMixin
  ],
  components: {
    Post
  },
  props: {
    lang: String,
    defaultSortDesc: {
      type: Boolean,
      default: true
    },
  },
  data: () => ({
    posts: null,
    loading: true,
    model: blogPostModel
  }),
  methods: {
    fetchPosts() {
      // this.sortDesc = true;
      this.fetchAll();
    },
    scrollToTop() {
      document.body.scrollTop = 0;
      document.documentElement.scrollTop = 0;
    }
  },
  mounted() {
    // Change the language to the one passed in
    // derived from the URL...
    Tr.switchLanguage(this.lang)
    // Ensure we have fetched our assignments
    this.fetchPosts()
  }
}
</script>

<style scoped lang="scss">
.nav-button {
//  display: none;
  position: fixed;
  bottom: 60px;
  right: 30px;
  z-index: 99;
  font-size: 18px;
  border: none;
  outline: none;
  background-color: red;
  color: white;
  cursor: pointer;
  padding: 15px;
  border-radius: 4px;
}

.left-nav {
  background-color: #3b8c92;
  color: white;
}

.blog-content {
  background-color: #d7f5f7;
}

a:link {
  display: block;
  color: white;
  padding-left: 8px;
  width: 90%;
  text-decoration: none;
}

a:visited {
  display: block;
  color: #2c696e;
  padding-left: 8px;
  width: 90%;
  text-decoration: none;
}
</style>
