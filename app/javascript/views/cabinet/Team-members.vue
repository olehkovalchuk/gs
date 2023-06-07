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
            name="icon-company"
            class="icon-company back-btn--icon"
          )
          | {{translate("common.team_members")}}

        .cabinet-page.default-block
          .title
            h2 {{translate("common.team_members")}}
            router-link(
              :to="{name:'add-member',params:{id:0}}"
              class="btn btn__plus"
              v-if="user.can_add_member"
            ) +
          MemberList(:members="members")
</template>

<script>
import CabinetSideNav from "@/components/cabinet/CabinetSideNav";
import MemberList from "@/components/cabinet/MemberList";
export default {
  components: {
    CabinetSideNav,
    MemberList
  },
  computed: {
    members(){
      return this.$store.getters['users/getItems'].filter(obj => { return obj.id });
    }
  },
  created() {
    this.$isLoading('isLoading', 'items');
    this.$store.dispatch('users/List', this.fake )
  }
}
</script>

<style lang="scss" scoped>
</style>
