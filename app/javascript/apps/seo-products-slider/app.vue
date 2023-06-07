<template lang="pug">
  swiper(:options='swiperOptions')
    swiper-slide(v-for="product in items")
      .product-item( :key="product.id")
        ProductItemOffer(:product="product")
    //- .gallery-btn.next(slot="button-next")
    //- .gallery-btn.prev(slot="button-prev")
    .swiper-pagination(slot='pagination')
    BidPopup
    InquirePopup
    CompanyStatusPopup
</template>

<script>
import ProductItemOffer  from "@/components/ProductItemOffer";
import BidPopup          from "@/components/BidPopup";
import InquirePopup from '@/components/InquirePopup';
import CompanyStatusPopup from '@/components/CompanyStatusPopup';

export default {
  props: ['id'],
  components: {
    ProductItemOffer,
    BidPopup,
    InquirePopup,
    CompanyStatusPopup
  },
  data(){
    return {
      swiperOptions: {
        autoHeight: true,
        // effect: "fade",
        pagination: {
          el: '.swiper-pagination',
          type: 'bullets',
          clickable: 'true'
        },
        autoplay: {
          delay: 5000
        }
      },
    }
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
  @import 'node_modules/swiper/dist/css/swiper';

  .btn__icon {
    &/deep/svg {
      position: relative;
      top: -2px;
      width: 19px;
      height: 14px;
    }
  }
</style>
