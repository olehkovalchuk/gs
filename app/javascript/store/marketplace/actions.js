import HTTP from 'axios';
import i18n from '@/mixins/i18n';

export default {


  Failure({ commit,rootGetters }, message ){
    commit('SET', {type: 'error',items: (message || i18n.methods.translate("common.server_error") ) })
    commit('SET', {type: 'message',items: null })
    commit('SET', {type: 'show_login_btn',items: !rootGetters["users/getItemCurrent"].email })
  },
  Success({ commit }, message ){
    commit('SET', {type: 'message',items: message })
    commit('SET', {type: 'error',items: null })
  },
  Loading({ commit }, val ){
    commit('SET', {type: 'loading', items: val })
  },
  NeedLogin({ commit }, val ){
    commit('SET', {type: 'need_login', items: val })
  },
  NeedMembership({ commit }, val ){
    commit('SET', {type: 'need_membership', items: val })
  },
  GlobalConfig({ commit } ){
    HTTP.get(`/config`)
    .then(response => {
      if(response.data.success){
        commit('SET', {type: 'global_config',items: response.data })
      }
    })
    .catch(err => console.log(err.response.status))
  },
  Contact({ commit,dispatch }, item ){
    return new Promise((resolve, reject) => {
      HTTP.post(`/contact/`, item).then(response => {
        commit('SET', {type: 'contact_saved',items: response.data.success })
        if(!response.data.success){
          dispatch('marketplace/Failure',response.data.message, {root: true})
        }
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },
  Discount({ commit,dispatch }, item ){
    return new Promise((resolve, reject) => {
      HTTP.post(`/subscribe_from_benefit/`, item).then(response => {
        commit('SET', {type: 'item_saved',items: response.data.success })
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },
  SetType({ commit },type){
    commit('SET_LOCALSTORE', { type: 'active_type', items: type })
  },
  SetActiveProduct({ commit },product){
    commit('SET', { type: 'active_product', items: product })
  },

  SetFilter({ commit,getters }, filters){
    commit('SET_LOCALSTORE', { type: 'filters', key: getters.getActiveType, items: filters })
  },

  AddBreadcrumps({ commit,getters }, breadcrump ){
    let breadcrumbs = (getters.breadcrumbs || []).map(i => { return {title: i.title, path: i.path } });
    breadcrumbs.push(breadcrump)
    commit('SET_LOCALSTORE', { type: 'breadcrumbs', items: breadcrumbs })
  },
  RemoveBreadcrumps({ commit,getters } ){
    let breadcrumbs = getters.breadcrumbs.shift()
    commit('SET_LOCALSTORE', { type: 'breadcrumbs', items: breadcrumbs })
  },
  CurrentRoute({ commit,getters }, route ){
    commit('SET', { type: 'current_route', items: route })
  },
  ClearBreadcrumps({ commit,getters }, route ){
    commit('SET_LOCALSTORE', { type: 'breadcrumbs', items: [] })
  },
  SetSorting({ commit,getters }, sorting){
    commit('SET_LOCALSTORE', { type: 'sorting', key: getters.getActiveType, items: sorting })
  },
  SetPage({ commit,getters },page){
    commit('SET_LOCALSTORE', { type: 'page', key: getters.getActiveType, items: page })
  },



  Show({ commit, getters }, id) {
    HTTP.get(`/${getters.getActiveType}/${id}`)
      .then(response => {
        if (response.data.success) {
          commit('SET_ITEM', {type: 'current', key: getters.getActiveType, items: response.data.item })
        }
      })
      .catch(err => console.log(err))
  },
  Company({ commit }, id) {
    HTTP.get(`/companies/${id}`)
      .then(response => {
        if (response.data.success) {
          commit('SET', {type: 'currentCompany', items: response.data.item })
          commit('SET_ITEM', {type: 'currentCompanyItems', key: 'offers', items: {total: response.data.offers.total, items: response.data.offers.items} })
          commit('SET_ITEM', {type: 'currentCompanyItems', key: 'requests', items: {total: response.data.requests.total, items: response.data.requests.items} })
        }
      })
      .catch(err => console.log(err))
  },

}

