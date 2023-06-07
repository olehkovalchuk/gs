import $http from 'axios';
export default {
  List({ commit, dispatch }){
    return new Promise((resolve, reject) => {
      $http.get(`/bids`).then(response => {
        if(response.data.success){
          commit('SET', {type: 'items', items: response.data.items })
          commit('SET', {type: 'total', items: response.data.total })
        }
        else{
          commit('SET', {type: 'items', items: [] })
          dispatch('marketplace/Failure',response.data.message, {root: true})
        }
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => dispatch('marketplace/Failure', null , {root: true}) )
    })
  },
  Save({ commit }, item ){
    return new Promise((resolve, reject) => {
      $http.post(`/bids/`, item).then(response => {
        if(response.data.success){
          commit('SET', {type: 'item_saved',items: true })
        }
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => dispatch('marketplace/Failure', null , {root: true}) )
    })
  },
  Delete({ commit }, id){
    return new Promise((resolve, reject) => {
      $http.delete(`/bids/${id}`).then(response => {
        if(response.data.success){
          commit('SET', {type: 'item_deleted',items: response.data.success })
        }
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => dispatch('marketplace/Failure', null , {root: true}))
    })
  },
}
