<template lang="pug">
  .search-bar
    input.search-bar--input(type="text", :placeholder="placeholder", v-model="title" v-on:keyup.enter="update")
    button.search-bar--btn(name="search",@click.prevent="update" :class="{'active': ($route.query && $route.query.title && $route.query.title.length), 'hover': title.length}")
</template>

<script>
export default {
  props: ['placeholder','type'],
  data() {
    return {
      title: ''
    }
  },
  mounted(){
    if(this.$store.getters[this.type + '/getFilters'].title){
      this.title = this.$store.getters[this.type + '/getFilters'].title
    }
  },
  methods:{
    update(){
      if(this.title){
        this.socialTrack('Search', 'search')
        this.socialTrack('Activities')
      }
      if(this.$route.query && this.$route.query.title == this.title ){
        return;
      }
      if(this.title){
        if(this.$route.params){
          this.$router.push({ name: this.$route.meta.productType, query: Object.assign({}, this.$route.query, {title: this.title} ) });
        }
        else{
          this.$router.push({ query: Object.assign({}, this.$route.query, {title: this.title} ) });
        }
        
      }
      else{
        this.$router.push({ query: Object.assign({}, this.$route.query,{title:''} ) });
      }
    }
  },
}
</script>

<style lang="scss" scoped>
</style>
