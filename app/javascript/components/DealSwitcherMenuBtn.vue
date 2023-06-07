<template lang="pug">
.btn-wrapper(
  @click="openMenu"
  v-on-clickaway="closeMenu"
  )
  span.deal-switcher--btn(
    :class="{ active: menuShow }"
    )
    | {{translate("common." + type)}}
    span.arrow-icon(:class="{ active: menuShow }")
  ProductNav(v-on:update="update" :hasSubmenu="true" :items="categories(type)" :path="type")
</template>

<script>
import { directive as onClickaway } from 'vue-clickaway';
import ProductNav from '@/components/ProductNav';
export default {
  props: ['type'],
  directives: {
    onClickaway: onClickaway,
  },
  components: {
    ProductNav
  },
  data() {
    return {
      menuShow: false,
    }
  },
  computed:{
    activeType(){
      return this.$store.getters["products/getActiveItemType"];
    }
  },
  methods: {
    categories(type){
      return this.config[type].categories;
    },
    update(){
      this.$emit("update")
    },
    openMenu: function() {
      this.menuShow = true;
    },
    closeMenu: function() {
      this.menuShow = false;
    },
  }
}
</script>

<style lang="scss" scoped>


</style>
