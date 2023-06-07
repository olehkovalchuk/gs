<template lang="pug">
  .cabinet-page.default-block
    .title
      h2 {{translate("common.invoices")}}
      a.btn.btn__plus(href="#" @click.prevent="addInvoice") +
    InvoicesList
    InvoicesPopup
</template>

<script>
import InvoicesList from '@/components/cabinet/InvoicesList';
import InvoicesPopup from '@/components/cabinet/InvoicesPopup';

export default {
  components: {
    InvoicesList,
    InvoicesPopup
  },
  data() {
    return {
    }
  },
  methods:{
    addInvoice(){
      this.$bvModal.show("invoice-popup")
    }
  }
}
</script>

<style lang="scss" scoped>

</style>
