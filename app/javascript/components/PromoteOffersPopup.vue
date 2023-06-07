<template lang="pug">
  b-modal(
    title="Promote my offers"
    id="promote-offers"
    centered
    dialog-class="popup-default--small send-offers"
    content-class="popup-default--content send-offers--content"
    header-class="popup-default--header send-offers--header"
    body-class="popup-default--body send-offers--body"
    hide-footer
    )
    em.subtitle {{translate("common.select_offers_to_sent")}}
    OfferList(:items="items", hasImg="true", hasCheckBlock="true" :ids="ids" )
    .send-offers--bottom
      .items-counter
        span {{selectedCount}} {{translate("common.items_selected")}}


      v-select(
        class="form-select"
        :options="promotion_types"
        :placeholder="translate('common.promo_type')"
        label="title" v-model="promo_type"
        v-validate="'required'"
        name="promo_type"
        :class="{ 'error': submited && errors.has('promo_type') }"
        )
      .btn-block
        a.btn(href="#" @click.prevent="send") {{translate("common.send")}}
</template>

<script>
import OfferList from '@/components/OfferList';
export default {
  components: {
    OfferList
  },
  mounted() {
    this.$root.$on('bv::modal::show', (bvEvent, modalId) => {
      if(modalId == "promote-offers"){
        this.comment = null
        this.$store.dispatch('products/ClearSelected')
      }
    })
  },
  methods:{
    clear(){
      this.$store.dispatch('products/ClearSelected')
    },
    send(){
      this.submited = true
      this.$validator.validateAll().then((result) => {
        if(result){
          this.$isLoading('isLoading', 'item_saved');
          this.$store.dispatch('products/SendToPromote', this.getItem()).then(response => {
            this.$bvModal.hide("promote-offers")
            if(response.success){
              this.socialTrack('OfferTopRequest', 'offer_top_request')
              this.socialTrack('Activities')
              this.$store.dispatch('marketplace/Success', this.translate("common.success_saved"))
            }
            else{
              this.$store.dispatch('marketplace/Failure',response.message)
            }
          })
        }
      })
    },
    getItem(){
      return {
        ids: this.ids,
        promo_type: this.promo_type.id,
      }
    },
  },
  computed: {

    items(){
      return this.$store.getters["products/getPromotedItems"]
    },
    ids(){
      return Object.keys(this.$store.getters["products/getSelected"]).filter(key => this.$store.getters["products/getSelected"][key])
    },
    selectedCount(){
      return this.ids.length;
    },
  },
  data() {
    return {
      promotion_types: [{id:'email',title:'Email promotion'},{id:'social',title:'Social media promotion'},{id:'complex',title:'Complex promotion'}],
      checked: {},
      promo_type: null,
      submited: false
    }
  }
}
</script>

<style lang="scss" scoped>
.send-offers--bottom .btn-block{
  margin-bottom: 20px;
}
.send-offers--bottom textarea.txtinput{
  height: 75;
}
</style>
