<template lang="pug">
.purchase-order
  .left
    strong {{translate('common.purchase_order')}} 
    p.status
      | {{translate('common.status')}}:
      strong {{item.status}}
  .btn-block
    button.btn.btn__transparent(v-b-modal.order-popup) {{translate('common.open_po')}}  
    button.btn.btn__transparent(:class="{'disabled': item.po_btn_disabled }" @click.prevent="showDownload") {{translate('common.download')}} 
    button.btn.btn__transparent.btn__upload(:class="{'disabled': item.po_btn_disabled }" @click.prevent="showUpload") {{translate('common.upload_signed_po')}}


</template>

<script>
export default {
  props:["item"],
  methods:{
    showUpload(){
      this.$store.dispatch("processes/SetUpload",true)
      this.$bvModal.show("sign-popup")
    },
    showDownload(){
      this.$store.dispatch("processes/SetUpload",false)
      this.$bvModal.show("sign-popup")
    },
  }
}
</script>

<style lang="css" scoped>
</style>
