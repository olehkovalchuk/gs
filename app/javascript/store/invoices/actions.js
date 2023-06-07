import $http from 'axios';

export default {
  List({ commit, dispatch }){
    return new Promise((resolve, reject) => {
      $http.get(`/invoices`).then(response => {
        if(response.data.success){
          commit('SET', {type: 'items', items: response.data.items })
        }
        else{
          dispatch('marketplace/Failure',response.data.message, {root: true})
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
    return new Promise((resolve, reject) => {
      $http.get(`/invoices/${id}`).then(response => {
        if(response.data.success){
          commit('SET', {type: 'item', items: response.data.item })
        }
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },
  Save({ commit }, item ){

    let formData = new FormData();
    formData.append('file', item.file );
    formData.append('comment', item.comment );

    return new Promise((resolve, reject) => {
      $http.post(`/invoices/`, formData, { headers: { 'Content-Type': 'multipart/form-data' } }).then(response => {
        if(response.data.success){
          commit('SET', {type: 'item_saved',items: true })
        }
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },

  Delete({ commit, getters }, id){
    return new Promise((resolve, reject) => {
      $http.delete(`/invoices/${id}`).then(response => {
        commit('SET', {type: 'item_deleted',items: response.data.success })
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },

}
