<template lang="pug">
div
  .row
    .col-12
      ProductItemInfo(:product="product")
      .product-item--btn_block
        div
          button.btn.btn--bid(@click.prevent="bidItem") {{translate("common.bid")}}
        div
          button.btn.btn--offers(@click.prevent="myOffers") {{translate("common.send_my_offers")}}
          button.btn.btn--details.btn__transparent.btn__icon( v-if="user.user_name" @click.prevent="startChat(product.r_id)" )
            svg-icon(name="icon-chat" class="mr-2")
            span {{translate('common.start_chat')}}
          button.btn.btn--details.btn__transparent.btn__icon( v-else @click="inquiryItem()")
            svg-icon(name="icon-chat" class="mr-2")
            span {{translate('common.contact_buyer')}}     
  LastBid(:bid="product.bid", v-if="product.bid.amount" v-show="showBid")
  .product-item--btn_block.mobile
    div
      button.btn.btn--bid(@click.prevent="bidItem") {{translate("common.bid")}}
    div
      button.btn.btn--offers(@click.prevent="myOffers") {{translate("common.send_my_offers")}}
      button.btn.btn--details.btn__transparent.btn__icon( v-if="user.user_name" @click.prevent="startChat(product.r_id)" )
        svg-icon(name="icon-chat" class="mr-2")
        span {{translate('common.start_chat')}}
      button.btn.btn--details.btn__transparent.btn__icon( v-else @click="inquiryItem()") 
        svg-icon(name="icon-chat" class="mr-2")
        span {{translate('common.contact_buyer')}}
</template>

<script>

import ProductItemInfo from "@/components/ProductItemInfo";
import LastBid from "@/components/LastBid";

export default {
  props: ['product'],
  data() {
    return {
      showBid: true
    }
  },
  methods: {
    myOffers(){
      this.$store.dispatch("products/SetActiveItem",this.product)
      this.$isLoading('isLoading', 'my_items');
      this.$store.dispatch('products/My').then(response => {
        if(response.success){
          this.socialTrack('SendMyOffer', 'send_my_offer')
          this.socialTrack('Activities')
          this.$bvModal.show("send-my-offers")
        }
        else{
          this.$store.dispatch('marketplace/Failure',response.message)
        }
      })
    },
    inquiryItem(){
      this.socialTrack('ContactBuyer', 'contact_buyer')
      this.socialTrack('Activities')
      this.$store.dispatch("products/SetActiveItem",this.product)
      this.$bvModal.show("inquiry-popup")
    },
    bidItem(){
      this.$store.dispatch("products/SetActiveItem",this.product)
      this.$bvModal.show("bid-popup")
    }
  },
  components: {
    ProductItemInfo,
    LastBid
  }
}
</script>
