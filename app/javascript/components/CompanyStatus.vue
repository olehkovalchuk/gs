<template lang="pug">
button.company-status(
  :class="company.rating_code"
  @click.prevent="show"
  )
  svg-icon(name="icon-status")
  span {{ company.rating_code }}
</template>

<script>
export default {
  props: ['company'],
  methods:{
    show(){
      this.$isLoading('isLoading', 'item_rating');
      this.$store.dispatch('companies/Rating', this.company.id ).then(response => {
        if(response.success){
          this.$bvModal.show("status-popup")
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
