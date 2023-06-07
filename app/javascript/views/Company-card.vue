<template lang="pug">
  .default-block.adding-form.adding-form--offer.mt-5.company-card
    .company-card--item.default-block.general-info
      .general-info--wrapper
        CabinetCompanyInfo(:company="company", :editLink="false", :hasShowContacts='hasShowContacts' @show="showContacts")
        CertificateList(:items="company.certificates")

      .general-info--btn-block
        div
          button.btn(@click.prevent="goToMap") {{translate("common.view_on_map")}}
          button.btn.btn__transparent.btn__icon( @click.prevent="startChat(company.r_id)")
            svg-icon(name="icon-chat" class="mr-2")
            | {{translate("common.start_chat")}}


    .company-card--item.default-block(v-if="offers.total")
      h2 {{translate("common.company_offers")}}
      OfferList(:items="offers.items", hasImg="true", hasHoverClass="true")
      Pagination(v-on:update="update" :total="offers.total" :currentPage="offersCurrentPage"  type="Offers")
    .company-card--item.default-block(v-if="requests.total")
      h2 {{translate("common.company_requests")}}
      OfferList(:items="requests.items", hasHoverClass="true")
      Pagination(v-on:update="update" :total="requests.total" :currentPage="requestsCurrentPage" type="Requests")
</template>

<script>
import CabinetCompanyInfo from '@/components/cabinet/CabinetCompanyInfo';
import OfferList from '@/components/OfferList';
import Pagination from '@/components/Pagination';
import CertificateList from '@/components/CertificateList';

export default {
  props:['id'],
  name: 'company',
  components: {
    CabinetCompanyInfo,
    OfferList,
    Pagination,
    CertificateList
  },

  data() {
    return {
      hasShowContacts: true,
      editLink: false,
      page:{
        Requests: 1,
        Offers: 1
      }
    }
  },
  computed:{
    company(){
      return this.$store.getters['companies/getItemCurrent'];
    },
    offers(){
      return this.$store.getters['companies/getOffers'];
    },
    requests(){
      return this.$store.getters['companies/getRequests'];
    },
    offersCurrentPage(){
      return this.page.Offers;
    },
    requestsCurrentPage(){
      return this.page.Requests;
    },
  },
  watch: {
    // call again the method if the route changes
    '$route': 'getCompany'
  },
  methods: {
    showContacts(){
      this.$isLoading('isLoading', 'item_current');
      this.$store.dispatch("companies/Contacts", this.company.id).then(response => {
        if(response.success){
          this.company = response.item
          this.hasShowContacts = false
        }
      }, error => {
        console.log(error)
      })
    },
    update({page,type}){
      this.page[type] = page
      this.$store.dispatch(`companies/${type}`,{id:this.id, page: page});
    },
    getCompany(){
      this.$isLoading('isLoading', 'item_current');
      this.$store.dispatch('companies/Show',this.id);
      this.$store.dispatch('companies/Offers',{id:this.id, page: 1});
      this.$store.dispatch('companies/Requests',{id:this.id, page: 1});
    },
    goToMap(){
      if(this.company.on_map){
        this.$router.push({name: "map_item", params:{id:this.company.id}})
      }
      else{
        this.$store.dispatch('marketplace/Success', this.translate("common.company_isnt_on_map") )
      }
    }
  },
  created(){
    this.$isLoading('isLoading', 'item_current');
    this.getCompany()
  }
}
</script>

<style lang="scss" scoped>
.adding-form button.btn{
  width: inherit;
}
</style>
