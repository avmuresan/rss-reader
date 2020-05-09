<template lang="pug">
  #app
    Header
    router-view
</template>

<script>

  import Header from './header';

  export default {
    components: {
      Header
    }
  };
</script>
