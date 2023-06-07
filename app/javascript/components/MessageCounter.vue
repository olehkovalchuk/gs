<template lang="pug">
  button.message-counter(v-if="total > 0 || total > '0'") {{total}}
</template>

<script>
export default {
  computed:{
    total(){
      let total = this.new_messages_count + this.new_notifications_count;
      if(total > 9) {
        total = "9+"
      }
      return total
    }
  }
}
</script>

<style lang="scss" scoped>
</style>
