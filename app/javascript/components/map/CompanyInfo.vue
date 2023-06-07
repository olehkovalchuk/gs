<template lang="pug">
div
  CompanyName(:company="company", :hasShowContacts='hasShowContacts' @show="showContacts")
  .company-info--content(
    :class="{ active: isActive }"
    )
    InfoList(:data="company.info" v-blur="blurConfig")
  //- .read-more
    //- span.read-more-link(
    //-   @click="toggle"
    //-   ) {{translate("common.info")}}
    //-   span.arrow-icon(:class="{ active: isActive }")
</template>

<script>
import CompanyName from '@/components/CompanyName';
import InfoList from '@/components/InfoList';
export default {
  props:["company"],
  components: {
    CompanyName,
    InfoList,
  },
  data() {
    return {
      isActive: true,
      hasShowContacts: true

    }
  },
  methods: {
    showContacts(){
      this.$isLoading('isLoading', 'item_current');
      this.$store.dispatch("companies/Contacts", this.company.id).then(response => {
        if(response.success){
          this.company = response.item
          this.isActive = true
          this.hasShowContacts = false
        }
      }, error => {
        console.log(error)
      })
    },
    toggle: function() {
      this.isActive = !this.isActive
    }
  },
  computed:{
    blurConfig(){
      return {
        isBlurred: this.company.blured,
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
