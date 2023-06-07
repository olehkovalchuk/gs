<template lang="pug">
  .sort-bar.sort-bar__small
    a.sort-bar--btn(href="#" @click.prevent="filter('year')") {{translate("common.last_year")}}
    a.sort-bar--btn(href="#" @click.prevent="filter('quarter')") {{translate("common.last_quarter")}}
    a.sort-bar--btn(href="#" @click.prevent="filter('week')") {{translate("common.last_week")}}
</template>

<script>
export default {
  props: ['chart'],
  methods:{
    filter(period){
      this.$emit("update", {period: period, chart: this.chart})
    }
  }
}
</script>

<style lang="scss" scoped>
</style>
