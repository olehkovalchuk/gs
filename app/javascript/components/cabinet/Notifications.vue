<template lang="pug">
  .notifications-page.default-block
    h2 Notifications
    NotificationsList(:items="items")
</template>

<script>
import NotificationsList from '@/components/cabinet/NotificationsList';
export default {
  props:["items"],
  components: {
    NotificationsList
  }
}
</script>

<style lang="scss" scoped>
</style>
