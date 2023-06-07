<template lang="pug">
  b-modal(
    :title="translate('common.leave_feedback')"
    id="feedback-popup"
    centered
    dialog-class="popup-default popup-default--small contact-popup"
    content-class="popup-default--content"
    header-class="popup-default--header"
    body-class="popup-default--body"
    hide-footer
    )
    form.mt-4
      .form_row
        textarea.txtinput(
          :placeholder="translate('common.your_message')"
          v-model="feedback.text"
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
          this.$isLoading('isLoading', 'feedback_saved');
          this.$store.dispatch('marketplace/Feedback', this.feedback ).then(response => {
            this.$bvModal.hide("feedback-popup")
            if(response.success){
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
      feedback:{
        text: null
      }

    }
  }
}
</script>

<style lang="scss" scoped>
</style>
