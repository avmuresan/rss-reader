<template lang="pug">
  .container-fluid
    .row
      .col-md-10.offset-md-1
        h1.mt-5.mb-5
          span Latest articles
          span.ml-2( v-if="articles.length > 0" ) ({{ articles.length }})
        ArticleCard( v-for="article in articles" :key="article.url" :article="article" )
        EmptyCard( v-if="articles.length < 1" )
</template>

<script>

  import ArticleCard from './components/article_card';
  import EmptyCard from './components/empty_card';

  export default {
    components: {
      ArticleCard,
      EmptyCard
    },
    computed: {
      articles() {
        return this.$store.getters['articles/all'];
      }
    }
  };
</script>
