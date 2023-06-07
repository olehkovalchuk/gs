import HTTP from 'axios';

import router from '@/apps/marketplace/router';

export default {
  Add({ commit }, params) {
    commit('SET_ITEM', { type: params.type, key: params.key, items: params.items })
  },
  AddItem({ commit }, params) {
    commit('SET', { type: params.type, items: params.items })
    if(params.action){
      commit('SET', { type: 'action', items: params.action })
    }
  },
  EventLoger(_, params) {
    return HTTP.post('/log', params);
  },
  LoadChart({ commit },payload){
    HTTP.get(`/user_chart`,{params: payload})
    .then(response => {
      if(response.data.success){
        commit('SET', {type: `chart_${payload.chart}`, items: response.data.item[`chart_${payload.chart}`] })
      }
    })
    .catch(err => console.log(err.response.status))
  }
}
