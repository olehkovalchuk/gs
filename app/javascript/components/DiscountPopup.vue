<template lang="pug">
  b-modal(
    title="Still interested in a special price?"
    id="discount-popup"
    centered
    dialog-class="popup-default popup-default--small"
    content-class="popup-default--content popup--msg"
    header-class="popup-default--header"
    body-class="popup-default--body"
    hide-footer
    ref="modal"
    )
    .popup--body
      p If you are still interested in a special price for our membership, just text your contact number and we will contact you shortly!
      form.discount-form
        .row.form_row
          .col-sm-12
            vue-phone-number-input(v-model='phone' v-bind="telProps" @update="onUpdate" ref="phoneInput" )
            span.error-msg(v-show="submited && errors.has('phone')") {{translate("common.you_need_to_enter_correct")}} {{translate("common.fields.phone")}}
        .btn-block
          button.btn(@click.prevent="submit") Call me!
</template>

<script>
export default {
  computed:{
    message(){
      return (this.$store.getters["marketplace/getMessage"] || this.$store.getters["marketplace/getError"])
    },
    showLoginBtn(){
      return this.$store.getters["marketplace/needLogin"];
    },
    showJoinBtn(){
      return this.$store.getters["marketplace/needMembership"];
    }
  },
  methods:{
    close(){
      this.$bvModal.hide("discount-popup")
    },
    onUpdate (e){
      if(e.isValid){
        this.phoneIsValid = true
        this.errors.remove('phone')

        if(e.phoneNumber.includes('+')){

          let country = this.$refs.phoneInput.codesCountries.find( country => country.dialCode === e.formattedNumber.replace(e.nationalNumber, "").replace("+", "") );
          e.countryCode = country.iso2
        }
        this.phone = e.formattedNumber
      } else {
        this.phoneIsValid = false
      }
    },
    submit (e) {
      this.submited = true;

      this.$validator.validateAll().then((result) => {
        if(this.phoneIsValid){
          this.errors.remove('phone')
        }
        if(!this.errors.items.length){
          this.$isLoading('isLoading', 'item_saved');
          this.$store.dispatch('marketplace/Discount', {subscriber: {email: this.phone} } ).then(response => {
            if(response.success){
              this.$store.dispatch('marketplace/Success',response.message)
              this.close()
            }
            else{
              this.$store.dispatch('marketplace/Failure',response.message)
            }
          });
        }
      })
    },

  },
  data(){
    return {
      submited: false,
      phone: '',
      telProps: {

      }
    }
  },
  created(){
    this.$validator.attach({ name: "phone", rules: "required" });
  },
}

</script>

<style lang="scss" scoped>
</style>
