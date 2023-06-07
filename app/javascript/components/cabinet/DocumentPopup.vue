<template lang="pug">
  b-modal(
    :title="translate('common.place_your_document')"
    id="document-popup"
    centered
    dialog-class="popup-default popup-default--small"
    content-class="popup-default--content bid-popup"
    header-class="popup-default--header"
    body-class="popup-default--body"
    hide-footer
    ref="modal"
    )
    form.bid-form(@submit.prevent="submit")
      .form_row
        AddPhotoBtn(index="0" v-on:update="addImage" :invoice="true")
      .btn-block
        input.btn(type="submit" @click.prevent="submit()" :value="translate('common.save')")
</template>

<script>
import AddPhotoBtn from '@/components/AddPhotoBtn';


export default {
  components: {
    AddPhotoBtn
  },
  mounted() {
    this.$root.$on('bv::modal::show', (bvEvent, modalId) => {
      if(modalId == "document-popup"){
        this.resetForm()
      }
    })
  },
  methods:{
    resetForm(){
      this.file = ''
    },
    addImage({index,file}){
      this.file = file
      this.errors.remove('file');
    },
    async validateBidForm(){
      const toValidate = []
      if(!this.file){
        toValidate.push( this.$validator.validate('file') )
      }
      const results = Promise.all([...toValidate]);
      return (await results).every(isValid => isValid);
    },
    submit (e) {
      this.submitted = true;
      this.validateBidForm().then((result) => {
        if(result){
          this.$isLoading('isLoading', 'item_saved');
          this.$store.dispatch('companies/AddDocument', this.getItem() ).then(response => {
            if(response.success){
              this.$bvModal.hide("document-popup")
              this.$store.dispatch('marketplace/Success', this.translate("common.success_saved") )
            }
            else{
              this.$store.dispatch('marketplace/Failure',response.message)
            }
          })
        }
      })

    },
    getItem(){
      return {
        id: this.user.company_id,
        file: this.file,
        type: this.$store.getters['companies/getActiveDocType']
      }
    }
  },
  data() {
    return {
      submitted: false,
      file: null
    }
  },
  created(){
    this.$validator.attach({ name: "file", rules: "required" });
  }
}

</script>

<style lang="scss" scoped>
.add-photo-btn{
  margin: 0 auto;
}
</style>
