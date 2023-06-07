<template lang="pug">
  .company-info.default-block
    .company-info--title
      CompanyName(:company="company" :hasShowContacts="hasShowContacts" @show="showContacts")
    .company-info--content(
      :class="{ active: menuShow }"
      )
      InfoList(:data="company.info"  v-blur="blurConfig")
      //- .company-info--content--btn-block
      //-   a.btn.btn__transparent.btn__small.btn__icon(href="#")
      //-     svg-icon(name="icon-download" class="mr-2")
      //-     span {{translate('common.po_template')}}
      //-   a.btn.btn__transparent.btn__small.btn__icon(href="#")
      //-     svg-icon(name="icon-download" class="mr-2")
      //-     span {{translate('common.contract_template')}}
    .read-more
      //- span.read-more-link(
      //-   @click="toggle"
      //-   ) {{translate('common.info')}}
      //-   span.arrow-icon(:class="{ active: menuShow }")
    .company-info--btn-block
      button.btn.btn__small.btn__transparent.show-info-btn(href="#" @click.prevent="showContacts" v-if="hasShowContacts") Show contact info
</template>

<script>
import CompanyName from "@/components/CompanyName";
import InfoList from "@/components/InfoList";
export default {
  props:['company'],
  components: {
    CompanyName,
    InfoList
  },
  data() {
    return {
      menuShow: true,
      hasShowContacts: true
    }
  },
  methods: {
    showContacts(){
      this.socialTrack('ShowContact', 'show_contact')
      this.socialTrack('Activities')
      this.$isLoading('isLoading', 'item_current');
      this.$store.dispatch("companies/Contacts", this.company.id).then(response => {
        if(response.success){
          this.company = response.item
          this.menuShow = true
          this.hasShowContacts = false
        }
      }, error => {
        console.log(error)
      })
    },
    toggle: function() {
      this.menuShow = !this.menuShow
    }
  },
  computed: {
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
</style>
