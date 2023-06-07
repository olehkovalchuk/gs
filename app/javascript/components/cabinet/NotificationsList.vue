<template lang="pug">
  .notifications-list
    NotificationsListItem(
      v-for="item in items"
      :key="item.id"
      :item="item"
      )
</template>

<script>
import NotificationsListItem from '@/components/cabinet/NotificationsListItem';

export default {
  props:["items"],
  components: {
    NotificationsListItem,
  }

}
</script>

<style lang="scss" scoped>
</style>
