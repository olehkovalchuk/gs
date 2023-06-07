export default {
  getItemCurrent(state){
    return state.item_current;
  },
  getItemEdited(state){
    return state.item_edited;
  },
  getItems(state){
    return state.items;
  },
  getProducts(state){
    return state.products;
  },
  getItem(state){
    return state.item;
  },
  getRating(state){
    return state.item_rating;
  },
  getActiveDocType(state){
    return state.active_doc_type;
  },
  getActiveCategory(state){
    return state.active_category;
  },
  getSorting(state){
    return state.sorting;
  },
  getOffers(state){
    return state.offers;
  },
  getRequests(state){
    return state.requests;
  },
  getActiveType(state){
    return state.active_type;
  },
  getFilters(state){
    return state.filters;
  },
}
