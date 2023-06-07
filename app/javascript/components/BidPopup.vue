<template lang="pug">
  b-modal(
    :title="translate('common.place_your_bid')"
    id="bid-popup"
    centered
    dialog-class="popup-default popup-default--small"
    content-class="popup-default--content bid-popup"
    header-class="popup-default--header"
    body-class="popup-default--body"
    hide-footer
    ref="modal"
    )
    form.bid-form(@submit.prevent="handleSubmit()")
      .form_row
        SelectWithInput(
          :options="config.currencies"
          :placeholder="translate('common.price_mt')"
          v-model="select"
          :numbers="true"
          :class="{ 'error': submitted && errors.has('price') }"
          )
      .form_row
        textarea.txtinput(name="comment" :placeholder="translate('common.comment')" v-model.trim="comment" v-validate="{ required: true, min: 3 }" :class="{ 'error': submitted && errors.has('comment') }")
      .btn-block
        input.btn(type="submit" @click.prevent="submit()" :value="translate('common.bid')")
</template>

<script>
import SelectWithInput from '@/components/SelectWithInput';


export default {
  components: {
    SelectWithInput
  },
  computed:{
    product(){
      return this.$store.getters["products/getActiveItem"]
    }
  },
  mounted() {
    this.$root.$on('bv::modal::show', (bvEvent, modalId) => {
      if(modalId == "bid-popup"){
        this.resetBid()
      }
    })
  },
  methods:{
    resetBid(){
      this.select = { input: null, select: this.config.default_currency }
      this.comment = null
    },
    async validateBidForm(){
      const toValidate = [
        this.$validator.validate('comment'),
      ]
      if(!this.select.input){
        toValidate.push( this.$validator.validate('price') )
      }
      const results = Promise.all([...toValidate]);
      return (await results).every(isValid => isValid);
    },
    submit (e) {
      this.submitted = true;
      this.validateBidForm().then((result) => {
        if(result){
          this.$isLoading('isLoading', 'item_saved');
          this.$store.dispatch('products/Bid', {id: this.product.id, params: this.getBid()} ).then(response => {
            this.$bvModal.hide("bid-popup")
            if(response.success){
              this.socialTrack('BiddingOffers', 'bidding_offers')
              this.socialTrack('Activities')
              this.$store.dispatch('marketplace/Success', this.translate("common.success_saved") )
              setTimeout(() => {this.$router.go();}, 3000);
            }
            else{
              this.$store.dispatch('marketplace/Failure',response.message)
            }
          })
        }
      })
    },
    getBid(){
      return {
        amount: this.select.input,
        currency: this.select.select,
        comment: this.comment
      }
    }
  },
  data() {
    return {
      select: {
        input: null,
        select: null
      },
      comment: null,
      submitted: false
    }
  },
  created(){
    this.select.select = this.config.default_currency
    this.$validator.attach({ name: "price", rules: "required" });
  },
  watch: {
    select(val){
      if(val){
        this.errors.remove('price');
      }
    }
  }
}

</script>

<style lang="scss" scoped>
</style>
