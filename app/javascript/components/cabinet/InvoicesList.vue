<template lang="pug">
  .default-table.invoice-list
    .default-table--heading.d-none.d-lg-flex
      span.id #
      span.user User
      span.status Status
      span.update Last update
      span.details Details
      span.delete Delete
    InvoicesListItem(
      v-for="invoice in items"
      :key="invoice.id"
      :invoice="invoice"
      )
</template>

<script>
import InvoicesListItem from '@/components/cabinet/InvoicesListItem';
export default {
  components: {
    InvoicesListItem
  },
  created(){
    this.$isLoading('isLoading', 'items');
    this.$store.dispatch("invoices/List")
  },
  computed:{
    items(){
      return this.$store.getters["invoices/getItems"]
    }
  }
}
</script>

<style lang="scss" scoped>
</style>
