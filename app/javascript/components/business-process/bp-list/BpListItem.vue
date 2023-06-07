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
      span.product Product name
      span.partner Initiator / Partner
      span.status Status
      span.price Price
      span.type Type
      span.update Last update

  router-link.default-table--item( :to="{name:'process',params:{id: item.id}}" )
    .id
      strong {{ item.id }}
    .product
      ProductName(:item="item.offer")
    .partner
      .company-name
        .company-name--icon
          img(:src="item.company.logo")
        div
          p(v-html="bid.company.title")
          p {{item.sender}}
    .status
      strong(
        :class="{red : item.status == 'Cancelled' || item.status == 'Inactive'}"
        ) {{ item.status }}
    .price {{ item.price }}
    .type {{ item.item_type }}
    .update {{ item.updated_at }}
  .btn-block.d-flex.d-lg-none
    router-link(
      :to="{name:'process',params:{id: item.id}}"
      class="btn"
      ) {{translate('common.open')}}

</template>

<script>
import ProductName from '@/components/ProductName';
export default {
  props: ["item"],
  components: {
    ProductName
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
.default-table--item {
  color: #000;
}
.company-name {
  display: flex;
  align-items: center;
  &--icon {
    width: 50px;
    height: 50px;
    border-radius: 50%;
    overflow: hidden;
    img {
      width: 100%;
      height: auto;
      // border-radius: 50%;
    }
  }
  p {margin: 0;}
}
</style>
