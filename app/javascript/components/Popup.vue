<template lang="pug">
  .popup
    .popup--content.popup--content--small.popup--msg
      .popup--header
        span.close(@click="$emit('close')")
        h2 Popup
      .popup--body
        p Popup content
        .btn-block
          button.btn Next
</template>

<script>
export default {
  data() {
    return {
      showModal: false,
    }
  },
}
</script>

<style lang="scss" scoped>
</style>
