<template lang="pug">
ul.certificate-list
  li.certificate-list--item(v-for="item in items")
    img(:src="item.img" :title="item.title" :alt="item.title")
</template>

<script>
export default {
  props: ['items'],
}
</script>

<style lang="scss" scoped>

.certificate-list {
  display: flex;
  margin: 20px 0;
  &--item {
    margin-right: 35px;
    &:last-child {margin: 0;}
  }
  @media (max-width: 767.98px) {
    justify-content: space-around;
    &--item {margin: 0;}
  }
}
</style>
