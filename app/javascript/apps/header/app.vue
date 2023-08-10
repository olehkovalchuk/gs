<template lang="pug">
  div
    loading(:active.sync='isLoading')
    HeaderLanding
    NotificationPopup
    DiscountPopup
    SpecialPricePopup
    ChangePasswordPopup
</template>

<script>
  import HeaderLanding from "@/components/Header.vue";
  import NotificationPopup from '@/components/NotificationPopup';
  import DiscountPopup from '@/components/DiscountPopup';
  import ChangePasswordPopup from '@/components/ChangePasswordPopup';
  import SpecialPricePopup from '@/components/SpecialPricePopup';

  export default {
    components: {
      HeaderLanding,
      NotificationPopup,
      DiscountPopup,
      ChangePasswordPopup,
      SpecialPricePopup
    },
    methods: {
    },
    mounted(){
      this.$store.dispatch('users/CheckMessages');

      if(gon.message){
        this.$store.dispatch('marketplace/Success',gon.message )
      }
      if(this.$route.meta && this.$route.meta.showLogin){
        this.showLogin()
      }
      if(window.token){
        this.$bvModal.show("change-passsword-popup")
      }
      if(window.showRestore){
        this.showLogin();
        this.$store.dispatch('account/AddItem', {type: 'auth', items: 'restore',action: window.RestoreAction || false });
      }
    },
    computed:{
      message(){
        return this.$store.getters["marketplace/getMessage"]
      },
      error(){
        return this.$store.getters["marketplace/getError"]
      },
      isLoading(){
        return this.$store.getters["marketplace/getLoading"];
      }
    },
    watch: {
      // '$route.meta' ({showLogin}) {
      //   if(showLogin){
      //     this.showLogin()
      //   }
      // },
      message(val){
        if(val){
          this.$bvModal.show("notification-popup")
        }
      },
      error(val){
        if(val){
          this.$bvModal.show("notification-popup")
        }
      }
    }
  }
</script>
<style lang="scss">
  @import "@/assets/styles/header_app.scss";

</style>
