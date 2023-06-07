export default {
  computed: {
    user(){
      return this.$store.getters['users/getItemCurrent']
    },
    new_messages_count(){
      return this.$store.getters['users/getMessagesCount']
    },
    new_notifications_count(){
      return this.$store.getters['users/getNotificationsCount']
    }
  },
  methods:{
    showLogin(){
      this.$store.dispatch('account/AddItem', {type: 'auth', items: 'login' });
      this.$bvModal.show("register-popup")
    },
    showPopup(item) {
      this.$bvModal.show(item)
    },
    socialTrack(fbEvent, glEvent, data){
      data = data || {}
      fbq('track', fbEvent, data);
      if(glEvent){
        dataLayer.push ({
          'event': glEvent
        })
      }
    }
  }
}
