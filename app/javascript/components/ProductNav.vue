<template lang="pug">
  .side-nav
    ProductNavItem(
      v-for="category in items"
      :key="category.id"
      :item="category"
      :path="path"
      :active="active"
      :withSelect="withSelect"
      v-on:select="select"
      )
</template>

<script>
import ProductNavItem from '@/components/ProductNavItem';
import ProductNavSubmenu from '@/components/ProductNavSubmenu';
export default {
  props: ['hasSubmenu', 'items', 'path', 'active',"withSelect"],
  components: {
    ProductNavItem,
    ProductNavSubmenu
  },
  data() {
    return {
      menuShow: false,
    }
  },
  methods: {
    select(item){
      this.$emit("select",item)
    }
  }
}
</script>

<style lang="scss" scoped>

</style>
