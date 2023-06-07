<template lang="pug">
  b-modal(
    title="Notification"
    id="notification-popup"
    centered
    dialog-class="popup-default popup-default--small"
    content-class="popup-default--content popup--msg"
    header-class="popup-default--header"
    body-class="popup-default--body"
    hide-footer
    ref="modal"
    )
    .popup--body
      p(v-html="message")
      .btn-block
        input.btn(type="submit" @click.prevent="goToLogin()" :value="translate('common.login')" v-if="showLoginBtn")
        input.btn(type="submit" @click.prevent="close()" :value="translate('common._OK')" v-if="!showLoginBtn && !showJoinBtn")
        a.btn(href="/pricing" target="_blank" @click="close()" v-if="showJoinBtn && !showLoginBtn") {{translate('common.join')}}
</template>

<script>
export default {
  computed:{
    message(){
      return (this.$store.getters["marketplace/getMessage"] || this.$store.getters["marketplace/getError"])
    },
    showLoginBtn(){
      return this.$store.getters["marketplace/needLogin"];
    },
    showJoinBtn(){
      return this.$store.getters["marketplace/needMembership"];
    }
  },
  methods:{
    close(){
      this.$bvModal.hide("notification-popup")
    },
    goToLogin(){
      this.showLogin()
      this.close()
    }
  },
  created(){
    this.$root.$on('bv::modal::hide', (bvEvent, modalId) => {
      if(modalId == "notification-popup"){
        this.$store.dispatch('marketplace/Failure',null)
        this.$store.dispatch('marketplace/Success',null)
        this.$store.dispatch('marketplace/NeedMembership',false)
      }
    })
  }
}

</script>

<style lang="scss" scoped>
</style>
