<template lang="pug">
  .recommendations.default-block
    .recommendations--title
      h3 {{translate("common.recomended_for_you")}}
    OfferList(:items="items", hasImg="true", hasHoverClass="true")
</template>

<script>
  import OfferList from "@/components/OfferList"

  export default {
    props:["items"],
    components: {
      OfferList
    }
  }
</script>

<style lang="scss" scoped>
</style>
