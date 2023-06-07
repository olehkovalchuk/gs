<template lang="pug">
  .cabinet-page.default-block
    .title
      h2 {{translate("common.bids")}}
    BidsList
</template>

<script>
import BidsList from '@/components/cabinet/BidsList';

export default {
  components: {
    BidsList
  },
  data() {
    return {
    }
  }
}
</script>

<style lang="scss" scoped>

</style>
