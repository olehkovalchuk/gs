<template lang="pug">
.selected-company.default-block(v-if="company")
  CompanyName(:company = "company")
  InfoList(:data="company.info")
  UserName(:item="recepinet")
  .btn-block
    button.btn.btn__icon( @click.prevent="startChat(recepinet.id)" )
      svg-icon(name="icon-chat" class="mr-2")
      | {{translate('common.start_chat')}}
</template>

<script>
import CompanyName from "@/components/CompanyName";
import InfoList from "@/components/InfoList";
import UserName from "@/components/UserName";
export default {
  props:["company","recepinet"],
  components: {
    CompanyName,
    InfoList,
    UserName,
  }
}
</script>

<style lang="css" scoped>
</style>
