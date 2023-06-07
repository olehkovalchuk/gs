<template lang="pug">
div
  .upload-block(@drop.prevent="addFile" @dragover.prevent)
    p {{translate('common.drag_file')}} 
      input(type="file" ref="file" id="upload" @change="addFile" multiple accept="image/*")
      label(for="upload") 
        | {{translate('common.upload')}} 
      |  {{translate('common.from_computer')}}
  .photo-preview
    draggable(v-bind="dragOptions")
      transition-group(class="photo-preview--wraper")
        UploadPhotoPreview(
          v-for="(item, index) in images" 
          :photo="item" 
          destroy="true"
          :index="index"
          :key="index"
          v-on:delete-img="deleteImg"
          )
        UploadPhotoPreview(
          v-for="(item, index) in photos" 
          :photo="item"
          :key="index + item.name"
          @delete-img="deleteImg({index: index})"
          )
</template>

<script>
import draggable from 'vuedraggable';
import UploadPhotoPreview from "@/components/UploadPhotoPreview";
export default {
  props: ['images'] ,
  components: {
    UploadPhotoPreview,
    draggable
  },
  data() {
    return {
      photos: [],
      drag: false
    }
  },
  methods:{
    addFile(e){
      let droppedFiles = e.target.files || e.dataTransfer.files;
      let fileType = /image.*/;
      if(!droppedFiles) return;
      ([...droppedFiles]).forEach(f => {
        if(f.type.match(fileType) && f.size <= 10000000) {
          this.photos.push(f);
        }
      });
      this.$emit("update",this.photos);
    },

    deleteImg({index,destroy}) {
      if(destroy){
        this.$isLoading('isLoading', 'item_deleted');
        this.$store.dispatch('products/DeleteImage',{id: this.$store.getters['products/getItemEdited'].id, image_id: index}).then(response => {
          if(response.success){
            this.$store.dispatch('products/Edit',this.$store.getters['products/getItemEdited'].id)
          }
        })
      }
      else{
        this.photos.splice(index,1)
        this.$emit("update",this.photos);
      }
    }
  },
  computed: {
    dragOptions() {
      return {
        animation: 200,
        ghostClass: "ghost"
      };
    }
  },
  watch:{
    photos(val){
      console.log(val)
    }
  }
}
</script>

<style lang="scss" scoped>
.photo-preview {
  &--wraper {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    padding: 0px 18px;
  }
}

.ghost {
  opacity: 0.5;
  background: #c8ebfb;
}
</style>
