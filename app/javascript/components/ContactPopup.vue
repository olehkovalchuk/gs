<template lang="pug">
  b-modal(
    :title="translate('common.contact_us')"
    id="contact-popup"
    centered
    dialog-class="popup-default popup-default--small contact-popup"
    content-class="popup-default--content"
    header-class="popup-default--header"
    body-class="popup-default--body"
    hide-footer
    )
    form.mt-4
      .form_row
        input.txtinput(
          type="text"
          :placeholder="translate('common.your_name')"
          name="name"
          v-model="contact.name"
          v-validate="'required|min:5'"
          :class="{ 'error': submited && errors.has('name') }"
          )
      .form_row
        input.txtinput(
          type="email"
          :placeholder="translate('common.your_email')"
          v-model="contact.email"
          v-validate="'required|email'"
          name="email"
          :class="{ 'error': submited && errors.has('email') }"
          )
      .form_row
        textarea.txtinput(
          :placeholder="translate('common.your_message')"
          v-model="contact.text"
          v-validate="'required|min:2'"
          name="text"
          :class="{ 'error': submited && errors.has('text') }"
          )
      .btn-block
        input.btn(type="submit" :value="translate('common.send')" @click.prevent="submit")
</template>

<script>
export default {
  methods:{
    submit(){
      this.submited = true;
      this.$validator.validateAll().then((result) => {

        if(result){
          this.socialTrack('AddCompanyMap', 'add_company_map')
          this.socialTrack('Activities')
          this.$isLoading('isLoading', 'contact_saved');
          this.$store.dispatch('marketplace/Contact', this.contact ).then(response => {
            this.$bvModal.hide("contact-popup")
            if(response.success){
              this.socialTrack('Contact', 'contact')
              this.$store.dispatch('marketplace/Success', this.translate("common.success_saved") )
            }
            else{
              this.$store.dispatch('marketplace/Failure',response.message)
            }
          })
        }
      })
    }
  },
  data() {
    return {
      submited: false,
      contact:{
        email: null,
        text: null,
        name: null
      }

    }
  }
}
</script>

<style lang="scss" scoped>
</style>
