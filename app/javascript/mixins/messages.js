export default {
  methods: {
    startChat(recepient_id){
      this.$isLoading('isLoading', 'item_saved');
      this.$store.dispatch('messages/Create', recepient_id ).then(response => {
        if(response.success){
          if (!window.landing) {
            this.$router.push({ name: 'cabinet-chat',params:{id: response.id }})
          } else {
            window.location.href = `/marketplace/cabinet/conversations/${response.id}`
          }
        }
        else{
          this.$store.dispatch('marketplace/Failure',response.message)
        }
      })

    },
    startProcess(id){
      this.$isLoading('isLoading', 'full_item');
      this.$store.dispatch('processes/New', id ).then(response => {
        if(response.success){
          this.socialTrack('StartBusinessProcess', 'start_business_process')
          this.socialTrack('Activities')
          this.$router.push({ name: 'new-process',params:{offer_id: id }})
        }
        else{
          this.$store.dispatch('marketplace/Failure',response.message)
        }
      })
    }
  }
}
