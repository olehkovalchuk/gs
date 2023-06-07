<template lang="pug">
  #app

    Header
    loading(:active.sync='isLoading')
    router-view
    Footer
    CompanyStatusPopup
    NotificationPopup(:message="message")
</template>

<script>
  // import '@/apps/footer';
  import Header from "@/components/Header.vue";
  import Footer from "@/components/Footer.vue";
  import CompanyStatusPopup from '@/components/CompanyStatusPopup';
  import NotificationPopup from '@/components/NotificationPopup';

  export default {
    channels: {
        ChatChannel: {
            connected() {
              //console.log('I ChatChannel connected.');
            },
            rejected() {},
            received(data) {
              if(data.new_message){
                window.location.reload()
              }
            },
            disconnected() {}
        },
        NotificationsChannel: {
            connected() {
              console.log('I NotificationsChannel connected.');
            },
            rejected() {},
            received(data) {
              const self = this
              this.$toast.open({
                message: data.text,
                type: "custom",
                duration: 100000,
                dismissible: true,
                onDismiss: function(){
                  if(!document.hidden){
                    self.$store.dispatch('notifications/Show', data.id);
                  }
                }
              })
            },
            disconnected() {}
        }
    },

    components: {
      Header,
      Footer,
      CompanyStatusPopup,
      NotificationPopup
    },
    mounted(){
      // if(!this.$route.name){
      //   this.$router.push({name:"login"})
      // }

      if(gon.message){
        this.$store.dispatch('marketplace/Success',gon.message )
      }

      this.$cable.subscribe({ channel: 'NotificationsChannel' });
      this.$cable.subscribe({ channel: 'ChatChannel' });
      if(this.$route.meta && this.$route.meta.showLogin){
        this.showLogin()
      }
      if(!window.gon.config.is_lighthouse){
        this.$isLoading('isLoading', 'global_config');
        this.$store.dispatch('marketplace/GlobalConfig');
      }

    },
    methods: {

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
      },
      needLogin(){
        return this.$store.getters["marketplace/needLogin"];
      }
    },
    watch: {
      needLogin(val){
        if(val){
          this.showLogin()
        }
      },
      message(val){
        if(val){
          this.$bvModal.show("notification-popup")
        }
      },
      error(val){
        if(val){
          this.$bvModal.show("notification-popup")
        }
      },
      '$route' (to, from) {
        if( to.meta.productType ){
          this.$store.dispatch("products/SetActiveItemsType", to.meta.productType)
        }
        if( to.meta.showLogin ){
          this.showLogin()
        }
        if('/' == to.path){
          this.$store.dispatch("marketplace/ClearBreadcrumps")
        }
        else{
          if(!to.params.back){
            this.$store.dispatch("marketplace/AddBreadcrumps",{ title: from.meta.breadcrump, path: from.path })
          }
        }
        this.$store.dispatch('users/CheckMessages');
      }
    }
  }
</script>

<style lang="scss">
  @import "@/assets/styles/main.scss";
</style>
