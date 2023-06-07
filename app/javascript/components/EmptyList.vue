<template lang="pug">
.product-item
  .row
    .col-xl-12.col-lg-12.col-md-12.col-sm-12
      h2 {{translate("common.no_results")}}
      p {{translate("common.no_results_desc")}}
    .col-xl-12.col-lg-12.col-md-12.col-sm-12
      button.btn(@click="goTo('offer')") {{translate("common.be_the_first_one")}}
      button.btn.btn__transparent(@click="goTo('request')") {{translate("common.request_a_product")}}
</template>

<script>

export default {

  methods: {
    goTo(type){
      if(this.user.user_name){
        this.$router.push({name: 'add-new-' + type})
      }
      else{
        this.showLogin()
      }
    }
  }
}
</script>
<style lang="scss" scoped>
  .product-item {
    padding: 10px;
    text-align: center;
    .btn{
      margin-bottom: 10px;
      display: inline-block;
    }
    .btn__transparent{
      margin-left: 10px
    }
  }
 </style>
