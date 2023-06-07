<template lang="pug">
.attachment-block
  .attachment-block--title
    h4 {{translate('common.attachments')}}
    .attach-btn
      input(type="file" id="attach-file" @change="addFile")
      label.btn.btn__small.btn__transparent(for="attach-file")
        svg-icon(name="icon-clip")
        | {{translate('common.upload')}}

  .attachment(v-if="item.attachments && Object.keys(item.attachments).length")
    a.attachment--item(v-for="(attach,id) in item.attachments" :href="attach.url" target="_blank")
      svg-icon(name="icon-clip" class="mr-2")
      | {{attach.title}}
  .upload-block(@drop.prevent="addFile" @dragover.prevent)
    p {{translate('common.drag_file')}}
      input(type="file" ref="file" id="upload" @change="addFile")
      label(for="upload") {{translate('common.upload')}}
      |  {{translate('common.from_computer')}}

</template>

<script>
export default {
  props:["item"],
  methods:{
    dragover(){

    },
    addFile(e){
      console.log(e)
      let droppedFiles = e.target.files || e.dataTransfer.files;
      const files = [];
      if(!droppedFiles) return;
      ([...droppedFiles]).forEach(f => {
        files.push(f);
      });

      this.$isLoading('isLoading', 'item_saved');
      this.$store.dispatch('processes/AddFile', {files: files, id: this.item.process_id } ).then(response => {
        if(response.success){
          this.$store.dispatch('marketplace/Success', this.translate("common.success_saved") )
          this.$isLoading('isLoading', 'item');
          this.$store.dispatch('processes/Show', response.id);
        }
        else{
          this.$store.dispatch('marketplace/Failure',response.message)
        }
      })

    },
  }
}
</script>

<style lang="css" scoped>
</style>
