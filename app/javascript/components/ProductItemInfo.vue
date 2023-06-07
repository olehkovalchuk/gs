<template lang="pug">
  .product-item--info
    .row
      .col-xl-8
        router-link.title-link( :to="routeParams" )
          h2.title {{ product.title }}
        .status-block
          CompanyStatus(:company="product.company")
          span(v-html="product.company.title")
        //- tablet and mobile
        .price-block-mobile
          strong.price(v-html="product.price")
          .delivery-info
            span {{ product.delivery }}
            span.info-icon(v-tooltip.bottom="product.tooltip")
        //- /tablet and mobile

        .collapsed(
          :class="{ active: menuShow, large: this.height > 100 && this.windowWidth > 576 }"
          ref="collapsed")
          InfoList(:data="product.info")
          LastBid(:data="product.bid")
        .read-more(v-if="this.height > 100 || this.windowWidth <= 576")
          span.read-more-link(
            @click="toggle"
            )
            span(v-if="!menuShow") {{translate("common.more")}}
            span(v-if="menuShow") {{translate("common.turn")}}
            span.arrow-icon(:class="{ active: menuShow }")
      .col-xl-4.product-item--price-block
        strong.price(v-html="product.price")
        .delivery-info
          span {{ product.delivery }}
          span.info-icon(v-tooltip.bottom="product.tooltip")
</template>

<script>
import InfoList from "@/components/InfoList";
import CompanyStatus from "@/components/CompanyStatus";
import LastBid from "@/components/LastBid";
export default {
  props: ['product'],
  components: {
    CompanyStatus,
    InfoList,
    LastBid
  },
  data() {
    return {
      menuShow: false,
      height: null,
      windowWidth: null
    }
  },
  computed: {
    routeParams(){
      if(this.$route.params.seo) {
        return { name: `${this.product.type}-new-route`, params: { id: this.product.id, seo: this.$route.params.seo }}
      } else {
        return { name: this.product.type, params: { id: this.product.id }}
      }
    }
  },
  methods: {
    toggle: function() {
      this.menuShow = !this.menuShow
    },
    getWindowSize() {
      this.windowWidth = window.innerWidth;
    }
  },
  mounted() {
    window.addEventListener('resize', this.getWindowSize)
    this.getWindowSize();
    this.height = this.$refs.collapsed.clientHeight;
  }
}
</script>

<style lang="scss" scoped>
.collapsed {
  &.large {
    height: 115px;
    overflow: hidden;
    &.active {
      height: auto;
      overflow: auto;
    }
  }
}

.title-link{
  color: #212529;
}
.read-more {
  text-align: right;
  font-size: 14px;
  .arrow-icon {
    top: 2px;
    &:before,
    &:after {
      height: 8px;
    }
    &:before {
      left: 5px;
    }
  }
}

</style>
