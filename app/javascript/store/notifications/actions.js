import $http from 'axios';

export default {
  List({ commit, getters }){
    let params = {
      page: getters.getPage
    }
    return new Promise((resolve, reject) => {
      $http.get(`/notifications`,{params: params}).then(response => {
        if(response.data.success){
          commit('SET', {type: 'items', items: response.data.items })
          commit('SET', {type: 'total', items: response.data.total })
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
    return new Promise((resolve, reject) => {
      $http.get(`/notifications/${id}`).then(response => {
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


  Delete({ commit }, id){
    return new Promise((resolve, reject) => {
      $http.delete(`/notifications/${id}`).then(response => {
        if(response.data.success){
          commit('SET', {type: 'item_deleted', items: response.data.success })
        }
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },
  SetPage({ commit },item){
    commit('SET', { type: 'page', items: item })
  },
}
