import Vue from 'vue';
import store from '@/store';
import app from './app.vue';
import config from '@/mixins/config';


const eventHub = new Vue() // Single event hub

// Distribute to components using global mixin
Vue.mixin({
  data: function () {
    return {
      eventHub: eventHub
    }
  }
})
function initApplication(){
  if(document.querySelector('#app-add-offer-form')){
    Vue.mixin(config);
  }
  else {
    return
  }
  new Vue({
    store,
    render: h => h(app)
  }).$mount('#app-add-offer-form', false);
}

const timer = setInterval(function() {
    if ( document.readyState === 'complete' ) {
      initApplication()
      clearInterval(timer);
    }
}, 10);