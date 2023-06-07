<template lang="pug">
.container.mt-5
  .row
    .col-xl-3.col-lg-4
      CabinetSideNav(id="v-step-1")
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
        | {{translate("common.my_profile")}} 
      UserBlock
</template>

<script>
import CabinetSideNav from "@/components/cabinet/CabinetSideNav";
import UserBlock      from "@/components/cabinet/UserBlock";
export default {
  components: {
    CabinetSideNav,
    UserBlock
  },
  // mounted: function () {
  //   this.$tours['teachingTour'].nextStep()
  // }
}
</script>

<style lang="scss" scoped>
</style>
