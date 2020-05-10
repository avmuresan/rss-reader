<template lang="pug">
  #app
    Header
    Loading( v-if="isLoading" )
    router-view( v-else )
</template>

<script>

  import Header from './header';
  import Loading from '@application/pages/loading';

  export default {
    components: {
      Header,
      Loading
    },
    data() {
      return {
        isLoading: true
      };
    },
    created() {
      Promise.all([
        this.$store.dispatch('articles/load'),
        this.$store.dispatch('feeds/load')
      ]).then(() => {
        this.isLoading = false;
      });
    }
  };
</script>
