import $http from 'axios';

export default {

  SetFilters({ commit },item){
    commit('SET', { type: 'filter', items: item })
  },
  SetPage({ commit },item){
    commit('SET', { type: 'page', items: item })
  },
  SetUpload({ commit },item){
    commit('SET', { type: 'is_upload', items: item })
  },
  New({ commit, getters }, id){
    return new Promise((resolve, reject) => {
      $http.get(`/proceses/${id}/start`).then(response => {
        commit('SET', {type: 'full_item', items: response.data.success ? response.data.item : {} })
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },  
  List({ commit, getters }){

    let params = {
      filter: getters.getFilter,
      page: getters.getPage,
    }

    return new Promise((resolve, reject) => {
      $http.get(`/proceses`, {params: params}).then(response => {
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
      $http.get(`/proceses/${id}`).then(response => {
        commit('SET', {type: 'item', items: response.data.success ? response.data.item : {} })
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },
  Sign({ commit }, id){
    return new Promise((resolve, reject) => {
      $http.post(`/proceses/${id}/sign`).then(response => {
        commit('SET', {type: 'item_saved', items: response.data.success })
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },
  ShowStep({ commit }, {id,step}){
    return new Promise((resolve, reject) => {
      $http.get(`/proceses/${id}/show_step/${step}`).then(response => {
        commit('SET', {type: 'current_step', items: response.data.success ? response.data.item : {} })
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
      if (item.files) {
        for (let id in item.files) {
          form.append(`files[${id}]`, item.files[id] );
        }
      }      
      for (const [key, value] of Object.entries(item)) { 
        if(typeof value === 'object'){
          for (let k in value) {
            if (value.hasOwnProperty(k)) {
              let keyName = [key, '[', k, ']'].join('');
              form.append(keyName, value[k]);
            }
          }
        }
        else{
          form.append(key, value ) 
        }
        
      }
      let method = item.id ? "put" : "post"
      $http[method](`/proceses/${item.id || ''}`, form, { headers: { 'Content-Type': 'multipart/form-data' } }).then(response => {
        commit('SET', {type: 'item_saved',items: response.data.success })
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },

  CompleteStep({ commit }, {id,step,item} ){
    return new Promise((resolve, reject) => {
      let form = new FormData();
      if (item.fields) {
        for (let id in item.fields) {
          form.append(`fields[${id}]`, item.fields[id] );
        }
      }      
      $http.post(`/proceses/${id}/complete_step/${step}`, form, { headers: { 'Content-Type': 'multipart/form-data' } }).then(response => {
        commit('SET', {type: 'item_saved',items: response.data.success })
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },

  Upload({ commit }, item ){
    return new Promise((resolve, reject) => {
      let form = new FormData();
      for (let id in item.files) {
        form.append(`files[${id}]`, item.files[id] );
      }    
      $http.post(`/proceses/${item.id}/upload`, form, { headers: { 'Content-Type': 'multipart/form-data' } }).then(response => {
        commit('SET', {type: 'item_saved',items: response.data.success })
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },

  AddFile({ commit }, item ){
    return new Promise((resolve, reject) => {
      let form = new FormData();
      for (let id in item.files) {
        form.append(`files[${id}]`, item.files[id] );
      }    
      $http.post(`/proceses/${item.id}/add_file`, form, { headers: { 'Content-Type': 'multipart/form-data' } }).then(response => {
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
      $http.delete(`/proceses/${id}`).then(response => {
        commit('SET', {type: 'item_deleted', items: response.data.success })
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },
}
