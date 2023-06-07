<template lang="pug">
  .photo-preview--item
    span.close(@click="deleteImg") ×
    img(:src="image")
</template>

<script>
  export default {
    props: ["photo","destroy","index"],
    data(){
      return {
        image: null
      }
    },
    created(){
      if(typeof(this.photo) == "object"){
        this.createImage(this.photo)
      }
      else if(typeof(this.photo) == "string"){
        this.image = this.photo
      }      
    },
    methods: {
      createImage(file) {
        let reader = new FileReader();
        let vm = this;

        reader.onload = (e) => {
          vm.image = e.target.result
        };
        reader.readAsDataURL(file);
      },
      deleteImg() {
        this.$emit("delete-img",{destroy: this.destroy,index: this.index});
      }
    }
  }
</script>

<style lang="scss">
  .photo-preview {
    display: flex;
    flex-wrap: wrap;
    &--item {
      display: flex;
      justify-content: center;
      align-items: center;
      flex-shrink: 0;
      position: relative;
      width: 100px;
      height: 100px;
      margin: 10px;
      background-image: url("~assets/img/gs-logo.svg"), linear-gradient(90deg, #CD1515 0%, #E6145F 100%);
      background-repeat: no-repeat;
      background-position: center;
      background-size: cover;
      border-radius: 5px;
      overflow: hidden;
      img {
        width: 100%;
        height: auto;
      }
      .close {
        position: absolute;
        top: 1px;
        right: 5px;
        font-weight: normal;
        text-shadow: none;
        cursor: pointer;
        z-index: 2;
      }
    }
  }
</style>