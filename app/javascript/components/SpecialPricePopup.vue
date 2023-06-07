<template lang="pug">
  b-modal(
    title="Get a discount"
    id="special-price-popup"
    centered
    dialog-class="popup-default popup-default--small"
    content-class="popup-default--content popup--msg"
    header-class="popup-default--header"
    body-class="popup-default--body"
    hide-footer
    ref="modal"
    )
    .popup--body
      form.special-form
        .row.form_row
          .col-sm-12
            v-select(
              class="form-select"
              :options="prices"
              :placeholder="translate('common.price_package')"
              label="title" v-model="price"
              name="price"
              v-validate="'required'"
              :class="{ 'error': submited && errors.has('price') }"
              )
        .btn-block
          button.btn(@click.prevent="submit") Get my special price
</template>

<script>
export default {
  computed:{

  },
  methods:{
    close(){
      this.$bvModal.hide("special-price-popup")
    },
    submit (e) {
      if(this.submited){
        return
      }
      this.submited = true;
      this.$validator.validateAll().then((result) => {
        if(!this.errors.items.length){
          this.$isLoading('isLoading', 'item_saved');
          this.$store.dispatch('transactions/Create', this.price.id ).then(response => {
            if(response.url){
              this.close()
              this.submited = false
              window.location.href = response.url
            }
            else{
              this.$store.dispatch('marketplace/Failure',response.message)
            }
          });
        }
      })
    },
    onUpdate(){

    }
  },
  data(){
    return {
      submited: false,
      price: null,
      prices: [],
      phone: '',
      telProps: {

      }
    }
  },
  created(){
    this.prices = window.gon.config.prices
  }
}

</script>

<style lang="scss" scoped>
</style>
