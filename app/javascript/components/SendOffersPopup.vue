<template lang="pug">
  b-modal(
    title="Send my offers"
    id="send-my-offers"
    centered
    dialog-class="popup-default popup-default--small send-offers"
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
        //- span.close-btn(@click.prevent="clear") ✕
      textarea.txtinput(name="comment" :placeholder="translate('common.comment')" v-model.trim="comment" v-validate="'required|min:3'" :class="{ 'error': submited && errors.has('comment') }")
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
      if(modalId == "send-my-offers"){
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
          this.$store.dispatch('products/Send', this.getItem()).then(response => {
            this.$bvModal.hide("send-my-offers")
            if(response.success){
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
        id: this.$store.getters["products/getActiveItem"].id,
        ids: this.ids,
        comment: this.comment
      }
    },
  },
  computed: {

    items(){
      return this.$store.getters["products/getMyItems"]
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
      checked: {},
      comment: null,
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
