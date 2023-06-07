import Vue from 'vue';
import store from '@/store';
import app from './app.vue';

function initApplication(mountEl){
  new Vue({
    store,
    render: h => h(app)
  }).$mount('#app-select-category', false);
}

const timer = setInterval(function() {
    const mountEl = document.querySelector('#app-select-category');

    if ( document.readyState === 'complete' && mountEl ) {
      initApplication(mountEl)
      clearInterval(timer);
    }
}, 10);