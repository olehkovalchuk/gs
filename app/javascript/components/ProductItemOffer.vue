<template lang="pug">
.product-item--wrapper
  .row
    .col-xl-4.col-lg-5.col-md-4.col-sm-5
      .product-item--img
        .hot(v-if="product.hot") {{translate("common.hot")}}
        .verified(v-if="product.verified") {{translate("common.verified")}}
        .verified(v-if="product.in_top") {{translate("common.in_top")}}
        router-link( :to="routeParams" )

          img(:src="product.img" :alt="product.title" :title="product.title")
    .col-xl-8.col-lg-7.col-md-8.col-sm-7.pb-4
      ProductItemInfo(:product="product")
      .product-item--btn_block
        div
          button.btn.btn--details.btn__transparent.btn__icon( v-if="user.user_name" @click.prevent="startChat(product.r_id)" )
            svg-icon(name="icon-chat" class="mr-2")
            span {{translate('common.start_chat')}}
          button.btn.btn--details.btn__transparent.btn__icon( v-else @click="inquiryItem()")
            svg-icon(name="icon-chat" class="mr-2")
            span {{translate('common.contact_supplier')}}
          button.btn.btn--bid(@click="bidItem()") {{translate("common.bid")}}
  LastBid(:bid="product.bid" v-if="product.bid.amount")
  //- tablet and mobile
  .product-item--btn_block.mobile
    div
      button.btn.btn--details.btn__transparent.btn__icon( v-if="user.user_name" @click.prevent="startChat(product.r_id)" )
        svg-icon(name="icon-chat" class="mr-2")
        span {{translate('common.start_chat')}}
      button.btn.btn--details.btn__transparent.btn__icon( v-else @click="inquiryItem()") 
        svg-icon(name="icon-chat" class="mr-2")
        span {{translate('common.contact_supplier')}}
      button.btn.btn--bid(@click="bidItem()") {{translate("common.bid")}}
  //- /tablet and mobile
</template>

<script>

import ProductItemInfo from "@/components/ProductItemInfo";
import LastBid from "@/components/LastBid";
export default {
  props: ['product'],
  data() {
    return {
      showBid: false,
    }
  },
  computed: {
    routeParams(){
      if(this.$route.params.seo) {
        return { name: `${this.product.type}-new-route`, params: { id: this.product.id, seo: this.$route.params.seo }}
      } else {
        return { name: this.product.type, params: { id: this.product.id }}
      }
    }
  },
  methods: {
    bidItem(){
      this.$store.dispatch("products/SetActiveItem",this.product)
      this.$bvModal.show("bid-popup")
    },
    inquiryItem(){
      // this.socialTrack('ContactSupplier', 'contact_supplier')
      this.socialTrack('Activities')
      this.$store.dispatch("products/SetActiveItem",this.product)
      this.$bvModal.show("inquiry-popup")
    }
  },
  components: {
    ProductItemInfo,
    LastBid,
  }
}
</script>
<style lang="scss" scoped>
  .hot, .verified {
    position: absolute;
    top: 20px; left: 20px;
    padding: 5px 10px;
    text-transform: uppercase;
    color: #fff;
    font-size: 12px;
    border-radius: 5px;
  }
  .hot{
    background: #FFBE40;
  }
  .verified{
    top: 50px; left: 20px;
    background: #15cd58;
  }
 </style>
