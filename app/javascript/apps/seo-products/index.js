import Vue from 'vue';
import store from '@/store';
import App from './app.vue';

import router from "@/apps/seo-products-slider/router";

function initApplication(mountEl){

  new Vue({
    store,
    router,
    render: createElement => {
      const context = {
        props: { ...mountEl.dataset },
      };
      return createElement(App, context);
    }
  }).$mount('#app-seo-products');

}

const timer = setInterval(function() {
    const mountEl = document.querySelector('#app-seo-products');

    if ( document.readyState === 'complete' && mountEl ) {
      initApplication(mountEl)
      clearInterval(timer);
    }
}, 10);

