<template lang="pug">
.product-item
  .row
    .col-xl-12.col-lg-12.col-md-12.col-sm-12
      h2 {{translate("common.no_" + type + "_title")}}
      p {{translate("common.no_" + type + "_desc")}}
    .col-xl-12.col-lg-12.col-md-12.col-sm-12
      button.btn(@click="goTo()") {{translate("common.no_" + type + "_btn")}}
</template>

<script>

export default {
  props: ['type'],
  methods: {
    goTo(){
      this.$router.push({name: 'add-new-' + this.type})
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
