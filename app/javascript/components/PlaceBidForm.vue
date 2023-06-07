<template lang="pug">
  .bid-block
    strong.bid-block--title {{translate("common.place_your_bid")}}
    form.bid-form(@submit.prevent="handleSubmit()")
      SelectWithInput(
        :options="config.currencies"
        :placeholder="translate('common.price_mt')"
        v-model="select"
        :numbers="true"
        :class="{ 'error': submitted && errors.has('price') }"
        )
      .bid-form--comment-input
        input.txtinput(type="text"  :placeholder="translate('common.comment')" v-model.trim="comment" name="comment" v-validate="{ required: true, min: 3 }" :class="{ 'error': submitted && errors.has('comment') }" )
      .bid-form--submit
        input.btn(type="submit" @click.prevent="submit()" :value="translate('common.bid')")
</template>

<script>
import SelectWithInput from '@/components/SelectWithInput';
export default {
  props:['product'],
  components: {
    SelectWithInput
  },
  methods:{
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
            if(response.success){
              this.clear()
              this.socialTrack('BiddingOffers', 'bidding_offers')
              this.socialTrack('Activities')
              this.$store.dispatch('marketplace/Success', this.translate("common.success_saved") )
            }
            else{
              this.$store.dispatch('marketplace/Failure',response.message)
            }
          })
        }
      })
    },
    clear(){
      this.submitted = false
      this.comment = null
      this.select = {input: null, select: this.config.default_currency}
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
        select: "USD"
      },
      comment: null,
      submitted: false
    }
  },
  created(){
    // this.select.select = this.config.default_currency
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
