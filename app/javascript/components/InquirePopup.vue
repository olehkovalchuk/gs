<template lang="pug">
  b-modal(
    :title="translate('common.place_inquire')"
    id="inquiry-popup"
    centered
    dialog-class="popup-default popup-default--small"
    content-class="popup-default--content bid-popup"
    header-class="popup-default--header"
    body-class="popup-default--body"
    hide-footer
    ref="modal"
    )
    OfferList(:items="[product]", hasImg="true" )
    form.bid-form(@submit.prevent="handleSubmit()")
      .form_row
        input.txtinput(
          type="text"
          :placeholder="translate('common.your_name')"
          name="title"
          v-model="inquiry.title"
          v-validate="'required|min:4'"
          :class="{ 'error': submited && errors.has('title') }"
          )
      .form_row
        input.txtinput(
          type="email"
          :placeholder="translate('common.your_email')"
          v-model="inquiry.sender_email"
          v-validate="'required|email'"
          name="sender_email"
          :class="{ 'error': submited && errors.has('sender_email') }"
          )
      .form_row
        vue-phone-number-input(v-model='phone' v-bind="telProps" @update="onUpdate" ref="phoneInput" :class="{ 'error': submited && errors.has('phone') }")
        span.error-msg(v-show="submited && errors.has('phone')") {{translate("common.you_need_to_enter_correct")}} {{translate("common.fields.phone")}}
      .form_row
        textarea.txtinput(name="message" :placeholder="translate('common.inquiry_plc')" v-model.trim="inquiry.message" v-validate="{ required: true, min: 3 }" :class="{ 'error': submited && errors.has('message') }")
      .form_row(v-if="product.type == 'offer'")
        input.form-checkbox(
          type="checkbox"
          v-model="inquiry.post_request"
          id="post_request")
        label.form-checkbox__label(
          for="post_request"
          ) Post request on the marketplace

      .btn-block
        input.btn(type="submit" @click.prevent="submit()" :value="translate('common.send_inquire')")
</template>

<script>
import OfferList from '@/components/OfferList';


export default {
  components: {
    OfferList
  },
  computed:{
    product(){
      return this.$store.getters["products/getActiveItem"]
    }
  },
  mounted() {
    this.$root.$on('bv::modal::show', (bvEvent, modalId) => {
      if(modalId == "inquiry-popup"){
        this.reset()
      }
    })
  },
  methods:{
    reset(){
      this.inquiry = {
        message: null,
        title: null,
        sender_email: null,
        phone: null,
        country_code: null,
        phone_number: null,
        post_request: true,
      }
    },
    async validateForm(){
      const toValidate = [
        this.$validator.validate('message'),
        this.$validator.validate('title'),
        this.$validator.validate('sender_email'),
        this.$validator.validate('phone'),

      ]
      const results = Promise.all([...toValidate]);
      return (await results).every(isValid => isValid);
    },
    onUpdate(e){
      if(e.isValid){
        this.phoneIsValid = true
        this.errors.remove('phone')

        if(e.phoneNumber.includes('+')){

          let country = this.$refs.phoneInput.codesCountries.find( country => country.dialCode === e.formattedNumber.replace(e.nationalNumber, "").replace("+", "") );
          e.countryCode = country.iso2
        }

        this.inquiry.country_code = e.countryCode
        this.inquiry.phone = e.formattedNumber
        this.inquiry.phone_number = e.nationalNumber

      }
      else{
        this.phoneIsValid = false
      }
      return e;
    },
    submit (e) {
      this.submited = true;
      this.validateForm().then((result) => {
        if(this.phoneIsValid){
          this.errors.remove('phone')
        }
        if(!this.errors.items.length){
          this.$isLoading('isLoading', 'item_saved');
          this.$store.dispatch('products/Inquiry', {id: this.product.id, params: this.getPayload()} ).then(response => {
            this.$bvModal.hide("inquiry-popup")
            if(response.success){
              if(this.product.type == 'request'){
                this.socialTrack('ContactSupplier', 'contact_supplier')
                // this.socialTrack('Lead', 'buyer_Inquiry_submitted')
              }
              else{
                this.socialTrack('ContactSupplier', 'contact_supplier')
                // this.socialTrack('Lead', 'supplier_Inquiry_submitted')
              }
              this.$store.dispatch('marketplace/Success', response.message )
            }
            else{
              this.$store.dispatch('marketplace/Failure',response.message)
            }
          })
        }
      })
    },
    getPayload(){
      return this.inquiry
    }
  },
  data() {
    return {
      phone: '',
      inquiry: {
        message: null,
        title: null,
        sender_email: null,
        phone: null,
        country_code: null,
        phone_number: null,
        post_request: true,
      },
      submited: false,
      telProps: {
        'required': true,
        'default-country-code': gon.config.country,
        'preferred-countries': [gon.config.country],
        'valid-color': 'green',
        'error': false
      }
    }
  },
  created(){
    this.$validator.attach({ name: "phone", rules: "required" });
  }
}

</script>

<style lang="scss" scoped>
</style>
