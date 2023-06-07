<template lang="pug">
div
  .company-name-block( :class="{ v_line_hover_effect: hasHoverClass }" v-if="company" )
    .company-logo
      img(:src='company.logo')
    .company-name
      strong(v-html="company.title")
      CompanyStatus(:company="company")
      TradeTypeLabel(:company="company")
      //- a.btn.btn__small.btn__transparent.show-info-btn(href="#" @click.prevent="show" v-if="hasShowContacts") Show contact info
</template>

<script>
import CompanyStatus from '@/components/CompanyStatus';
import TradeTypeLabel from '@/components/TradeTypeLabel';

export default {
  props: ['company', 'hasHoverClass', 'hasTradeType', 'hasShowContacts'],
  components: {
    CompanyStatus,
    TradeTypeLabel,
  },
  methods:{
    // show(){
    //   this.socialTrack('ShowContact', 'show_contact')
    //   this.$emit("show")
    // }
  }
}
</script>

<style lang="scss" scoped>
  .show-info-btn {
    margin-top: 10px;
  }
</style>
