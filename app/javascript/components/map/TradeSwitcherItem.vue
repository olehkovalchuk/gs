<template lang="pug">
  li.trade-type--item
    span.trade-type--link(
      @click="toggle"
      :class="[item.className, {active: isActive}]"
      ) {{ item.title }}
</template>

<script>
export default {
  props: ['item'],
  data() {
    return {
      isActive: false,
    }
  },
  methods: {
    toggle: function() {
      this.isActive = !this.isActive;
    }
  }
}
</script>

<style lang="scss" scoped>
</style>
