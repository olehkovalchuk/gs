import $http from 'axios';

export default {
  SetPage({ commit },item){
    commit('SET', { type: 'page', items: item })
  },
  Clear({ commit },item){
    commit('SET', { type: 'items', items: [] })
  },
  List({ commit, getters }){
    let params = {
      // filters: getters.getFilters,
      page: getters.getPage,
      // sorting: getters.getSorting,
    }
    return new Promise((resolve, reject) => {
      $http.get(`/conversations`,{params: params}).then(response => {
        if(response.data.success){
          commit('SET', {type: 'items', items: [...getters.getItems,...response.data.items ]})
        }
        else{
          commit('SET', {type: 'items', items: [] })
        }
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },
  Show({ commit }, id){
    $http.get(`/conversations/${id}`).then(response => {
      if(response.data.success){
        commit('SET', {type: 'item', items: response.data.item })
        commit('SET', {type: 'messages', items: response.data.items })
      }
    }, error => {
        dispatch('marketplace/Failure',null, {root: true})
      }
    ).catch(err => console.log(err.response))
  },
  Create({ commit }, recepient_id ){
    return new Promise((resolve, reject) => {
      $http.post(`/conversations`, {recepient_id: recepient_id} ).then(response => {
        commit('SET', {type: 'item_saved',items: true })
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },
  AddMessage({ commit }, item ){
    return new Promise((resolve, reject) => {
      let form = new FormData();
      if (item.file) { form.append('file', item.file ) }
      for (const [key, value] of Object.entries(item)) { form.append(key, value ) }

      $http.post(`/conversations`, form, { headers: { 'Content-Type': 'multipart/form-data' } }).then(response => {
        commit('SET', {type: 'item_updated',items: true })
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },
  Delete({ commit }, id){
    return new Promise((resolve, reject) => {
      $http.delete(`/conversations/${id}`).then(response => {
        commit('SET', {type: 'item_deleted', items: response.data.success })
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },
  InquiryReplay({ commit, getters }, { id, params }) {
    return new Promise((resolve, reject) => {
      $http.post(`/conversations/${id}/inquiry`, params).then(response => {
        commit('SET', {type: 'item_saved',items: true })
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },
}
