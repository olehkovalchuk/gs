<template lang="pug">
.company-info(:info="company")
  .company-info--logo
    img(:src="company.logo || defaultLogo")
  .company-info--text
    h3(v-html="company.title")
    CompanyStatus(:company="company")
    TradeTypeLabel(:company="company")
    a.btn.btn__small.btn__transparent.show-info-btn(href="#" @click.prevent="show" v-if="hasShowContacts" ) Show contact info
    InfoList(:data="company.info" v-blur="blurConfig" )
</template>

<script>
import InfoList from "@/components/InfoList";
import CompanyStatus from "@/components/CompanyStatus";
import TradeTypeLabel from "@/components/TradeTypeLabel";

export default {
  props: ['company','edit','hasShowContacts'],
  components: {
    InfoList,
    CompanyStatus,
    TradeTypeLabel
  },
  data() {
    return {
      defaultLogo: require('@/assets/img/logo.svg')
    }
  },
  methods:{
    show(){
      this.$emit("show")
    }
  },
  computed:{
    blurConfig(){
      return {
        isBlurred: false,
        opacity: 0.3,
        filter: 'blur(2.5px)',
        transition: 'all .3s linear'
      }
    }
  }
}
</script>

<style lang="scss" scoped>
  .company-info {
    display: flex;
    &--logo {
      width: 110px;
      height: 110px;
      border-radius: 50%;
      overflow: hidden;
      // background: url('~assets/img/company-mask.png');
      // background-size: cover;
      img {
        width: 100%;
        height: auto;
      }
    }
  }

  .show-info-btn {
    margin-top: 10px;
  }
</style>
