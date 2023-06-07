<template lang="pug">
  b-modal(
    title="Congratulation"
    id="congratulation-popup"
    centered
    dialog-class="popup-default popup-default--small"
    content-class="popup-default--content popup--msg"
    header-class="popup-default--header"
    body-class="popup-default--body"
    hide-footer
    ref="modal"
    )
    .popup--body
      p {{translate('common.contrats_title')}}
      .btn-block
        input.btn(type="submit" @click.prevent="goTo()" :value="translate('common.congrats_btn') + ' ' + type" )
</template>

<script>
export default {
  computed:{
    type(){
      return this.$store.getters["products/getActiveItemType"]
    }
  },
  methods:{
    goTo(){
      this.$router.push({name: 'add-new-' + this.type})
    }
  }
}

</script>

<style lang="scss" scoped>
</style>
