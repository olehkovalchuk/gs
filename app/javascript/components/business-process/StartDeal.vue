<template lang="pug">
.start-deal-block
  .left
    svg-icon(name="icon-deal" class="")
    p {{translate('common.po_ssafe_deal_desc')}}
    .btn-block
      a.btn.btn__transparent__white(:href="staticPath('services/safe_deal')" target="_blank") {{translate('common.learn_more')}}
      button.btn(@click.prevent="startSafe") {{translate('common.start_safe_deal')}}
  .right
    div
      p {{translate('common.or_submit_po')}}
      button.btn(v-b-modal.order-popup) {{translate('common.submit_po')}}


</template>

<script>
export default {
  props:["item"],
  methods:{
    startSafe(){
      this.$bvModal.show("safe-popup")
    }
  }
}
</script>

<style lang="css" scoped>
</style>
