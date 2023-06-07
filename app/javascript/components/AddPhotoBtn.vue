<template lang="pug">
  .add-photo-btn
    input(type="file" @change="onFileChange")
    img(:src="image")
    .text-block
      svg-icon(name="icon-camera" class="add-photo-btn--icon")
      span {{translate("common.add_photo")}}
</template>

<script>
const MAX_FILE_SIZE = 10000000;

export default {
  props:["index",'image','invoice'],
  data(){
    return{
      invoiceImage: require('@/assets/img/invoice.png')
    }
  },
  watch: {
    image(val,old) {
      if(val == undefined || '' == val){
        this.image = old
      }
    }
  },
  methods: {
    onFileChange(e) {
      var files = e.target.files || e.dataTransfer.files;
      if (!files.length)
        return;
      this.createImage(files[0]);
    },
    createImage(file) {
      if(file.size > MAX_FILE_SIZE){
        this.$store.dispatch('marketplace/Failure',this.translate("common.file_to_large_1"))
        return;
      }
      var image = new Image();
      var reader = new FileReader();
      var vm = this;

      reader.onload = (e) => {
        vm.image = this.invoice ? this.invoiceImage : e.target.result
      };
      reader.readAsDataURL(file);
      this.$emit("update",{index: this.index, file: file})

    },
    removeImage: function (e) {
      this.image = '';
    }
  }
}
</script>

<style lang="scss" scoped>
</style>
