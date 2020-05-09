<template lang="pug">
  tr.mt-3
    td
      b-input#feed_title( v-model="form.data.title" placeholder="Feed title" )
    td
      b-input#feed_url( v-model="form.data.url" placeholder="https://www.rss-feed/feed" )
    td
      b-button.mr-2( variant="primary" @click="add" ) Add new feed
</template>

<script>

  export default {
    data() {
      return {
        loading: false,
        form: {
          data: {}
        }
      };
    },
    methods: {
      setFormData() {
        this.form.data = {
          title: '',
          url: ''
        };
      },
      add() {
        if (this.loading) {
          return;
        }

        this.loading = true;
        this.$store.dispatch('feeds/save', { feed: this.form.data })
          .then(() => {
            this.loading = false;
            this.setFormData();
          }).catch((error) => {
            alert(Object.values(error.response.data)[0]);
            this.loading = false;
          });
      }
    },
    created() {
      this.setFormData();
    }
  };
</script>
