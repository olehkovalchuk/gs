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
          | {{translate('common.invoices')}}
        Invoices
        Pagination
</template>
<script>
import CabinetSideNav from '@/components/cabinet/CabinetSideNav';
import Invoices from '@/components/cabinet/Invoices';
import Pagination from '@/components/Pagination';
export default {
  components: {
    CabinetSideNav,
    Invoices,
    Pagination
  }
}
</script>

<style lang="scss" scoped>
</style>
