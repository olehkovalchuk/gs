<template lang="pug">
  .search-bar
    input.txtinput(type="text", placeholder="Enter product", v-model="title" v-on:keyup.enter="update")
    button.btn(name="search",@click.prevent="update") Search
</template>


<script>
  export default {
  props: ['type'],
  data() {
    return {
      title: ''
    }
  },
  methods:{
    update(){
      if(this.title){
        this.socialTrack('Search', 'search')
        this.socialTrack('Activities')
        window.location.href = window.location.origin + "/marketplace/offers?title=" + this.title
      }
    }
  },
}
</script>