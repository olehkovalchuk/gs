<template lang="pug">
  .deal-switcher
    a(
      href="#"
      v-bind:class="{ 'router-link-active': (activeTab == type) }"
      v-for="type in dealTypes"
      :key="type"
      @click.prevent="changeTab" :data-type="type"
      class="deal-switcher--link"
    ) {{translate("common." + type)}}
</template>

<script>
export default {
  methods:{
    changeTab(event){
      this.activeTab = event.currentTarget.getAttribute('data-type')
      this.$router.push({name:this.activeTab})
      // this.$emit("update")
    },
    setActiveTab(){
      if("marketplace"==this.$route.name){
        this.activeTab = 'offers';
      }
      else{
        this.activeTab = this.$route.name
      }
    }
  },
  computed:{

  },
  watch: {
    '$route.name'(name) {
      this.setActiveTab()
    }
  },
  data() {
    return {
      activeTab: "offers",
      dealTypes: ["offers","requests" ]
    }
  },
  created(){
    this.setActiveTab()
    this.$store.dispatch("products/SetActiveItemsType", this.activeTab)
  }
}
</script>

<style lang="scss" scoped>

</style>
