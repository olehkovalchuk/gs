<template lang="pug">
  .container.mt-5
    .row
      .col-xl-3.col-lg-4
        CabinetSideNav
</template>
<script>
import CabinetSideNav from '@/components/cabinet/CabinetSideNav';
export default {
  components: {
    CabinetSideNav
  }
}
</script>

<style lang="scss" scoped>
.side-nav {
  display: block;
}
</style>
