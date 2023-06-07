import Vue from 'vue';
import store from '@/store';
import App from './app.vue';
import VueAwesomeSwiper from 'vue-awesome-swiper';

import router from "@/apps/seo-products-slider/router";
import config from '@/mixins/config';

Vue.mixin(config);
Vue.use(VueAwesomeSwiper);

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
  }).$mount('#app-seo-products-slider');

}

const timer = setInterval(function() {
    const mountEl = document.querySelector('#app-seo-products-slider');

    if ( document.readyState === 'complete' && mountEl ) {
      initApplication(mountEl)
      clearInterval(timer);
    }
}, 10);