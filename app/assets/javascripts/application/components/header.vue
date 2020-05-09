<template lang="pug">
  b-navbar( type="dark" variant="info" )
    b-navbar-brand( to="/home" ) RSS Reader
    b-navbar-nav
      b-nav-item( to="/home" active-class="active") Home
      b-nav-item( to="/feeds" active-class="active" ) Feeds
</template>

<script>
  export default {
  };
</script>
