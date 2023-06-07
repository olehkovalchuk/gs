export default {
  methods: {
    $isLoading(key, name){
      this.$root[key] = true;
      this.$store.dispatch("marketplace/Loading", true)
      this.$store.subscribe((mutation) => {
        if(mutation.payload.type == name){
          this.$root[key] = false
          this.$store.dispatch("marketplace/Loading", false)
        }
      });
    }
  }
}
