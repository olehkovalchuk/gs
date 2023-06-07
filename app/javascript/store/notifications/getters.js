export default {
  getEditedItem(state){
    return state.item_edited;
  },
  getItems(state){
    return state.items;
  },
  getItem(state){
    return state.item;
  },
  getPage(state){
    return state.page || 1;
  },
  getTotal(state){
    return state.total;
  }
}
