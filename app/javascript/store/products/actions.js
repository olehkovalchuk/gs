import $http from 'axios';

export default {

  SetActiveItemsType({ commit },type){
    if(["offers","requests"].includes(type)){
      commit('SET', { type: 'active_item_type', items: type  })
    }

  },
  SetFilterId({ commit },id){
    commit('SET', { type: 'filter_id', items: id })
  },
  SetActiveItem({ commit },item){
    commit('SET', { type: 'active_item', items: item })
  },
  SetVisability({ commit },item){
    commit('SET', { type: 'visablity', items: item })
  },

  SetPage({ commit },item){
    commit('SET', { type: 'page', items: item })
  },
  SetFilters({ commit },item){
    commit('SET', { type: 'filters', items: item })
  },
  SetSorting({ commit },item){
    commit('SET', { type: 'sorting', items: item })
  },
  Select({ commit, getters },{id, val}){
    let currentSelected = getters.getSelected
    currentSelected[id] = val
    commit('SET', { type: 'selected_items', items: Object.assign({}, getters.getSelected, currentSelected ) })
  },
  ClearSelected({ commit }){
    commit('SET', { type: 'selected_items', items: {} })
  },
  List({ commit, getters }, {by_company,cabinet} ){
    cabinet = cabinet || false
    return new Promise((resolve, reject) => {

      let params = {
        filters: getters.getFilters,
        page: getters.getPage,
        sorting: getters.getSorting,
      }
      if(cabinet){
        params['cabinet'] = true
      }
      if(by_company){
        params['by_company'] = true
      }

      $http.get(`/${getters.getActiveItemType}`,{params: params}).then(response => {
        if(response.data.success){
          commit('SET', {type: 'items', items: response.data.items } )
          commit('SET', {type: 'total', items: response.data.total })
          commit('SET_LOCALSTORE', { type: 'last_items', items: response.data.items })
        }
        else{
          commit('SET', {type: 'items', items: [] } )
        }
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },

  My({ commit, getters }){
    return new Promise((resolve, reject) => {
      $http.get(`/offers/my`).then(response => {
        if(response.data.success){
          commit('SET', {type: 'my_items', items: response.data.items } )
        }
        else{
          commit('SET', {type: 'my_items', items: [] } )
        }
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },

  Promote({ commit, getters }){
    return new Promise((resolve, reject) => {
      $http.get(`/offers/for_promote`).then(response => {
        if(response.data.success){
          commit('SET', {type: 'promoted_items', items: response.data.items } )
        }
        else{
          commit('SET', {type: 'promoted_items', items: [] } )
        }
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },

  Show({ commit, getters }, id){
    return new Promise((resolve, reject) => {
      $http.get(`/${getters.getActiveItemType}/${id}`).then(response => {
        if(response.data.success){
          commit('SET', {type: 'item_current', items: response.data.item })
        }
        else{
          commit('SET', {type: 'item_current', items: {bids:[],recomendations:[],certificates:[],images:[],company:{}} })
        }
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },

  ToTop({ commit, getters }, id){
    return new Promise((resolve, reject) => {
      $http.post(`/${getters.getActiveItemType}/${id}/to_top`).then(response => {
        commit('SET', {type: 'item_saved', items: response.data.success })
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },

  Full({ commit, getters }, id){
    return new Promise((resolve, reject) => {
      $http.get(`/offers/${id}/full`).then(response => {
        if(response.data.success){
          commit('SET', {type: 'full_item', items: response.data.item })
        }
        else{
          commit('SET', {type: 'full_item', items: {} })
        }
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },
  Reset({ commit }){
    // commit('SET', {type: 'item_edited',items: {category: {},delivery_conditions:[]} })
  },
  Edit({ commit, getters }, id){
    return new Promise((resolve, reject) => {
      $http.get(`/${getters.getActiveItemType}/${id}/edit`).then(response => {
        if(response.data.success){
          commit('SET', {type: 'item_edited',items: response.data.item })
        }
        else{
          commit('SET', {type: 'item_edited',items: {} })
        }
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },
  Save({ commit, getters }, item ){
    return new Promise((resolve, reject) => {
      let form = new FormData();
      if (item.files) {
        for (var i = item.files.length - 1; i >= 0; i--) {
          form.append(`images['${i}']`, item.files[i] );
        }
      }
      for (const [key, value] of Object.entries(item)) { form.append(key, value ) }
      let method = item.id ? "put" : "post"
      $http[method](`/${getters.getActiveItemType}/${item.id || ''}`, form, { headers: { 'Content-Type': 'multipart/form-data' } }).then(response => {
        commit('SET', {type: 'item_saved',items: response.data.success })
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },
  CreateQuick({ commit, getters }, item ){
    return new Promise((resolve, reject) => {
      let form = new FormData();
      if (item.files) {
        for (var i = item.files.length - 1; i >= 0; i--) {
          form.append(`images[]`, item.files[i] );
        }
      }
      for (const [key, value] of Object.entries(item)) { form.append(key, value ) }
      $http.post('/quick_offers/', form, { headers: { 'Content-Type': 'multipart/form-data' } }).then(response => {
        commit('SET', {type: 'item_saved',items: response.data.success })
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },
  Delete({ commit, getters }, id){
    return new Promise((resolve, reject) => {
      $http.delete(`/${getters.getActiveItemType}/${id}`).then(response => {
        commit('SET', {type: 'item_deleted',items: response.data.success })
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },

  DeleteImage({ commit, getters }, {id,image_id}){
    return new Promise((resolve, reject) => {
      $http.post(`/${getters.getActiveItemType}/${id}/remove_attach/images/${image_id}`).then(response => {
        commit('SET', {type: 'item_deleted',items: response.data.success })
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },
  Inquiry({ commit, getters }, { id, params }) {
    return new Promise((resolve, reject) => {
      $http.post(`/${getters.getActiveItemType}/${id}/inquiry`, params).then(response => {
        commit('SET', {type: 'item_saved',items: true })
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },
  Bid({ commit, getters }, { id, params }) {
    return new Promise((resolve, reject) => {
      $http.post(`/${getters.getActiveItemType}/${id}/bid`, params).then(response => {
        commit('SET', {type: 'item_saved',items: true })
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },
  Send({ commit, getters }, item ){
    return new Promise((resolve, reject) => {
      $http.post(`/${getters.getActiveItemType}/${item.id}/send_offers`, item ).then(response => {
        commit('SET', {type: 'item_saved',items: response.data.success })
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },
  SendToPromote({ commit, getters }, item ){
    return new Promise((resolve, reject) => {
      $http.post(`/${getters.getActiveItemType}/send_to_promote`, item ).then(response => {
        commit('SET', {type: 'item_saved',items: response.data.success })
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },
  SendAlert({ commit, getters }, item ){
    return new Promise((resolve, reject) => {
      $http.post(`/alerts/`, item ).then(response => {
        commit('SET', {type: 'item_saved',items: response.data.success })
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },
}
