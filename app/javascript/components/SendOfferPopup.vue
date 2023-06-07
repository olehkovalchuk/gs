<template lang="pug">
  b-modal(
    :title="'Supplier will answer'"
    id="send-offer-popup"
    centered
    dialog-class="popup-default popup-default--small"
    content-class="popup-default--content send-offer-popup"
    header-class="popup-default--header"
    body-class="popup-default--body"
    hide-footer
    ref="modal"
    )
    form
      .form_row
        input.txtinput(type="text" placeholder="Your Email")
      .form_row
        textarea.txtinput(placeholder="Your text")
      .btn-block 
        button.btn Send
</template>

<script>
export default {
  
}

</script>

<style lang="scss" scoped>
</style>
