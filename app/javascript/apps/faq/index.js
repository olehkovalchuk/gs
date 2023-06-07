import Vue from 'vue';
import store from '@/store';
import app from './app.vue';
import router from "@/apps/marketplace/router";
import SvgIcons from '@/components/SvgIcons';
Vue.component('svg-icon', SvgIcons);

import loaderMixin from '@/mixins/loader';
Vue.mixin(loaderMixin);
import Loading from 'vue-loading-overlay';
import 'vue-loading-overlay/dist/vue-loading';


Vue.use(Loading, {
  // props
  color: 'red'
},{
  // slots
})
Vue.component('loading', Loading)


document.addEventListener('DOMContentLoaded', () => {
  if(document.getElementById('app-faq')){
    new Vue({
      store,
      router,
      render: h => h(app)
    }).$mount('#app-faq', false);
  }

})