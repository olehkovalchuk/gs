<template lang="pug">
  b-modal(
    :title="upload ? translate('common.place_your_document') : translate('common.download_document_to_sign')"
    id="sign-popup"
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
        .attachment
          template(v-for="doc in neededAttachments")
            .attachment--item(v-if="item.attachments[doc.id] && !upload" @click.prevent="download(doc.id)")
              svg-icon(name="icon-clip" class="mr-2")
              | {{doc.title}}
            .not-loaded(v-if="upload")
              input( :name="'file_' + doc.id" type="file" :id="'load-file-' + doc.id" :ref="'file_' + doc.id" @change="onFileChange($event, doc.id)")
              label.attachment--item(:for="'load-file-' + doc.id")
                svg-icon(name="icon-clip" class="mr-2")
                | {{doc.title}}
            span.error-msg(v-show="errors.has('file_' + doc.id)") {{translate("common.you_need_to_load_documents")}}
      .btn-block(v-if="upload")
        input.btn(type="submit" @click.prevent="submit()" :value="translate('common.save')")
</template>

<script>
import AddPhotoBtn from '@/components/AddPhotoBtn';


export default {
  components: {
    AddPhotoBtn
  },
  computed:{
    item(){
      return this.$store.getters['processes/getItem'];
    },
    upload(){
      return this.$store.getters['processes/isUpload'];
    },
    neededAttachments(){
      return (this.config.po_documents || []).filter(d=>d.need_sign);
    }
  },
  methods:{
    getItem(){
      return {files: this.files, id: this.item.process_id}
    },
    download(id){
      window.open(`/proceses/${this.item.process_id}/download?doc_id=${id}`, '_blank');
    },
    onFileChange(e, id){
      this.files[`doc_${id}`] = (e.target.files || e.dataTransfer.files)[0]
      this.errors.remove(`file_${id}`)
    },
    resetForm(){
      this.files = {}
    },
    async validateBidForm(){
      const toValidate = []
      for (var i = 0; i < this.neededAttachments.length; i++) {
        if(!this.files[`doc_${this.neededAttachments[i].id}`]){
          toValidate.push( this.$validator.validate(`file_${this.neededAttachments[i].id}`) )
        }
      }
      const results = Promise.all([...toValidate]);
      return (await results).every(isValid => isValid);
    },
    submit (e) {
      this.submitted = true;
      this.validateBidForm().then((result) => {
        if(result){
          this.$isLoading('isLoading', 'item_saved');
          this.$store.dispatch('processes/Upload', this.getItem()).then(response => {
            if(response.success){
              this.$bvModal.hide("sign-popup")
              this.$store.dispatch('marketplace/Success', this.translate("common.success_saved") )
              this.$isLoading('isLoading', 'item');
              this.$store.dispatch('processes/Show', response.id);
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
      files:{},
      submitted: false
    }
  },
  created(){
    this.$root.$on('bv::modal::show', (bvEvent, modalId) => {
      if(modalId == "sign-popup"){
        console.log(this.upload)
      }
    })

    for (var i = 0; i < this.neededAttachments.length; i++) {
      this.$validator.attach({ name: `file_${this.neededAttachments[i].id}`, rules: "required" });
    }
  },
  watch:{
    upload(val){
      console.log(val)
    }
  }
}

</script>

<style lang="scss" scoped>
.add-photo-btn{
  margin: 0 auto;
}
</style>
