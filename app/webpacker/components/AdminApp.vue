
<template>
  <div id="admin-app">
    <div
      id="body-bg-img"
      :style="
        `background-image: url(${McGillBackground});`"
    />
    <Header />
    <div
      id="content-wrapper"
      class="py-4"
    >
      <transition
        name="fade"
        mode="out-in"
      >
        <router-view />
      </transition>
    </div>
    <Footer />
  </div>
</template>

<script>
import McGillBackground from '../../assets/images/mcgill-background.jpg'
import Footer from './Footer'
import Header from './Header'

export default {
  name: 'AdminApp',
  components: {
    Footer,
    Header
  },
  data: function () {
    return {
      McGillBackground: McGillBackground
    }
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

    #body-bg-img {
      display: block;
      position: fixed;
      left: 0;
      top: 0;
      width: 100%;
      height: 100%;
      z-index: -1;
      background-repeat: no-repeat;
      -ms-background-size: cover;
      -o-background-size: cover;
      -moz-background-size: cover;
      -webkit-background-size: cover;
      background-size: cover;
      background-position: left center;

      &.holiday-special {
        background-image: url(image_path("holiday-bg"));
        -webkit-filter: grayscale(50%); /* Safari 6.0 - 9.0 */
        filter: grayscale(50%);
      }
    }

    #content-wrapper {
      background-color: #fafafa;
    }

    a:not(.btn) {
      color: $accent-color;

      &:hover {
        color: lighten($accent-color, 20%);
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

    .btn-secondary {
      &:visited {
        color: lighten($accent-color, 20%);
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
