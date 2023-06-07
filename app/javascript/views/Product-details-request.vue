<template lang="pug">
  .container.mt-5
    .row
      .col-xl-3.col-lg-4
        DealSwitcherMenu
      .col-xl-9.col-lg-8
        SearchBar(:placeholder="translate('common.search_requests')" type="products")
    .row.mt-5
      .col-lg-9
        ProductCardRequest( :item="product")
        OfferBids( :items="product.bids" v-if="product.bids.length")
      .col-lg-3
        CompanyInfo(:company="product.company")
        Recommendations(v-if="product.recomendations.length" :items="product.recomendations")
    InquireReplayPopup
</template>

<script>
  import SearchBar    from "@/components/SearchBar";
  import DealSwitcherMenu from "@/components/DealSwitcherMenu";
  import ProductCardRequest from "@/components/ProductCardRequest";
  import OfferBids from "@/components/OfferBids";
  import CompanyInfo from "@/components/CompanyInfo";
  import Recommendations from "@/components/Recommendations";
  import InquireReplayPopup from "@/components/InquireReplayPopup";


  export default {
    props: ['seo','id'],
    name: "request",
    components: {
      SearchBar,
      DealSwitcherMenu,
      ProductCardRequest,
      OfferBids,
      CompanyInfo,
      Recommendations,
      InquireReplayPopup
    },
    metaInfo() {
      if(this.metaTitle) {
        return {
          title: this.metaTitle,
          meta: [{
            name: 'description', content: this.metaDesc
          }]
        }
      }
    },
    computed:{
      product(){
        return this.$store.getters['products/getItemCurrent'];
      },
      metaTitle(){
        return `Buy ${this.product.title} wholesale on Global Supplies from seller ${this.product.company.seo_title}`
      },
      metaDesc(){
        return `${this.metaTitle} | The most convenient and dynamically developing b2b platform working worldwide | Join us to find wholesale suppliers or to trade your products on a business to business wholesale`
      }
    },
    watch: {
      // call again the method if the route changes
      '$route': 'getProduct'
    },
    data() {
      return {
        menuShow: false,
      }
    },

    methods: {
      toggle: function() {
        this.menuShow = !this.menuShow
      },
      getProduct(){
        this.$isLoading('isLoading', 'item_current');
        this.$store.dispatch('products/Show',this.id).then(response => {
          if(!response.success){
            this.$store.dispatch('marketplace/Failure',response.message)
          }
          else{
            let params = {
              content_type: 'product',
              content_category: this.product.title,
              content_name: this.product.title,
              value: this.product.b_id,
              currency: 'USD',
              contents: [
                {
                  id: this.product.id,
                  quantity: 1,
                  country: this.product.origin_title,
                  permission: this.product.permission_title,
                  category: this.product.title,
                }
              ]
            }
            this.socialTrack('ViewContent', undefined, params)
          }
          this.showInquiry()
        })
      },
      showInquiry(){
        if(gon.config.inquiry){
          this.$bvModal.show("replay-popup")
        }
      }
    },
    created(){
      this.getProduct()
    }
  }
</script>

<style lang="scss">
  @media (max-width: 991.98px) {
    .search-bar {
      margin-top: 10px;
    }
    .company-info {
      margin-top: 25px;
    }
  }
</style>
