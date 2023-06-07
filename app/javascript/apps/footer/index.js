import Vue from 'vue';
import store from '@/store';
import app from './app.vue';
import BackToTop from 'vue-backtotop'

Vue.use(BackToTop)
import router from "@/apps/marketplace/router";


function initApplication(){
  new Vue({
    store,
    router,
    render: h => h(app)
  }).$mount('#app-footer', false);
}

document.addEventListener("DOMContentLoaded", () => {
  initApplication()
});