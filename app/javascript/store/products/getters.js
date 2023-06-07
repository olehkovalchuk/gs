export default {
  getActiveItem(state){
    return state.active_item;
  },
  getActiveItemType(state){
    return state.active_item_type;
  },
  getItemEdited(state){
    return state.item_edited;
  },
  getItemCurrent(state){
    return state.item_current;
  },
  getItems(state){
    return state.items.length ? state.items : state.last_items;
  },
  getMyItems(state){
    return state.my_items;
  },
  getPromotedItems(state){
    return state.promoted_items;
  },
  getFilters(state){
    return Object.assign(state.filters, {active: state.visablity, id: state.filter_id});
  },
  getSorting(state){
    return state.sorting;
  },
  getPage(state){
    return state.page || 1;
  },
  getTotal(state){
    return state.total;
  },
  getSelected(state){
    return state.selected_items;
  },
  getFullItem(state){
    return state.full_item;
  },
  getVisability(state){
    return state.visablity;
  },
}
