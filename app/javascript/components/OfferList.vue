<template lang="pug">
.offer-list
  OfferListItem(
    v-for="item in items"
    :options="options"
    :item="item"
    :key="item.id"
    :hasImg=" item.type == 'offer' "
    :hasHoverClass="hasHoverClass"
    :hasCheckBlock="hasCheckBlock"
    :hasShowCase="hasShowCase"
    @showPopup="callShowcasePopup"
  )
  ShowcasePopup(:item="popUpItem")

</template>

<script>
import OfferListItem from '@/components/OfferListItem';
import ShowcasePopup from '@/components/ShowcasePopup';

  export default {
    props: [
      'items',
      'options',
      'hasImg',
      'hasShowCase',
      'hasHoverClass',
      'hasCheckBlock'
    ],
    data() {
      return {
        popUpItem: {}
      }
    },
    components: {
      OfferListItem,
      ShowcasePopup
    },
    methods: {
      callShowcasePopup(item) {
        this.popUpItem = item;
        this.$bvModal.show("showcase-popup")
      },
    }
  }
</script>

<style lang="scss" scoped>
</style>
