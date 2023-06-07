<template lang="pug">
  .last-bid-block(v-if="bid")
    .row
      .col-xl-4.col-lg-6.col-md-4.col-sm-5
        .last-bid-value
          strong {{translate("common.last_bid")}}
          strong.price(v-html="bid.amount")
      .col-xl-4.col-lg-6.col-md-4.col-sm-7
        CompanyName(:company="bid.company")
      .col-xl-4.col-lg-12.col-md-4
        CommentTextBlock(:comment="bid.comment")
</template>

<script>
import CompanyName from "@/components/CompanyName";
import CommentTextBlock from "@/components/CommentTextBlock";
export default {
  props:["bid"],
  components: {
    CompanyName,
    CommentTextBlock,
  }
}
</script>

