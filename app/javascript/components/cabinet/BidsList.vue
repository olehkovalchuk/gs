<template lang="pug">
  .default-table.bid-list
    .default-table--heading.d-none.d-lg-flex
      span.id Type
      span.product Product name
      span.partner Initiator / Partner
      span.price Price
      span.comments Comments
      span.update Last update
    BidsListItem(
      v-for="bid in items"
      :key="bid.id"
      :bid="bid"
      )
    Pagination(v-on:update="update" :total="total" :currentPage="currentPage")
</template>

<script>
import BidsListItem from '@/components/cabinet/BidsListItem';
import Pagination from "@/components/Pagination"

export default {
  components: {
    BidsListItem,
    Pagination
  },
  created(){
    this.$isLoading('isLoading', 'items');
    this.$store.dispatch("bids/List")
  },
  computed:{
    items(){
      return this.$store.getters["bids/getItems"]
    },
    total(){
      return this.$store.getters['bids/getTotal'];
    },
    currentPage(){
      return this.$store.getters['bids/getPage'];
    }
  },
  methods:{
    update(){
      
    }
  }
}
</script>

<style lang="scss" scoped>
</style>
