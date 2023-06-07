<template lang="pug">
b-modal(
  :title="translate('common.safe_deal_title')"
  id="safe-popup"
  centered
  dialog-class="popup-default popup-default--small"
  content-class="popup-default--content datepicker-popup"
  header-class="popup-default--header"
  body-class="popup-default--body"
  hide-footer
  ref="modal"
  )
  .popup--body
    p(v-html="translate('common.start_safe_now_desc')")
    .btn-block
      a.btn(@click="openPo") {{ translate('common.start_safe_now') }}
</template>

<script>
export default {
  methods:{
    openPo(){
      this.showLogin()
    }
  }
}

</script>

<style lang="scss" scoped>

</style>
