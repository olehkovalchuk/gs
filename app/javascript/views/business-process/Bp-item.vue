<template lang="pug">
  .container.mt-5
    .row
      .col-xl-3.col-lg-4
        CabinetSideNav
        .d-none.d-lg-block.d-xl-none
          SelectedProduct(:item="item")
          SelectedCompany(:company="company" :recepinet="recepinet")
      .col-xl-6.col-lg-8
        BpItem(:item="item")
      .col-xl-3.col-lg-3.d-none.d-xl-block
        SelectedProduct(:items="items")
        SelectedCompany(:company="company" :recepinet="recepinet")
    OrderPopup(:item="item" v-if="item.current_user")
</template>

<script>
import CabinetSideNav from "@/components/cabinet/CabinetSideNav";
import BpItem from "@/components/business-process/BpItem";
import OrderPopup from "@/components/OrderPopup";
import SelectedCompany from "@/components/business-process/SelectedCompany";
import SelectedProduct from "@/components/business-process/SelectedProduct";

export default {
  props:["id","offer_id"],
  components: {
    CabinetSideNav,
    BpItem,
    OrderPopup,
    SelectedCompany,
    SelectedProduct,
  },
  computed:{
    company(){
      return this.item.recepient_company
    },
    recepinet(){
      return this.item ? this.item.recepinet : {}
    },
    items(){
      return this.item.offer ? [this.item.offer] : []
    },
    item(){
      return this.id ? this.$store.getters['processes/getItem'] : this.$store.getters['processes/getFullItem']
    }
  },
  methods:{
    getItem(){
      console.log("wefwe")
      if(this.id){
        this.$isLoading('isLoading', 'item');
        this.$store.dispatch('processes/Show', this.id);
      }
      else if(this.offer_id && !Object.entries(this.item).length){
        this.$isLoading('isLoading', 'full_item');
        this.$store.dispatch('processes/New', this.offer_id);
      }
    }
  },
  data() {
    return {
      showModal: false
    }
  },
  watch: {
    // call again the method if the route changes
    '$route': 'getItem'
  },
  created(){
    this.getItem()
  }
}
</script>

<style lang="css" scoped>
</style>
