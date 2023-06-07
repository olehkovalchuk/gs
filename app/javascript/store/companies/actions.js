import $http from 'axios';

export default {

  SetDocType({ commit },type){
    commit('SET', { type: 'active_doc_type', items: type })
  },
  ClearProducts({ commit }){
    commit('SET', { type: 'products', items: [] })
  },
  ActiveCategory({ commit },item){
    commit('SET', { type: 'active_category', items: item })
  },
  ClearActiveCategory({ commit },item){
    commit('SET', { type: 'active_category', items: {} })
  },
  SetSorting({ commit },item){
    commit('SET', { type: 'sorting', items: item })
  },
  SetFilters({ commit },item){
    commit('SET', { type: 'filters', items: item })
  },
  setActiveType({ commit },item){
    commit('SET', { type: 'active_type', items: item })
  },
  Products({ commit, dispatch },id){
    return new Promise((resolve, reject) => {
      $http.get(`/companies/${id}/products`).then(response => {
        if(response.data.success){
          commit('SET', {type: 'products', items: response.data.items })
        }
        else{
          commit('SET', {type: 'products', items: [] })
          dispatch('marketplace/Failure',response.data.message, {root: true})
        }
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },

  Offers({ commit, dispatch },{id,page}){
    return new Promise((resolve, reject) => {
      $http.get(`/companies/${id}/offers`,{params:{page:page}}).then(response => {
        if(response.data.success){
          commit('SET', {type: 'offers', items: {items: response.data.items, total: response.data.total } })
        }
        else{
          commit('SET', {type: 'offers', items: {items: [], total: 0 } })
          dispatch('marketplace/Failure',response.data.message, {root: true})
        }
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },

  Requests({ commit,dispatch },{id,page}){
    return new Promise((resolve, reject) => {
      $http.get(`/companies/${id}/requests`,{params:{page:page}}).then(response => {
        if(response.data.success){
          commit('SET', {type: 'requests', items: {items: response.data.items, total: response.data.total } })
        }
        else{
          commit('SET', {type: 'requests', items: {items: [], total: 0 } })
          dispatch('marketplace/Failure',response.data.message, {root: true})
        }
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },


  List({ commit,getters,dispatch }){

    let params = {
      filters: getters.getFilters,
      // page: getters.getPage,
      sorting: getters.getSorting,
    }

    return new Promise((resolve, reject) => {
      $http.get(`/companies`,{params:params}).then(response => {
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
  Show({ commit,dispatch,getters }, id){
    return new Promise((resolve, reject) => {
      $http.get(`/companies/${id}`).then(response => {

        if(response.data.success){
          commit('SET', {type: 'item_current', items: response.data.item })
        }
        else{
          commit('SET', {type: 'item_current', items: {} })
          dispatch('marketplace/Failure',response.data.message, {root: true})
        }
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })

  },

  Contacts({ commit,dispatch,getters }, id){
    return new Promise((resolve, reject) => {
      $http.get(`/companies/${id}/contacts`).then(response => {

        commit('SET', {type: 'item_current', items: response.data.item || { ...getters['getItemCurrent'] }  })

        // if(!getters['getItemCurrent'].id){
        //   commit('SET', {type: 'item_current', items: old })
        // }

        if(!response.data.success){
          if(401 != response.data.status){
            dispatch('marketplace/Failure',response.data.message, {root: true})
          }
        }



        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })

  },

  Edit({ commit,dispatch }, id){
    $http(`/companies/${id}/edit`).then(response => {
      if(response.data.success){
        commit('SET', {type: 'item_edited',items: response.data.item })
      }
      else{
        commit('SET', {type: 'item_edited', items: {} })
        dispatch('marketplace/Failure',response.data.message, {root: true})
      }
    }, error => {
        console.log(error);
      }
    ).catch(err => console.log(err.response))

  },
  Info({ commit,dispatch }, id ){
    return new Promise((resolve, reject) => {
      $http.get(`/companies/${id}/info`).then(response => {
        if(response.data.success){
          commit('SET', {type: 'item_current', items: response.data.item })
        }
        else{
          commit('SET', {type: 'item_current', items: {} })
          dispatch('marketplace/Failure',response.data.message, {root: true})
        }
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },
  Rating({ commit, dispatch }, id ){
    return new Promise((resolve, reject) => {
      $http.get(`/companies/${id}/rating`).then(response => {
        if(response.data.success){
          commit('SET', {type: 'item_rating', items: response.data.item })
        }
        else{
          commit('SET', {type: 'item_rating', items: {} })
          dispatch('marketplace/Failure',response.data.message, {root: true})
        }
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },
  Update({ commit,dispatch }, item ){
    return new Promise((resolve, reject) => {
      let form = new FormData();
      if (item.file) { form.append('logo', item.file ) }
      for (const [key, value] of Object.entries(item)) { form.append(key, value ) }

      $http.put(`/companies/${item.id}`, form, { headers: { 'Content-Type': 'multipart/form-data' } }).then(response => {
        commit('SET', {type: 'item_saved',items: true })
        if(response.data.success){

        }
        else{
          dispatch('marketplace/Failure',response.data.message, {root: true})
        }
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })
  },
  AddDocument({ commit, dispatch }, item ){
    return new Promise((resolve, reject) => {
      let form = new FormData();
      form.append(item.type, item.file )

      $http.post(`/companies/${item.id}/document`, form, { headers: { 'Content-Type': 'multipart/form-data' } }).then(response => {
        commit('SET', {type: 'item_saved',items: true })
        if(response.data.success){
          
        }
        else{
          dispatch('marketplace/Failure',response.data.message, {root: true})
        }
        resolve(response.data);
      }, error => {
          reject(error);
        }
      ).catch(err => console.log(err.response))
    })

  },


}
