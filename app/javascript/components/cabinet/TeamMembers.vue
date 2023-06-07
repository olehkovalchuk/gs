<template lang="pug">
  .members-list-wrapper
    strong.members-list--title {{translate("common.team_members")}}
    MemberList(
      :class="{ active: menuShow }"
      :members="members"
      )
    .members-list--btn-block(v-if="user.can_add_member")
      router-link.add-member(:to="{name:'add-member',params:{id:0}}")
        span.add-member--icon
        span {{translate("common.add_new_member")}}
      span.read-more-link(
        @click="toggle"
        v-if="members.length > 6"
        ) {{translate("common.more")}}
        span.arrow-icon(:class="{ active: menuShow }")
</template>

<script>
import MemberList from '@/components/cabinet/MemberList'
export default {
  props: ["fake"],
  components: {
    MemberList
  },
  computed: {
    members(){
      return this.$store.getters['users/getItems'];
    }
  },
  created(){
    this.$store.dispatch('users/List', this.fake )
  },
  data() {
    return {
      menuShow: false,
    }
  },
  methods: {
    toggle: function() {
      this.menuShow = !this.menuShow
    }
  }
}
</script>

<style lang="scss" scoped>
</style>
