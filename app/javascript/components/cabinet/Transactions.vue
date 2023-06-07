<template lang="pug">
  .cabinet-page.default-block
    .title
      h2 {{translate("common.transactions")}}
    TransactionsList
</template>

<script>
import TransactionsList from '@/components/cabinet/TransactionsList';

export default {
  components: {
    TransactionsList
  },
  data() {
    return {
    }
  }
}
</script>

<style lang="scss" scoped>

</style>
