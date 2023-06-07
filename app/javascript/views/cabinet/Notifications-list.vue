<template lang="pug">
  .container.mt-5
    .row
      .col-xl-3.col-lg-4
        CabinetSideNav
      .col-xl-9.col-lg-8
        router-link(
          to="/cabinet-menu"
          class="back-btn"
          )
          span.arrow-icon
          svg-icon(
            name="icon-bell"
            class="icon-bell back-btn--icon"
          )
          | {{translate("common.notifications")}}
        Notifications(:items="items")
        Pagination(v-on:update="update" :total="total" :currentPage="currentPage")
</template>

<script>
import CabinetSideNav from '@/components/cabinet/CabinetSideNav';
import Notifications from '@/components/cabinet/Notifications';
import Pagination from '@/components/Pagination';
export default {
  components: {
    CabinetSideNav,
    Notifications,
    Pagination
  },
  created(){
    this.load()
  },
  computed:{
    items(){
      return this.$store.getters['notifications/getItems'];
    },
    total(){
      return this.$store.getters['notifications/getTotal'];
    },
    currentPage(){
      return this.$store.getters['notifications/getPage'];
    }
  },
  methods:{
    load(page){
      this.$store.dispatch('notifications/SetPage', page );
      this.$isLoading('isLoading', 'items');
      this.$store.dispatch('notifications/List');
    },
    update({page}){
      this.load(page);
    }
  }
}
</script>

<style lang="scss" scoped>
</style>
