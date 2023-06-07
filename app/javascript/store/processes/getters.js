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
  getTotal(state){
    return state.total;
  },
  getFullItem(state){
    return state.full_item;
  },
  getFilter(state){
    return state.filter;
  },
  getPage(state){
    return state.page;
  },
  isUpload(state){
    return state.is_upload;
  },
  getCurrentStep(state){
    return state.current_step;
  },
}