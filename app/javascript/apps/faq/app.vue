<template lang="pug">
  #faq
    loading(:active.sync='isLoading')
    Faq
</template>


<script>
  import Faq from "@/views/Faq.vue";
  export default {
    components: {
      Faq
    },
    data() {
      return {

      }
    },
    methods: {
    },
    computed:{
      isLoading(){
        return this.$store.getters["marketplace/getLoading"];
      }
    }
  }
</script>
