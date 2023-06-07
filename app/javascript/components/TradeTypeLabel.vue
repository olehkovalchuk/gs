<template lang="pug">
span.trade-type-label(
  :class="company.role"
  ) {{ company.role }}
</template>

<script>
export default {
  props: ['company'],
}
</script>

<style lang="scss" scoped>
  .trade-type-label {
    display: inline-block;
    height: 19px;
    margin-left: 10px;
    padding: 0 7px;
    font-size: 12px;
    text-transform: capitalize;
    border-radius: 5px;
    &.seller {
      color: #FFAD4C;
      background: rgba(255, 173, 76, .25);
    }
    &.buyer {
      color: #cd1515;
      background: rgba(205, 21, 21, .25);
    }
    &.trader {
      color: #9C7CF9;
      background: rgba(189, 166, 255, .25);
    }
  }
</style>
