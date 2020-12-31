
<template>
  <div id="admin-app">
    <Header />
    <transition
      name="fade"
      mode="out-in"
    >
      <router-view />
    </transition>
    <Footer />
  </div>
</template>

<script>
import Footer from './Footer'
import Header from './Header'
export default {
  name: 'AdminApp',
  components: {
    Footer,
    Header
  }
}
</script>

<style lang="scss">
  @import 'bootstrap/scss/_functions.scss';
  @import 'bootstrap/scss/_variables.scss';
  @import 'bootstrap/scss/_mixins.scss';
  @import 'stylesheets/draw-variables';

  #admin-app {
    font-family: Avenir, Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    color: #2c3e50;

    a {
      color: #ffffff;

      &:hover {
        background-color: $accent-color;
      }
    }

    .dropdown-menu > li > a,
    .dropdown-menu > li > a a.dropdown-toggle, {
      color: #2c3e50;

      &:hover {
        color: #ffffff;
      }
    }

    .btn-primary {
      color: #ffffff;
      background-color: $accent-color;
      border-color: $accent-color;

      &:hover, &:focus, &:active {
        color: #ffffff;
        background-color: #399f71;
        border-color: #399f71;
      }
    }

    header,
    footer {
      // width: 100vw;
      // height: 15vh;
      padding: 0;

      .navbar-nav {
        a {
          font-weight: bold;
          color: #ffffff;

          &.router-link-exact-active,
          &:hover {
            color: $accent-color;
          }
        }

        @include media-breakpoint-up(md) {
          li {
            margin-right: 1vw;

            &:last-child {
              margin-right: 0;
            }
          }
        }
      }
    }
  }
</style>
