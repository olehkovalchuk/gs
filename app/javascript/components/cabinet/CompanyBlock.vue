<template lang="pug">
  .cabinet-page.default-block
    .cabinet-page--title
      h2 {{translate("common.company_profile")}}
      router-link(
        :to="{name: 'edit-company'}"
        class="edit-link"
        ) {{translate("common.edit_info")}}
    .company-profile--title-buttons
      button.btn.btn__small(@click.prevent="addDoc('passport')" v-if="!company.pasport_verified && !company.passport_on_review") {{translate("common.add_passport")}}
      button.btn.btn__small(@click.prevent="addDoc('bill')" v-if="!company.bill_verified && !company.bill_on_review" ) {{translate("common.add_bill")}}

      a.btn.btn__transparent.btn__small.btn__icon(href="#" @click.prevent v-if="company.bill_verified") {{translate('common.bill_verified')}}
        svg-icon(name="icon-download" class="ml-2")
      a.btn.btn__transparent.btn__small.btn__icon(href="#" @click.prevent v-if="company.pasport_verified") {{translate('common.pasport_verified')}}
        svg-icon(name="icon-download" class="ml-2")

      a.btn.btn__transparent.btn__small.btn__icon(href="#" @click.prevent v-if="company.bill_on_review") {{translate('common.bill_on_review')}}
        svg-icon(name="icon-download" class="ml-2")
      a.btn.btn__transparent.btn__small.btn__icon(href="#" @click.prevent v-if="company.passport_on_review") {{translate('common.passport_on_review')}}
        svg-icon(name="icon-download" class="ml-2")



    .company-profile
      .row
        .col-xl-6.col-sm-7
          CabinetCompanyInfo(:company="company", :edit="true")
        .col-xl-6.col-sm-5
          TeamMembers(:fake="true")
    DealButtons(:item="company")
    ActivityChart
    DocumentPopup
</template>

<script>
import DealButtons from "@/components/cabinet/DealButtons";
import CabinetCompanyInfo from "@/components/cabinet/CabinetCompanyInfo";
import TeamMembers from "@/components/cabinet/TeamMembers";
import ActivityChart from "@/components/cabinet/ActivityChart";
import DocumentPopup from "@/components/cabinet/DocumentPopup";


export default {
  components: {
    DealButtons,
    CabinetCompanyInfo,
    TeamMembers,
    ActivityChart,
    DocumentPopup
  },
  computed:{
    company(){
      return this.$store.getters['companies/getItemCurrent'];
    },
  },
  methods:{
    addDoc(type){
      this.$store.dispatch("companies/SetDocType",type);
      this.$bvModal.show("document-popup")
    }
  },
  data() {
    return {
    }
  },
}
</script>

<style lang="scss" scoped>
</style>
