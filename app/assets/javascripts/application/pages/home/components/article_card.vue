<template lang="pug">
  .card.mb-3
    .card-body
      h5.card-title {{ article.title }}
      p.mb-0
        span Posted on
        span.font-weight-bold.ml-1 {{ article.channel }}
      p.mb-2 Published at {{ formattedDate }}
      a.btn.btn-primary( :href="article.link" target="_blank" ) Read article
</template>


<script>
  import { format } from 'date-fns';

  export default {
    props: {
      article: Object
    },
    computed: {
      formattedDate() {
        return format(new Date(this.article.date), 'MM/dd/yyyy HH:mm');
      }
    }
  };
</script>
