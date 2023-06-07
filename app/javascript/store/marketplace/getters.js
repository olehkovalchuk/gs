export default {


  getGlobalConnfig(state){
    return state.global_config;
  },
  getConfig(state) {
    return state.global_config[state.active_type];
  },
  getError(state){
    return state.error;
  },
  getMessage(state){
    return state.message;
  },
  getLoading(state){
    return state.loading;
  },
  getShowLoginBtn(state){
    return state.show_login_btn;
  },
  needLogin(state){
    return state.need_login;
  },
  needMembership(state){
    return state.need_membership;
  },



  error(state){
    return state.error;
  },
  activeProduct(state){
    return state.active_product;
  },
  currentRoute(state){
    return state.current_route;
  },
  breadcrumbs(state){
    return state.breadcrumbs;
  },
  getActiveType(state) {
    return state.active_type;
  },

  getFilters(state) {
    return state.filters[state.active_type];
  },
  getSorting(state) {
    return state.sorting[state.active_type];
  },
  getPage(state) {
    return state.page[state.active_type];
  },
  getItems(state) {
    return state.items[state.active_type].items;
  },
  getTotal(state) {
    return state.items[state.active_type].total;
  },
  getActiveProduct(state) {
    return state.current[state.active_type];
  },
  getActiveCompany(state) {
    return state.currentCompany;
  },
  getActiveCompanyOffers(state) {
    return state.currentCompanyItems.offers;
  },
  getActiveCompanyRequests(state) {
    return state.currentCompanyItems.requests;
  }
}
