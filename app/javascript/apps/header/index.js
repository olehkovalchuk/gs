import App from './app.vue';
import Vue from 'vue';
import store from "@/store";
import vSelect from 'vue-select';
import BootstrapVue from 'bootstrap-vue';
import router from "@/apps/marketplace/router";
import i18n from '@/mixins/i18n';
import gon from '@/mixins/gon';
import logger from '@/mixins/logger';

import VuePhoneNumberInput from 'vue-phone-number-input';
import VeeValidate, { Validator } from 'vee-validate';
import ru from 'vee-validate/dist/locale/ru';
import DisableAutocomplete from 'vue-disable-autocomplete';

import axios from 'axios'
import messages from '@/mixins/messages';
import user from '@/mixins/user';
import helper from '@/mixins/helper';


Vue.mixin(user);
Vue.mixin(helper);

Vue.component('v-select', vSelect);
import VueRecaptcha from 'vue-recaptcha';
Vue.component('vue-recaptcha', VueRecaptcha);

Vue.component('vue-phone-number-input', VuePhoneNumberInput);
Vue.mixin(i18n);
Vue.mixin(gon);
Vue.mixin(messages);

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

Validator.localize('ru', ru);
Vue.use(VeeValidate, {
  locale: 'ru',
});
Vue.use(BootstrapVue);
Vue.use(DisableAutocomplete);

document.addEventListener('DOMContentLoaded', () => {

})




function initApplication(){
  axios.defaults.headers.common['X-CSRF-TOKEN'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
  axios.defaults.headers.common['X-Requested-With']= 'XMLHttpRequest'
  axios.defaults.headers.common['Access-Control-Allow-Origin']= '*'
  axios.defaults.headers.common['Access-Control-Allow-Credentials']= true
  axios.defaults.headers.common['Access-Control-Allow-Methods']= 'GET, POST'
  axios.defaults.headers.common['Accept']= 'application/json, text/javascript, */*; q=0.01'
  axios.defaults.headers.common['Content-Type']= 'application/json; charset=UTF-8'
  axios.interceptors.request.use((config) => {
    if (config.url[config.url.length-1] !== '/') {
      config.url += '/';
    }
    return config
  })
  window.authApp = new Vue({
    router,
    store,
    render: h => h(App)
  }).$mount('#app-header', false);
}

document.addEventListener("DOMContentLoaded", () => {
  initApplication()
});












