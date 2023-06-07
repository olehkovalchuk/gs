<template lang="pug">
  .default-table.transactions-list
    .default-table--heading.d-none.d-lg-flex
      span.id ID
      span.product-name Product name
      span.partner Initiator / Partner
      span.status Status
      span.price Price
      span.update Created at
    TransactionsListItem(
      v-for="item in items"
      :key="item.id"
      :item="item"
      )
</template>

<script>
import TransactionsListItem from '@/components/cabinet/TransactionsListItem';
export default {
  components: {
    TransactionsListItem
  },
  created(){
    this.$store.dispatch("transactions/List")
  },
  computed:{
    items(){
      return this.$store.getters["transactions/getItems"]
    }
  }
}
</script>

<style lang="scss" scoped>
</style>
