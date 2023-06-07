<template lang="pug">
  b-modal(
    :title="'Join us in Wechat'"
    id="wechat-popup"
    centered
    dialog-class="popup-default popup-default--small"
    content-class="popup-default--content wechat-popup"
    header-class="popup-default--header"
    body-class="popup-default--body"
    hide-footer
    ref="modal"
    )
    p.subtitle Global Supplies Michel
    .img-holder
      img(src="@/assets/img/wechat_qr.jpg" alt="qr code for wechat contact")
    span Scan the QR code to add me on WeChat
</template>

<script>
export default {
  
}

</script>

<style lang="scss" scoped>
</style>
