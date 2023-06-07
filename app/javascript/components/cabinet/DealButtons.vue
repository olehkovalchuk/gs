<template lang="pug">
  .deal-buttons
    router-link.deal-btn.deal-btn--process(:to="{name: 'cabinet-company-process'}" @click.prevent)
      .deal-btn--icon
        svg-icon(name="icon-deal")
      .deal-btn--text
        p {{translate("common.my_processes")}}
        span.counter {{item.processes_count}}
    router-link.deal-btn.deal-btn--offer(:to="{name: 'cabinet-offers'}" @click.prevent)
      .deal-btn--icon
        svg-icon(name="icon-offer")
      .deal-btn--text
        template(v-if="!item.offers_count")
          router-link( :to="{name: 'add-new-offer'}") {{translate("common.add_new_offer")}}
        template(v-if="item.offers_count")
          p {{translate("common.my_offers")}}
          span.counter {{item.offers_count}}
    router-link.deal-btn.deal-btn--request(:to="{name: 'cabinet-requests'}" @click.prevent)
      .deal-btn--icon
        svg-icon(name="icon-request")
      .deal-btn--text
        template(v-if="!item.requests_count")
          router-link( :to="{name: 'add-new-request'}" ) {{translate("common.add_new_request")}}
        template(v-if="item.requests_count")
          p {{translate("common.my_requests")}}
          span.counter {{item.requests_count}}

</template>

<script>
export default {
  props:['item']
}
</script>

<style lang="scss" scoped>
.deal-btn--text{
  a{
    color: black;
    &:hover{
      color: white;
    }
  }
}
</style>

