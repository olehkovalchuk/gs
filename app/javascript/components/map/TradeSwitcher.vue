<template lang="pug">
  ul.trade-type
    li.trade-type--item(v-for="item in item")
      a.trade-type--link(
        href="#"
        :class="[item.className]"
        ) {{ item.title }}
</template>

<script>
export default {
  props: ['item'],
  data() {
    return {

    }
  },
}
</script>

<style lang="scss" scoped>
</style>
