<template lang="pug">
.aside
  DealSwitcher(v-on:update="update")
  SearchBar(v-on:update="update" type="products")
  ProductNav(v-on:update="update" :hasSubmenu="true" :items="categories")
  Filters(v-on:update="update" :items="filters")

</template>

<script>
import DealSwitcher from "@/components/DealSwitcher";
import SearchBar from "@/components/SearchBar";
import ProductNav from "@/components/ProductNav";
import Filters from "@/components/Filters";
export default {
  data() {
    return {
      offersActive: true,
      rfqActive: false
    }
  },
  components: {
    DealSwitcher,
    SearchBar,
    ProductNav,
    Filters
  },
  methods:{
    update(){
      this.$emit("update")
    }
  },
  computed:{
    categories(){
      return this.config[this.$store.getters["products/getActiveItemType"]].categories;
    },
    filters(){
      return this.config[this.$store.getters["products/getActiveItemType"]].filters
    }
  }
}
</script>

<style lang="scss" scoped>
</style>
