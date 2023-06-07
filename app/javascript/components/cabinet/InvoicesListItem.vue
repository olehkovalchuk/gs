<template lang="pug">
div.default-table--item-wrapper.v_line_hover_effect(
  :class="{active: menuShow}"
  )
  span.show-more(
    @click="toggle"
    )
    span.arrow-icon(:class="{active: menuShow}")
    | Info
  .d-block.d-lg-none
    .default-table--heading
      span.id #
      span.user User
      span.status Status
      span.update Last update
      span.details Details
      span.delete Delete
  .default-table--item
    .id
      strong {{ invoice.id }}
    .user
      UserName(:item="invoice.user")
    .status
      strong {{ invoice.status }}
    .update {{ invoice.created_at }}
    .details
      button.btn.btn__transparent.btn__small(@click="open") {{translate("common.open")}}
    .delete(v-if="invoice.deletable")
      span.delete-btn(@click="destroy")
</template>

<script>
import UserName from '@/components/UserName';
export default {
  props: ["invoice"],
  components: {
    UserName
  },
  data() {
    return {
      menuShow: false
    }
  },
  methods:{
    toggle: function() {
      this.menuShow = !this.menuShow;
    },
    open(){
      window.open(`/invoices/${this.invoice.id}/`, '_blank');
    },
    destroy(){
      this.$isLoading('isLoading', 'item_deleted');
      this.$store.dispatch('invoices/Delete', this.invoice.id ).then(response => {
        if(response.success){
          this.$store.dispatch('marketplace/Success', this.translate("common.success_deleted") );
          this.$isLoading('isLoading', 'items');
          this.$store.dispatch("invoices/List")

        }
        else{
          this.$store.dispatch('marketplace/Failure',response.message)
        }
      })
    }
  }
}
</script>

<style lang="scss" scoped>
</style>
