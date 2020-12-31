
<template>
  <b-navbar
    toggleable="lg"
    type="dark"
    variant="dark"
  >
    <b-navbar-brand href="/">
      DRAW
    </b-navbar-brand>

    <b-navbar-nav class="ml-auto">
      <b-nav-item-dropdown
        :text="locale.toUpperCase()"
        right
      >
        <b-dropdown-item
          v-if="locale != 'en'"
          :to="{ name: currentRouteName, params: { locale: 'en' }}"
        >
          EN
        </b-dropdown-item>
        <b-dropdown-item
          v-if="locale != 'fr'"
          :to="{ name: currentRouteName, params: { locale: 'fr' }}"
        >
          FR
        </b-dropdown-item>
      </b-nav-item-dropdown>

      <b-nav-item-dropdown
        text="Better Together"
        right
      >
        <b-dropdown-item href="#">
          About Better Together
        </b-dropdown-item>
      </b-nav-item-dropdown>

      <b-nav-item-dropdown
        text="Admin"
        right
      >
        <b-dropdown-item :to="{ name: 'pages', params: { locale: locale } }">
          Pages
        </b-dropdown-item>
       <b-dropdown-item :to="{ name: 'transcriptions', params: { locale: locale }}">
          Transcriptions
        </b-dropdown-item>
      </b-nav-item-dropdown>

      <b-nav-item-dropdown right>
        <!-- Using 'button-content' slot -->
        <template #button-content>
          <em>User</em>
        </template>
        <b-dropdown-item href="#">
          Profile
        </b-dropdown-item>
        <b-dropdown-item href="#">
          Sign Out
        </b-dropdown-item>
      </b-nav-item-dropdown>
    </b-navbar-nav>
  </b-navbar>
</template>

<script>
import { mapState } from 'vuex'

export default {
  name: 'Header',
  computed: {
    ...mapState(['locale']),
    currentRouteName () {
      return this.$route.name
    }
  }
}
</script>

<style lang="scss">
  .bg-dark {
    background: rgba(0, 0, 0, 0.8) !important;
  }
</style>
