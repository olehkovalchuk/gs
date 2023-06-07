<template lang="pug">
  .container.mt-5
    .row
      .col-xl-3.col-lg-4
        CabinetSideNav
      .col-xl-9.col-lg-8
        router-link(
          :to="{name:'cabinet-menu'}"
          class="back-btn"
          )
          span.arrow-icon
          svg-icon(
            name="icon-user"
            class="icon-user back-btn--icon"
          )
          | {{translate("common.my_bp")}} 
        BusinessProcesses
        Pagination(v-on:update="update" :total="total" :currentPage="currentPage")
</template>

<script>
import CabinetSideNav from "@/components/cabinet/CabinetSideNav";
import Pagination from "@/components/Pagination";
import BusinessProcesses from "@/components/business-process/BusinessProcesses";
export default {
  components: {
    CabinetSideNav,
    BusinessProcesses,
    Pagination
  },
  created(){
    this.load()
  },
  computed:{
    items(){
      return this.$store.getters['processes/getItems'];
    },
    total(){
      return this.$store.getters['processes/getTotal'];
    },
    currentPage(){
      return this.$store.getters['processes/getPage'];
    }
  },
  methods:{
    load(page){
      this.$store.dispatch('processes/SetPage', page );
      this.$isLoading('isLoading', 'items');
      this.$store.dispatch('processes/List');
    },
    update({page}){
      this.load(page);
    }
  }


}
</script>

<style lang="css" scoped>
</style>
