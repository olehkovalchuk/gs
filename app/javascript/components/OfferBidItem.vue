<template lang="pug">
.bid-history--item(
  :class="{ active: menuShow }"
  )
  .bid-history--table--heading.mobile
    span.price {{translate('common.bid')}}
    span.company {{translate('common.company')}}
    span.comment {{translate('common.comment')}}
    span.date {{translate('common.date_header')}}
  .bid-history--item--content
    .price
      p(v-html="item.amount")
    .company
      CompanyName(:company="item.company")
    .comment
      CommentTextBlock(:comment="item.comment")
    .date
      p {{item.created_at}}
  span.read-more-link(
    @click="toggle"
    :class="{ active: menuShow }"
    )
    span.arrow-icon(
      :class="{ active: menuShow }"
      )
    span  {{translate('common.show_details')}}
</template>

<script>
import CompanyName      from "@/components/CompanyName.vue";
import CommentTextBlock from "@/components/CommentTextBlock.vue";

export default {
  props:['item'],
  components: {
    CompanyName,
    CommentTextBlock,
  },
  data() {
    return {
      menuShow: false,
    }
  },
  methods: {
    toggle: function() {
      this.menuShow = !this.menuShow
    }
  }
}
</script>

<style lang="scss" scoped>
.bid-history .company-logo{
    width: 60px;
    height: 60px;
}
.comment{
  width: 100%
}
</style>
