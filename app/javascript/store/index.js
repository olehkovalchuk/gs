import Vue from 'vue';

import Vuex from 'vuex';
import VuexPersistence from 'vuex-persist';

import account from './account'
import marketplace from './marketplace'
import companies from './companies'
import users from './users'
import bids from './bids'
import messages from './messages'
import notifications from './notifications'
import products from './products'
import transactions from './transactions'
import processes from './processes'
import invoices from './invoices'
import faq from './faq'
import subscriptions from './subscriptions'


const key = 'global_supplies';

const { plugin: vuexLocal } = new VuexPersistence({
  key,
  storage: window.localStorage,
  filter: mutation => mutation.type.search('LOCALSTORE') !== -1,
  reducer: function reducer(_ref2) {
    var user = _ref2.users.item_current;
    var active_type = _ref2.marketplace.active_type;
    var breadcrumbs = _ref2.marketplace.breadcrumbs;
    var last_items = _ref2.products.last_items;
    return {
      users: {
        user: user
      },
      users: {
        item_current: user
      },
      breadcrumbs: breadcrumbs,
      marketplace: {
        active_type: active_type
      },
      products: {
        last_items: last_items
      }
    };
  }
});
Vue.use(Vuex);

export default new Vuex.Store({
  strict: false,//process.env.NODE_ENV !== 'production',
  modules: {
    marketplace,
    account,


    users,
    companies,
    bids,
    messages,
    notifications,
    products,
    transactions,
    processes,
    invoices,
    faq,
    subscriptions
  },
  plugins: [vuexLocal]
});


