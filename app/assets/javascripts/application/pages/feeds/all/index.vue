<template lang="pug">
  .container-fluid
    .row
      .col-md-10.offset-md-1
        h1.mt-5.mb-5 Feeds configuration
        table.table.b-table.table-hover
            thead.thead-light
              tr
                th Title
                th Feed URL
                th Actions
            tbody
              TableRow( v-for="feed in feeds" :key="feed.id" :feed="feed" )
              EmptyRow( v-if="feeds.length < 1" )
              AddingRow

</template>

<script>

  import AddingRow from './components/adding_row';
  import EmptyRow from './components/empty_row';
  import TableRow from './components/table_row';

  export default {
    components: {
      AddingRow,
      EmptyRow,
      TableRow
    },
    computed: {
      feeds() {
        return this.$store.getters['feeds/all'];
      }
    }
  };
</script>
