<template lang="pug">
.notifications-block
  .notifications-block--title
    h4 {{translate('common.notifications')}} 
    //- span.read-more Previous
    //-   span.arrow-icon
  NotificationsList(:items="notifications")
</template>

<script>
import NotificationsList from '@/components/cabinet/NotificationsList';
export default {
  props:["notifications"],
  components: {
    NotificationsList
  }
}
</script>

<style lang="css" scoped>
</style>
