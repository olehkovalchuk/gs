<template lang="pug">
  .bid-history
    h3.bid-history--title {{translate('common.bids_on_offer')}}
    .bid-history--table
      .bid-history--table--heading
        span.price {{translate('common.bid')}}
        span.company {{translate('common.company')}}
        span.comment {{translate('common.comment')}}
        span.date {{translate('common.date_header')}}
      OfferBidItem(v-for="bid in items" :item="bid" :key="bid.id")
</template>

<script>
import OfferBidItem from "@/components/OfferBidItem.vue";
export default {
  props:['items'],
  components: {
    OfferBidItem
  },
  data() {
    return {
      showRating: false,
    }
  }
}
</script>

<style lang="scss" scoped>
</style>
