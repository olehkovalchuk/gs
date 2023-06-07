<template lang="pug">
  a(
    href="#"
    class="request-list--item v-line-hover-effect"
    )
    .request-list--item--text
      p {{ request.name }}
      div
        strong(v-html="request.price")
        .delivery-info
          span {{ request.deliveryCompany }}
          span.info-icon(v-tooltip.bottom="request.tooltip")
    ContextMenu
</template>

<script>
import ContextMenu from '@/components/ContextMenu';
  export default {
    props: ['request'],
    components: {
      ContextMenu
    },
    data() {
      return {

      }
    },
    methods: {

    }
  }
</script>

<style lang="scss" scoped>
</style>
