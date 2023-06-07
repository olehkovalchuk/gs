<template lang="pug">
  .cabinet-page.default-block
    .title
      h2 {{translate("common.my_requests")}}
      .title--btn-block
        .sort-bar
          button.sort-bar--btn(
            v-for="i in ['all','active','inactive']" 
            @click.prevent="setFilter(i)" 
            :class="{'active': activeTab == i}") {{translate('common.process_'+i)}}
        router-link(
          :to="{name: 'add-new-request'}"
          class="btn btn__plus"
        ) +

    EmptyList(v-if="0 == items.length && !$root.isLoading" type="request")
    OfferList(:items="items", :options="defaultOptions", hasHoverClass="true", hasShowCase="true" )

    Pagination(v-on:update="update" :total="total" :currentPage="currentPage")
</template>

<script>
import EmptyList from "@/components/cabinet/EmptyList"
import OfferList from "@/components/OfferList"
import Pagination from "@/components/Pagination"

export default {
  components: {
    OfferList,
    Pagination,
    EmptyList
  },
  methods:{
    load(page){
      this.$store.dispatch('products/SetPage', page );
      this.$isLoading('isLoading', 'items');
      this.$store.dispatch('products/List',{cabinet: true , by_company: this.$route.name.includes("company") });
    },
    update({page}){
      this.load(page);
    },
    setFilter(type){
      if('all' == type){
        this.$router.replace({ query: {} });
      }
      else if('active' == type){
        this.$router.replace({ query: {active:true} });
      }
      else{
        this.$router.replace({ query: {active:false} });
      }

    },
    processQuery(val){
      this.$store.dispatch("products/SetVisability", val.active)
      this.update(1)
    }
  },
  computed:{
    activeTab(){
      let active = this.$store.getters['products/getVisability']
      if(active == undefined){
        return 'all'
      }
      else{
        if(active){
          return 'active'
        }
        else{
          return 'inactive'
        }
      }
    },
    items(){
      return this.$store.getters['products/getItems'];
    },
    total(){
      return this.$store.getters['products/getTotal'];
    },
    currentPage(){
      return this.$store.getters['products/getPage'];
    }
  },
  created() {
    this.processQuery(this.$route.query)
  },
  data() {
    return {
      defaultOptions: [
        { key: "edit", title: this.translate("common.edit") },
        { key: "delete", title: this.translate("common.delete") }
      ],
      type: 'requests'
    }
  },
  watch: {
    '$route.query'(val) {
      this.processQuery(val)
    }
  },
}
</script>

<style lang="scss" scoped>

</style>
