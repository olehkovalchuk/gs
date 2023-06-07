<template lang="pug">
  b-modal(
    id="showcase-popup"
    centered
    dialog-class="popup-default popup-default--small"
    content-class="popup-default--content "
    header-class="popup-default--header"
    body-class="popup-default--body"
    hide-footer
    ref="modal"
    )
    h2(v-show="$route.path == '/cabinet/offers'") Move offer to top?
    h2(v-show="$route.path == '/cabinet/requests'") Move request to top?
    .btn-block 
      button.btn.btn__transparent(@click="hidePopup()") Cancel
      button.btn(@click.prevent="toTop") Ok
</template>

<script>
export default {
  props: ["item"],
  data() {
    return {

    }
  },

  methods: {
    toTop(event){
      this.socialTrack('Activities')
      event.stopPropagation()
      this.$isLoading('isLoading', 'item_saved');
      this.$store.dispatch("products/ToTop", this.item.id).then(response => {
        this.hidePopup()
        if(response.success){
          if(this.item.type == 'offer') {
            this.socialTrack('OfferTop', 'offer_top')
          } else {
            this.socialTrack('RequestTop', 'request_top')
          }
          this.$store.dispatch('marketplace/Success', response.message )
          this.$isLoading('isLoading', 'items');
          this.$store.dispatch('products/List', {cabinet: true} );
        }
        else{
          this.$store.dispatch('marketplace/Failure', response.message )
        }
      }, error => {
        console.log(error)
      })        
    },

    hidePopup() {
      this.$bvModal.hide('showcase-popup')
    }
  }
}

</script>

<style lang="scss" scoped>

.btn-block {
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-between;
  margin-top: 25px;
  .btn {
    min-width: 150px;
  }
}

</style>
