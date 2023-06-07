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
  getMessages(state){
    return state.messages;
  },
  getPage(state){
    return state.page || 1;
  },
}
