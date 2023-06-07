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
      span.id ID
      span.product-name Product name
      span.partner Initiator / Partner
      span.status Status
      span.price Price
      span.update Last update
  .default-table--item
    .id
      strong {{ item.id }}
    .product-name
      .service(
        :class="item.item_type"
        )
        .service-icon
        | {{ item.description }}
    .partner
      UserName(:item="item.user")
    .status
      strong {{ item.status }}
    .price {{ item.amount }} {{ item.currency }}
    .update {{ item.created_at }}
</template>

<script>
import UserName from '@/components/UserName';
export default {
  props: ["item"],
  components: {
    UserName
  },
  data() {
    return {
      menuShow: false
    }
  },
  methods: {
    toggle: function() {
      this.menuShow = !this.menuShow;
    }
  }
}
</script>

<style lang="scss" scoped>
</style>
