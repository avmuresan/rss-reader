<template lang="pug">
  tr
    td
      b-input( :id="elementId('feed_title')" v-model="form.data.title" :placeholder="feed.title" v-if="editing" )
      span( v-else ) {{ feed.title }}
    td
      b-input( :id="elementId('feed_url')" v-model="form.data.url" :placeholder="feed.url" v-if="editing" )
      a( v-else :href="feed.url" target="_blank" ) {{ feed.url }}
    td
      template( v-if="editing" )
        b-button.mr-2( :id="elementId('save_button')" variant="primary" @click="save" ) Save
        b-button( variant="secondary" @click="editing = false" ) Cancel
      template( v-else )
        b-button.mr-2( :id="elementId('edit_button')" variant="secondary" @click="editing = true" ) Edit
        b-button( :id="elementId('remove_button')" variant="danger" @click="remove" ) Remove
</template>

<script>

  export default {
    props: {
      feed: Object
    },
    data() {
      return {
        loading: false,
        editing: false,
        form: {
          data: {}
        }
      };
    },
    methods: {
      elementId(name) {
        return `${name}_${this.feed.id}`;
      },
      setFormData(feed) {
        this.form.data.id = feed.id;
        this.form.data.title = feed.title;
        this.form.data.url = feed.url;
      },
      remove() {
        if (this.loading) {
          return;
        }

        this.loading = true;
        this.$store.dispatch('feeds/remove', { feedId: this.feed.id })
          .then(() => {
            this.loading = false;
          }).catch(() => {
            this.loading = false;
          });
      },
      save() {
        if (this.loading) {
          return;
        }

        this.loading = true;
        this.$store.dispatch('feeds/save', { feed: this.form.data })
          .then(() => {
            this.loading = false;
            this.editing = false;
          }).catch((error) => {
            alert(Object.values(error.response.data)[0]);
            this.loading = false;
            this.loading = false;
          });
      }
    },
    created() {
      this.setFormData(this.feed);
    },
    watch: {
      feed(updatedFeed) {
        this.setFormData(updatedFeed);
      }
    }
  };
</script>
