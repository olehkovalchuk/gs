<template lang="pug">
  b-modal(
    :title="translate('common.place_your_invoice')"
    id="invoice-popup"
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
      .form_row
        textarea.txtinput(name="comment" :placeholder="translate('common.comment')" v-model.trim="comment" v-validate="{ required: true, min: 3 }" :class="{ 'error': submitted && errors.has('comment') }")
      .btn-block
        input.btn(type="submit" @click.prevent="submit()" :value="translate('common.save')")
</template>

<script>
import AddPhotoBtn from '@/components/AddPhotoBtn';


export default {
  props:['product'],
  components: {
    AddPhotoBtn
  },
  mounted() {
    this.$root.$on('bv::modal::show', (bvEvent, modalId) => {
      if(modalId == "invoice-popup"){
        this.resetForm()
      }
    })
  },
  methods:{
    resetForm(){
      this.file = ''
      this.comment = null
    },
    addImage({index,file}){
      this.file = file
      this.errors.remove('file');
    },
    async validateForm(){
      const toValidate = [
        this.$validator.validate('comment'),
      ]
      if(!this.file){
        toValidate.push( this.$validator.validate('file') )
      }
      const results = Promise.all([...toValidate]);
      return (await results).every(isValid => isValid);
    },
    submit (e) {
      this.submitted = true;
      this.validateForm().then((result) => {
        if(result){
          this.$isLoading('isLoading', 'item_saved');
          this.$store.dispatch('invoices/Save', this.getItem() ).then(response => {
            if(response.success){
              this.$bvModal.hide("invoice-popup")
              this.$store.dispatch('marketplace/Success', this.translate("common.success_saved") )
              this.$isLoading('isLoading', 'items');
              this.$store.dispatch("invoices/List")
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
        file: this.file,
        comment: this.comment
      }
    }
  },
  data() {
    return {
      comment: null,
      submitted: false,
      file: null
    }
  },
  created(){
    this.$validator.attach({ name: "file", rules: "image" });
  }
}

</script>

<style lang="scss" scoped>
.add-photo-btn{
  margin: 0 auto;
}
</style>
