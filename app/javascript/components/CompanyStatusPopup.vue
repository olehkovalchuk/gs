<template lang="pug">
  b-modal(
    :title="translate('common.company_status')"
    id="status-popup"
    centered
    dialog-class="popup-default"
    content-class="popup-default--content status-popup"
    header-class="popup-default--header"
    body-class="popup-default--body"
    hide-footer
    )
    .status-popup--content-block
      .subtitle
        strong.total-points
          | {{company.rating}}/
          span 100
          |  points
        em {{company.points_left}} {{translate("common.points_to")}} {{company.next_status}} {{translate("common.status")}}
      .scale-block(:class="company.rating_code + '-active'")
        .marker
        ul.status-scale
          li.status-scale--item.bronze
            | Bronze
          li.status-scale--item.silver
            | Silver
          li.status-scale--item.gold
            | Gold
          li.status-scale--item.platinum
            | Platinum
      .status-table
        .status-table--item(v-for="item in company.ratings")

          span {{item.title}}
          strong.points
            | {{item.value}}/
            span 25
        .status-table--item
          strong {{translate("common.total")}}
          strong.points
            | {{company.rating}}/
            span 100
    .btn-block
      a.btn(:href="staticPath('page/rating')" target="_blank") {{translate("common.how_it_works")}}
</template>

<script>

export default {
  data() {
    return {
    }
  },
  computed:{
    company(){
      return this.$store.getters["companies/getRating"]
    }
  }
}
</script>

<style lang="scss" scoped>
</style>
