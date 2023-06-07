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
  getUserChartIn(state) {
    return state.chart_in;
  },
  getUserChartOut(state) {
    return state.chart_out;
  },
  getMessagesCount(state) {
    return state.new_messages_count;
  },
  getNotificationsCount(state) {
    return state.new_notifications_count;
  },
}
