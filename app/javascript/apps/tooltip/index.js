import Vue from 'vue';
// import store from '@/store';
import app from './app.vue';
import VTooltip from 'v-tooltip';

Vue.use(VTooltip);

function initApplication(mountEl){
  new Vue({
    render: createElement => {
      const context = {
        props: { ...mountEl.dataset },
      };
      return createElement(app, context);
    }
  }).$mount('#' + mountEl.id);
}



const timer = setInterval(function() {
    if ( document.readyState === 'complete' ) {

      document.querySelectorAll('.js-tooltip').forEach(function(item) {
        let mountEl = document.querySelector('#' + item.id);
        if(mountEl){
          initApplication(mountEl);
        }
        
      });
      
      clearInterval(timer);
    }
}, 500);