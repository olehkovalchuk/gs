<template lang="pug">
.members-list
  MemberListItem( :key="member.id" v-for="member in members" :item="member" )
</template>

<script>
import MemberListItem from '@/components/cabinet/MemberListItem';

export default {
  props: ["members"],
  components: {MemberListItem}
}
</script>

<style lang="scss" scoped>
</style>
