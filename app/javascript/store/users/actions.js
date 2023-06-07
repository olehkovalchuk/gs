import $http from 'axios';

export default {
  SetEdit({ commit },item){
    commit('SET', { type: 'item_edited', items: item })
  },
  CheckMessages({ commit }){
    return new Promise((resolve, reject) => {
      $http.get(`/new_messages_count`).then(response => {
        if(response.data.success){
          commit('SET', {type: 'new_messages_count',items: response.data.count })
          commit('SET', {type: 'new_notifications_count', items: response.data.count_notifications})
        }
        else{
          commit('SET', { type: 'item_current', items: {} })
          commit('SET_LOCALSTORE', { type: 'user', items: {} })
        }
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },

  Login({ commit, dispatch }, params) {
    return new Promise((resolve, reject) => {
      $http.post(`/sign_in`, params)
        .then(response => {
          commit('SET', { type: 'item_current', items: response.data.user || {} })
          if (response.data.user) {
            commit('SET_LOCALSTORE', { type: 'user', items: response.data.user })
            resolve(response.data);
          }
          else{
            dispatch('marketplace/Failure',response.data.message, {root: true})
          }
        })
        .catch(err => console.log(err))
    });
  },
  Register({ commit, dispatch }, params) {
    return new Promise((resolve, reject) => {
      $http.post(`/sign_up`, params)
        .then(response => {
          commit('SET', { type: 'item_current', items: response.data.user || {} })
          if (response.data.success) {
            resolve( response.data )
          }
          else{
            dispatch('marketplace/Failure',response.data.message, {root: true})
          }
        })
        .catch(err => console.log(err))
    });
  },
  Remind({ commit }, params) {
    return new Promise((resolve, reject) => {
      $http.post(`/remind/`, params).then(response => {
        commit('SET', { type: 'remind', items: response.data })
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },

  ChangePassword({ commit }, params) {
    return new Promise((resolve, reject) => {
      $http.post(`/restore/${window.token}`, params).then(response => {
        commit('SET', { type: 'change_password', items: response.data.success })
        commit('SET', { type: 'item_current', items: response.data.user || {} })
        if (response.data.success) {
          commit('SET_LOCALSTORE', { type: 'user', items: response.data.user })
          resolve( response.data )
        }
        else{
          dispatch('marketplace/Failure',response.data.message, {root: true})
        }

      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },

  List({ commit, dispatch }, with_fake){
    with_fake = with_fake || false
    return new Promise((resolve, reject) => {
      $http.get(`/members`, {params:{with_fake: with_fake}}).then(response => {
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
  Show({ commit,getters }, id){
    return new Promise((resolve, reject) => {
      $http.get(`/members/${id}`).then(response => {
        commit('SET', { type: 'item_current', items: getters.getItemCurrent })
        if(response.data.success){
          commit('SET', { type: 'item_current', items: response.data.item })
          commit('SET', { type: 'chart_in', items: response.data.item.chart_in })
          commit('SET', { type: 'chart_out', items: response.data.item.chart_out })
        }
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },
  Edit({ commit }, id){
    return new Promise((resolve, reject) => {
      $http.get(`/members/${id}/edit`).then(response => {
        commit('SET', {type: 'item_edited',items: response.data.item || {} })
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },
  Save({ commit }, item ){
    return new Promise((resolve, reject) => {
      let form = new FormData();
      if (item.file) { form.append('avatar', item.file ) }
      for (const [key, value] of Object.entries(item)) { form.append(key, value ) }
      let method = item.id ? "put" : "post"
      $http[method](`/members/${item.id || ''}`, form, { headers: { 'Content-Type': 'multipart/form-data' } }).then(response => {
        commit('SET', {type: 'item_saved',items: response.data.success })
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },
  Delete({ commit }, id){
    return new Promise((resolve, reject) => {
      $http.delete(`/members/${id}`).then(response => {
        commit('SET', {type: 'item_deleted',items: response.data.success })
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },
}
