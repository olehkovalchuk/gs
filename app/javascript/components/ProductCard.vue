<template lang="pug">
  .product-card(ref="content")
    .product-card--title
      h1 {{item.title}} from {{item.origin_title}}
      a.btn.btn__transparent.btn__small.btn__icon(href="#" @click.prevent="pdf") {{translate('common.download_pdf')}}
        svg-icon(name="icon-download" class="ml-2")
    .product-card--content
      .row
        .col-md-6
          .product-card--gallery
            ImageGallery(:items="item.images" :title="item.title")
        .col-md-6
          h2.price(v-html="item.price")
          .delivery-info
            span {{ item.delivery }}
            span.info-icon(v-tooltip.bottom="item.tooltip" v-if="item.tooltip")
          p.subtitle(v-blur="blurConfig") {{item.description}}
          CertificateList(:items="item.certificates" v-if="item.certificates.length")
          InfoList(v-for="(item, i) in item.info" :key="i" :title="item.title" :data="item.data" v-blur="blurConfig")
          .product-card--btn-block
            button.btn.btn__transparent.btn__icon( v-if="user.user_name" @click.prevent="startChat(item.r_id)" )
              svg-icon(name="icon-chat" class="mr-2")
              span {{translate('common.start_chat')}}
            button.btn.btn__transparent.btn__icon( v-else @click.prevent="inquiryItem(item.r_id)" )
              svg-icon(name="icon-chat" class="mr-2")
              span {{translate('common.contact_supplier')}}

    PlaceBidForm(:product="item")
    InquirePopup
</template>

<script>
import InfoList from "@/components/InfoList";
import ImageGallery from "@/components/ImageGallery";
import PlaceBidForm from "@/components/PlaceBidForm";
import CertificateList from "@/components/CertificateList";
// import SendOfferPopup from "@/components/SendOfferPopup";
import jsPDF from 'jspdf'
import html2canvas from "html2canvas"
import InquirePopup from '@/components/InquirePopup';

export default {
  props: ['item'],
  components: {
    InfoList,
    ImageGallery,
    PlaceBidForm,
    CertificateList,
    InquirePopup
  },
  methods:{
    pdf(){
     window.print();
     this.socialTrack('DownloadPDF', 'download_PDF')
    },
    inquiryItem(){
      this.$store.dispatch("products/SetActiveItem",this.item)
      this.$bvModal.show("inquiry-popup")
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
  mounted(){

  }
}

</script>

<style lang="scss">

</style>
