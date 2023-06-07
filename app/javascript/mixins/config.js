export default {
  computed: {
    config(){
      return this.$store.getters['marketplace/getGlobalConnfig']
    },
    captchaKey(){
      return '6Lf57bYUAAAAAIA46AcaBMi27R_FU00ZYCgnB5TE'
    }
  },
  methods:{
    onlyNumber ($event) {

      let theEvent = $event || window.event;

      if(theEvent.keyCode === 69){
        theEvent.returnValue = false;
        theEvent.preventDefault();
      }

      // Handle paste
      let key;
      if (theEvent.type === 'paste') {
        key = event.clipboardData.getData('text/plain');
        console.log(key, "if");
      } 
      else {
        key = theEvent.keyCode || theEvent.which;
        key = String.fromCharCode(key);
      }
      var regex = /[0-9]|\.|[^0-9]/;
      if( !regex.test(key) ) {
        theEvent.returnValue = false;
        if(theEvent.preventDefault){
           theEvent.preventDefault();
        }
      }
    }
  }
}
