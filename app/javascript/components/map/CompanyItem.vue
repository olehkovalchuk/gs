<template lang="pug">
div(v-if="show" style="width: 100%;")
  CompanyName(
    :company="company"
    :hasHoverClass="true"
    :hasTradeType="true"
    active
    )
</template>

<script>
import CompanyName from '@/components/CompanyName';
import CompanyStatus from '@/components/CompanyStatus';
export default {
  components: {
    CompanyName,
    CompanyStatus,
  },
  props:["company"],
  computed:{
    show(){
      if(this.$store.getters['companies/getActiveCategory'].id){
        return this.company.category_ids.includes(this.$store.getters['companies/getActiveCategory'].id)
      }
      return true;
    }
  }
}
</script>

<style lang="scss" scoped>
</style>
