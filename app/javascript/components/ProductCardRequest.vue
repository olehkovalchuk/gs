<template lang="pug">
  .product-card.product-card--request(ref="content")
    .product-card--title
      h2 {{item.title}}
      a.btn.btn__transparent.btn__small.btn__icon(href="#"  @click.prevent="pdf") {{translate('common.download_pdf')}}
        svg-icon(name="icon-download" class="ml-2")
    .product-card--content
      .row
        .col-md-8
          p.subtitle(v-if="item.description" v-blur="blurConfig") {{item.description}}
          InfoList(v-for="(item, i) in item.info" :key="i" :title="item.title" :data="item.data" v-blur="blurConfig")
          CertificateList(:items="item.certificates" v-if="item.certificates.length")
        .col-md-4
          h2.price(v-html="item.price")
          .delivery-info
            span {{ item.delivery }}
            span.info-icon(v-tooltip.left="item.tooltip" v-if="item.tooltip")

      .product-card--btn-block
        a.btn(href="#" @click.prevent="myOffers") {{translate('common.send_my_ofers')}}
        a.btn.btn__transparent.btn__icon( v-if="user.user_name" @click.prevent="startChat(item.r_id)" )
          svg-icon(name="icon-chat" class="mr-2")
          span {{translate('common.start_chat')}}
        a.btn.btn__transparent.btn__icon( v-else href="#" @click.prevent="inquiryItem(item.r_id)")
          svg-icon(name="icon-chat" class="mr-2")
          span {{translate('common.contact_buyer')}}
    PlaceBidForm(:product="item")
    SendOffersPopup
    InquirePopup
</template>

<script>
import InfoList from '@/components/InfoList';
import PlaceBidForm from '@/components/PlaceBidForm';
import CertificateList from '@/components/CertificateList';
import SendOffersPopup     from "@/components/SendOffersPopup";
import InquirePopup from '@/components/InquirePopup';

import jsPDF from 'jspdf'
import html2canvas from "html2canvas"

export default {
  props:['item'],
  components: {
    InfoList,
    PlaceBidForm,
    CertificateList,
    SendOffersPopup,
    InquirePopup
  },
  data() {
    return {
      menuShow: false,
    }
  },
  computed:{
    blurConfig(){
      return {
        isBlurred: false,
        opacity: 0.3,
        filter: 'blur(2.5px)',
        transition: 'all .3s linear'
      }
    }
  },
  methods: {
    pdf(){
      window.print();
      this.socialTrack('DownloadPDF', 'download_PDF');
    },
    inquiryItem(){
      this.$store.dispatch("products/SetActiveItem",this.item)
      this.$bvModal.show("inquiry-popup")
    },
    myOffers(){
      this.$store.dispatch("products/SetActiveItem",this.item)
      this.$isLoading('isLoading', 'my_items');
      this.$store.dispatch('products/My').then(response => {
        if(response.success){
          this.$bvModal.show("send-my-offers")
        }
        else{
          this.$store.dispatch('marketplace/Failure',response.message)
        }
      })
    },
    toggle: function() {
      this.menuShow = !this.menuShow
    }
  },
  mounted(){

  }
}

</script>

<style lang="scss" scoped>
.product-card--request .price{
  text-align: right;
}
.delivery-info{
  float: right;
}
</style>
