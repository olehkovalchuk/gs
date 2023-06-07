<template lang="pug">
  ul.info-list
    li.info-list--item(v-for="data in companyData")
      strong {{ data.title }}
      span {{ data.value }}
</template>

<script>
export default {
  name: 'company-info-list',
  data() {
    return {
      companyData: [
        {title: 'Country:', value: 'Poland'},
        {title: 'Address:', value: 'ul. Smilikowskiego 1/3'},
        {title: 'Phone number:', value: '+380673744375'},
        {title: 'Nr. TIC:', value: '346-3u31'},
        {title: 'Bank Details:', value: '546885t4940-41'},
        {title: 'Swift code:', value: '12345'},
        {title: 'Iban No.:', value: '33341'},
        {title: 'Representative Attorney:', value: 'Pavlo Kolodii'}
      ]
    }
  }
}
</script>

<style lang="scss" scoped>
</style>
