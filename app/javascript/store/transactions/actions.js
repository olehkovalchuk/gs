import $http from 'axios';

export default {
  List({ commit,dispatch }){
    return new Promise((resolve, reject) => {
      $http.get(`/transactions`).then(response => {
        if(response.data.success){
          commit('SET', {type: 'items', items: response.data.items })
        }
        else{
          commit('SET', {type: 'items', items: [] })
          dispatch('marketplace/Failure',response.data.message, {root: true})
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
      $http.get(`/transactions/${id}`).then(response => {
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
  Create({ commit }, id){
    return new Promise((resolve, reject) => {
      $http.post(`/transactions/?id=${id}`).then(response => {
        if(response.data.success){
          commit('SET', {type: 'item_saved', items: true })
        }
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  }
}
