export default {
  message: null,
  breadcrumbs: [],
  loading: false,
  contact_saved: false,
  show_login_btn: false,
  need_login: false,
  need_membership: false,
  feedback_saved: false,
  global_config: {
    roles:['seller','buyer','trader'],
    default_market: 'meat',
    marketplaces: ['meat'],
    offers:{
      filters:{
        delivery_conditions: [],
        origins: [],
        payment_types: [],
        permissions: [],
        prices: [0,100500]
      },
      categories: [],
    },
    requests:{
      filters:{
        delivery_conditions: [],
        origins: [],
        payment_types: [],
        permissions: [],
        prices: [0,100500]
      },
      categories: [],
    },
    certificates: [],
    packages: [],
    categories: [],
    documents: []
  },
  filters: {
    offers: {},
    requests: {}
  },
  sorting: {
    offers: {
      direction: "DESC",
      field: "updated_at"
    },
    requests: {
      direction: "DESC",
      field: "updated_at"
    }
  },
  currentCompany: {},
  currentCompanyItems:{
    offers: [],
    requests: []
  },
  error: null
}

