<template lang="pug">
  .container.mt-5
    .row
      .col-xl-3.col-lg-4
        CabinetSideNav
      .col-xl-9.col-lg-8
        .edit-page.default-block
          h2 {{translate("common.edit_info")}}
          EditCompanyForm
</template>

<script>
import CabinetSideNav from '@/components/cabinet/CabinetSideNav'
import EditCompanyForm from '@/components/cabinet/EditCompanyForm'
export default {
  components: {
    CabinetSideNav,
    EditCompanyForm
  }
}
</script>

<style lang="scss" scoped>

</style>
