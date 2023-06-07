<template lang="pug">
  .deal-switcher.deal-switcher-menu
    DealSwitcherMenuBtn(:type="type" v-for="type in dealTypes" :key="type")
</template>

<script>
import DealSwitcherMenuBtn from '@/components/DealSwitcherMenuBtn';
export default {
  components: {
    DealSwitcherMenuBtn,
  },
  data() {
    return {
      activeTab: "offers",
      dealTypes: ["offers","requests" ]
    }
  },
}
</script>

<style lang="scss" scoped>
</style>
