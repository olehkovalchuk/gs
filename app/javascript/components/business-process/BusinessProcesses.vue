<template lang="pug">
  .cabinet-page.default-block
    .title
      h2 {{translate('common.my_bp')}}
      .title--btn-block
        .sort-bar
          button.sort-bar--btn(
            v-for="i in ['all','active','inactive']"
            @click.prevent="setFilter(i)" 
            :class="{'active': activeTab == i}") {{translate('common.process_'+i)}}
    BpList
</template>


<script>
import BpList from "@/components/business-process/bp-list/BpList";
export default {
  components: {
    BpList,
  },
  methods:{
    setFilter(type){
      this.$store.dispatch("processes/SetFilters", type);
      this.$isLoading('isLoading', 'items');
      this.$store.dispatch("processes/List");
    }
  },
  computed:{
    activeTab(){
      return this.$store.getters["processes/getFilter"]
    }
  }
}
</script>

<style lang="scss" scoped>
  
</style>
