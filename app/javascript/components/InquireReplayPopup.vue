<template lang="pug">
  b-modal(
    :title="translate('common.replay_inquire')"
    id="replay-popup"
    centered
    dialog-class="popup-default popup-default--big"
    content-class="popup-default--content bid-popup"
    header-class="popup-default--header"
    body-class="popup-default--body"
    hide-footer
    ref="modal"
    )
    form.bid-form(@submit.prevent="handleSubmit()")
      .form_row
        p {{parent_text}}
      .form_row
        textarea.txtinput(name="message" :placeholder="translate('common.inquiry_replay_plc')" v-model.trim="inquiry.message" v-validate="{ required: true, min: 3 }" :class="{ 'error': submited && errors.has('message') }")
      .btn-block
        input.btn(type="submit" @click.prevent="submit()" :value="translate('common.send_replay')")
</template>

<script>

export default {
  computed:{
    parent_text(){
      return gon.config.inquiry_text
    }
  },
  mounted() {
    this.$root.$on('bv::modal::show', (bvEvent, modalId) => {
      if(modalId == "replay-popup"){
        this.reset()
      }
    })
  },
  methods:{
    reset(){
      this.inquiry = {
        message: null
      }
    },
    async validateForm(){
      const toValidate = [
        this.$validator.validate('message')
      ]
      const results = Promise.all([...toValidate]);
      return (await results).every(isValid => isValid);
    },
    submit (e) {
      this.submited = true;
      this.validateForm().then((result) => {
        if(result){
          this.$isLoading('isLoading', 'item_saved');
          this.$store.dispatch('messages/InquiryReplay', {id: gon.config.inquiry, params: this.getPayload()} ).then(response => {
            this.$bvModal.hide("replay-popup")
            if(response.success){
              this.socialTrack('InquiryReply', 'inquiry_reply')
              this.$store.dispatch('marketplace/Success', response.message )
              setTimeout(() => {window.localtion.search = '';}, 3000);

              
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
      inquiry: {
        message: null
      },
      submited: false
    }
  },
  created(){
  }
}

</script>

<style lang="scss" scoped>
</style>
