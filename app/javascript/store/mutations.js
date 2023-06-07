export default {
  SET(state, { type, items }) {
    state[type] = items;
  },
  SET_ITEM(state, { type, key, items }) {
    state[type][key] = items;
  },
  ADD(state, { type, items }) {
    state[type].push(items);
  },
  REMOVE(state, { type, items }) {
    state[type] = state[type].filter(key => key != items)
  },
  DELETE(state, { type, key }) {
    delete state[type][key]
  },
  SET_SESSIONSTORE(state, { type, items }) { // for session Store
    state[type] = items;
  },
  SET_LOCALSTORE(state, { type, items, key }) { // for local Store
    if (key){
      state[type][key] = items;
    } else {
      state[type] = items;
    }
  }
}