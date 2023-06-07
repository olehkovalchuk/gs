<template lang="pug">
.selected-product.default-block
  OfferList(:items="items" hasImg="true" hasQuantity="true")
</template>

<script>
import OfferList from "@/components/OfferList";
export default {
  props:["items"],
  components: {
    OfferList
  }
}
</script>

<style lang="css" scoped>
</style>
