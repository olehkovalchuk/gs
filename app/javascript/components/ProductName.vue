<template lang="pug">
  .product-name
    .product-name--icon(v-show="item.img")
      img(:src="item.img" :alt="item.title" :title="item.title")
    | {{item.title}}
</template>

<script>
export default {
  props:["item"]
}
</script>

<style lang="scss" scoped>
.product-name {
  display: flex;
  align-items: center;
  &--icon {
    width: 50px;
    height: 50px;
    margin-right: 10px;
    img {
      width: 100%;
      height: auto;
    }
  }
}
</style>
