import Vue from "vue";
import App from "./app.vue";
import BootstrapVue from 'bootstrap-vue';
import VTooltip from 'v-tooltip';
import router from "./router";
import store from "@/store";
import vSelect from 'vue-select';
import VueAwesomeSwiper from 'vue-awesome-swiper';
import SvgIcons from '@/components/SvgIcons';
import VueSlider from 'vue-slider-component';
import i18n from '@/mixins/i18n';
import gon from '@/mixins/gon';
import logger from '@/mixins/logger';
import user from '@/mixins/user';
import config from '@/mixins/config';
import messages from '@/mixins/messages';
import helper from '@/mixins/helper';

import moment from "moment";

import axios from 'axios'
import DisableAutocomplete from 'vue-disable-autocomplete';
import BackToTop from 'vue-backtotop'

Vue.use(BackToTop)

import VuePhoneNumberInput from 'vue-phone-number-input';
import 'vue-phone-number-input/dist/vue-phone-number-input.css';

Vue.component('vue-phone-number-input', VuePhoneNumberInput);
import * as VueGoogleMaps from 'vue2-google-maps';
import GmapCluster from 'vue2-google-maps/dist/components/cluster' // replace src with dist if you have Babel issues

import Loading from 'vue-loading-overlay';
import 'vue-loading-overlay/dist/vue-loading';
import VueRecaptcha from 'vue-recaptcha';

import VueToast from 'vue-toast-notification';
import vBlur from 'v-blur'

Vue.use(vBlur)
Vue.use(VueToast);

Vue.component('vue-recaptcha', VueRecaptcha);

Vue.use(Loading, {
  // props
  color: 'red'
},{
  // slots
})
import VueMoment from 'vue-moment'

Vue.use(VueMoment, {
    moment,
})

Vue.component('loading', Loading)
Vue.component('GmapCluster', GmapCluster)

import loaderMixin from '@/mixins/loader';
Vue.mixin(loaderMixin);

Vue.component('vue-phone-number-input', VuePhoneNumberInput);

import VeeValidate, { Validator } from 'vee-validate';
import ru from 'vee-validate/dist/locale/ru';

Validator.localize('ru', ru);
Vue.use(VeeValidate, {
  locale: 'ru',
  classNames: {
    valid: 'is-valid',
    invalid: 'error'
  },
  validity: true
});
Vue.use(VueGoogleMaps, {
  load: {
    key: 'AIzaSyApKxx6WJb2xECnnUwJJ7t_1ELGKzLcnEY',
  },
});
Vue.component('gmap-cluster', VueGoogleMaps.Cluster);

Vue.use(BootstrapVue);
Vue.use(VTooltip);
Vue.use(VueAwesomeSwiper);
Vue.mixin(i18n);
Vue.mixin(gon);
Vue.mixin(logger);
Vue.mixin(user);
Vue.mixin(config);
Vue.mixin(messages);
Vue.mixin(helper);


// Vue.use(DisableAutocomplete);

Vue.component('v-select', vSelect);
Vue.component('svg-icon', SvgIcons);
Vue.component('VueSlider', VueSlider)

Vue.config.productionTip = false;

// Vue.config.errorHandler = function(err, vm, info) {
//   // logger.exception(`Exception: ${err.toString()}\nInfo: ${info}`);
// }

// Vue.config.warnHandler = function(err, vm, info) {
//   // logger.error(`Error: ${err.toString()}\nInfo: ${info}`);
// }

// window.onerror = function myErrorHandler(errorMsg, url, lineNumber) {
//   console.log( errorMsg )
// }

import VueMeta from 'vue-meta'
Vue.use(VueMeta)

const eventHub = new Vue() // Single event hub

// Distribute to components using global mixin
Vue.mixin({
  data: function () {
    return {
      eventHub: eventHub
    }
  }
})

import ActionCableVue from 'actioncable-vue';

Vue.use(ActionCableVue, {
    debug: true,
    debugLevel: 'error',
    connectionUrl: window.gon.config.ws_protocol + '://' + window.gon.config.host + '/cable',
    connectImmediately: true
});






function initApplication(){
  axios.defaults.headers.common['X-CSRF-TOKEN'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
  axios.defaults.headers.common['X-Requested-With']= 'XMLHttpRequest'
  axios.defaults.headers.common['Access-Control-Allow-Origin']= '*'
  axios.defaults.headers.common['Access-Control-Allow-Credentials']= true
  axios.defaults.headers.common['Access-Control-Allow-Methods']= 'GET, POST'
  axios.defaults.headers.common['Accept']= 'application/json, text/javascript, */*; q=0.01'
  axios.defaults.headers.common['Content-Type']= 'application/json; charset=UTF-8'
  axios.defaults.addTrailingSlash = true
  axios.defaults.baseURL = `${window.location.origin}/${window.gon.config.market}/`

  axios.interceptors.request.use((config) => {
    if (config.url[config.url.length-1] !== '/') {
      config.url += '/';
    }
    return config
  })

  axios.interceptors.response.use(function (response) {
    store.dispatch('marketplace/NeedLogin',false)
    store.dispatch('marketplace/NeedMembership',false)
    if(response.data){
      if(response.data.status === 401){
        window.localStorage.clear()
        // store.dispatch('marketplace/Failure',response.data.message)
        store.dispatch('marketplace/NeedLogin',true)
      }
      else if(response.data.status === 403 ){
        store.dispatch('marketplace/Failure',response.data.message)
        window.localStorage.clear()
        if(router.app._route.meta.requiresAuth){
          window.location = "/login"
        }
      }
      else if(response.data.status === 405){
        store.dispatch('marketplace/NeedMembership',true)
      }
    }
    return response
  });

  // Vue.config.productionTip = false
  window.authApp = new Vue({
    router,
    store,
    render: h => h(App)
  }).$mount("#app");
}

// const timer = setInterval(function() {
//     if ( document.readyState === 'complete' ) {
//       initApplication()
//       clearInterval(timer);
//     }
// }, 10);

document.addEventListener("DOMContentLoaded", () => {
  initApplication()
});

