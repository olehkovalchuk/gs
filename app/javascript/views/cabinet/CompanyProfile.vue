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
        | {{translate("common.company_profile")}}
      CompanyBlock
</template>

<script>
import CabinetSideNav from "@/components/cabinet/CabinetSideNav";
import CompanyBlock from "@/components/cabinet/CompanyBlock";
export default {
  components: {
    CabinetSideNav,
    CompanyBlock,
  },
  created(){
    this.$isLoading('isLoading', 'item_current');
    this.$store.dispatch("companies/Show", this.user.company_id)
  }
}
</script>

<style lang="scss" scoped>
</style>
