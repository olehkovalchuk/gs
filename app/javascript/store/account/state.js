export default {
  response: null,
  action: null,
  edited_company: {},
  login: {
    refetch_user: null,
    success: null,
    user: null,
    errors: {
      email: null,
      pass: null
    }
  },
  register:{
    errors: {}
  },
  remind: {
    errors: {},
    success: null
  },
  user: {
    new_messages_count: 0,
    new_notifications_count: 0,
    user_name: null,
    avatar: undefined
  },
  auth: 'login', // register, restore
  subscribe: null,

  conversations: [],
  messages: [],



  active_type: "offers",
  filters: {
    offers: {},
    requests: {}
  },
  page: {
    offers: 1,
    requests: 1
  },
  items:{
    offers: [],
    requests: []
  },
  company: {},
  members: [],
  chart_in: [],
  chart_out: [],
  company_chart_in: [],
  company_chart_out: [],

  current_offer: null,
  current_request: null,
}
