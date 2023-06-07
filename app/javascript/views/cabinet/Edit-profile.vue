<template lang="pug">
  .container.mt-5
    .row
      .col-xl-3.col-lg-4
        CabinetSideNav
      .col-xl-9.col-lg-8
        .edit-page.default-block
          h2 {{translate("common.edit_info")}}
          EditProfileForm(:id="id", :endpoint="endpoint")
</template>

<script>
import CabinetSideNav from '@/components/cabinet/CabinetSideNav'
import EditProfileForm from '@/components/cabinet/EditProfileForm'
export default {
  props:["id"],
  components: {
    CabinetSideNav,
    EditProfileForm
  },
  computed:{
    endpoint(){
      return this.$route.name == 'edit-profile' ? 'cabinet' : 'cabinet-members'
    }
  }
}
</script>

<style lang="scss" scoped>

</style>
