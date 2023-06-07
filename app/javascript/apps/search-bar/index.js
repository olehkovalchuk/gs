import Vue from 'vue';
import store from '@/store';
import app from './app.vue';
import router from "@/apps/marketplace/router";


function initApplication(){
  new Vue({
    store,
    router,
    render: h => h(app)
  }).$mount('#app-search-bar', false);
}

const timer = setInterval(function() {
    const mountEl = document.querySelector('#app-search-bar');

    if ( document.readyState === 'complete' && mountEl ) {
      initApplication()
      clearInterval(timer);
    }
}, 500);