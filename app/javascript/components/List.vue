<template lang="pug">

</template>

<script>
import OfferList from "@/components/OfferList";
import RequestList from "@/components/RequestList";

export default {
  data() {
    return {
      offersActive: true,
      rfqActive: false,
      config: {},
    }
  },
  components: {
    OfferList,
    RequestList,
  },
  methods:{
  },
  computed:{
    requestsIsActive(){
      return 'requests' == this.$store.getters['marketplace/getActiveType'];
    },
    offersIsActive(){
      return 'offers' == this.$store.getters['marketplace/getActiveType'];
    },
  }
}
</script>

