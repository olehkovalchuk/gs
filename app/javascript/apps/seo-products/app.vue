<template lang="pug">
  .product-list
    .row
      .col-lg-4.col-md-6.col-12(v-for="product in items")
        .product-item( :key="product.id")
          ProductItemOffer(:product="product")
</template>

<script>
import ProductItemOffer  from "@/components/ProductItemOffer";

export default {
  props: ['id'],
  components: {
    ProductItemOffer
  },
  methods:{
    processQuery(route){
      this.$isLoading('isLoading', 'items');
      this.$store.dispatch('products/List',{});
    }
  },
  created(){
    this.$store.dispatch('products/SetFilterId', this.id );
  },
  computed:{
    items(){
      return this.$store.getters['products/getItems'];
    },
  },
  mounted() {
    if(!window.gon.config.is_lighthouse){
      this.$isLoading('isLoading', 'global_config');
      this.$store.dispatch('marketplace/GlobalConfig');
      this.processQuery(this.$route)
    }
  },
}
</script>
<style lang="scss">
  // @import "@/assets/styles/seo-products_app.scss";

</style>
