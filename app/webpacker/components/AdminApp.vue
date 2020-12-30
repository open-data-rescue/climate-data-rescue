
<template>
  <div id="admin-app">
    <Header />
    <div>
      Content!
    </div>
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

</style>
