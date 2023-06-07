import $http from 'axios';

export default {
  List({ commit }){
    return new Promise((resolve, reject) => {
      $http.get(`/subscriptions`).then(response => {
        if(response.data.success){
          commit('SET', {type: 'items', items: response.data.items })
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
      $http.get(`/subscriptions/${id}`).then(response => {
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
    return new Promise((resolve, reject) => {
      $http.post(`/subscriptions/`, item ).then(response => {
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
      $http.delete(`/subscriptions/${id}`).then(response => {
        commit('SET', {type: 'item_deleted',items: response.data.success })
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },

}
