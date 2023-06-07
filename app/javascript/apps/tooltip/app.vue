<template lang="pug">
  .info-icon( v-tooltip.top="translate('common.pricing_tooltip.' + type)" )
</template>

<script>

export default {
  props: ["type"]
}
</script>
<style lang="scss">
  
</style>
