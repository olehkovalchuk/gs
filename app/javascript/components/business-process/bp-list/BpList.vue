<template lang="pug">
.default-table.bp-list
  .default-table--heading.d-none.d-lg-flex
    span.id ID
    span.product Product name
    span.partner Initiator / Partner
    span.status Status
    span.price Price
    span.type Type
    span.update Last update
  BpListItem( v-for="item in items" :item="item" :key="item.id" )
</template>

<script>
import BpListItem from "@/components/business-process/bp-list/BpListItem"
export default {
  components: {
    BpListItem
  },
  computed:{
    items(){
      return this.$store.getters["processes/getItems"]
    }
  }
}
</script>

<style lang="css" scoped>
</style>
