import $http from 'axios';

export default {
  List({ commit,dispatch }){
    return new Promise((resolve, reject) => {
      $http.get(`/faqs`).then(response => {
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
  Show({ commit, dispatch }, id){
    return new Promise((resolve, reject) => {
      $http.get(`/faqs/${id}`).then(response => {
        if(response.data.success){
          commit('SET', {type: 'item', items: response.data.item })
        }
        else {
          commit('SET', {type: 'item', items: '' })
          dispatch('marketplace/Failure',response.data.message, {root: true})
        }
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  }
}
