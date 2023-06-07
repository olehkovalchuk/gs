import Vue from "vue";
import Router from "vue-router";
import Marketplace from "@/views/Marketplace";
import store from '@/store/index'
import i18n from '@/mixins/i18n';

Vue.use(Router);

let router = new Router({
  mode: 'history',
  base: window.gon.config.base_url,
  routes: [
    // Marketplace
    {
      path: "/",
      name: "marketplace",
      component: Marketplace,
      meta: {
        productType: 'offers',
        reload: true,
        breadcrump: i18n.methods.translate('common.home')
      }
    },
    {
      path: "/offers",
      name: "offers",
      component: Marketplace,
      meta: {
        reload: true,
        productType: 'offers',
        breadcrump: i18n.methods.translate('common.offers'),
        title: 'Buy meat wholesale  on Global Supplies',
        description: 'Buy meat, meat products on B2B Wholesale Marketplace Global Supplies The most convenient and dynamically developing b2b platform working worldwide | Join us to find wholesale suppliers or to trade your products on a business to business wholesale'
      }
    },

    {
      path: "/offers/category/:seo",
      name: "offers-category",
      component: Marketplace,
      props: true,
      meta: {
        reload: true,
        productType: 'offers',
        breadcrump: i18n.methods.translate('common.offers')
      }
    },

    {
      path: "/offers/:seo/:id",
      name: "offer-new-route",
      props: true,
      meta: {
        reload: true,
        productType: 'offers',
        breadcrump: i18n.methods.translate('common.offer')
      },
      component: () =>
        import("@/views/Product-details-offer.vue")
    },

    {
      path: "/offers/:id",
      name: "offer",
      props: true,
      meta: {
        reload: true,
        productType: 'offers',
        breadcrump: i18n.methods.translate('common.offer')
      },
      component: () =>
        import("@/views/Product-details-offer.vue")
    },
    {
      path: "/requests",
      name: "requests",
      component: Marketplace,
      meta: {
        reload: true,
        productType: 'requests',
        breadcrump: i18n.methods.translate('common.requests')
      }
    },

    {
      path: "/requests/category/:seo",
      name: "requests-category",
      component: Marketplace,
      props: true,
      meta: {
        reload: true,
        productType: 'requests',
        breadcrump: i18n.methods.translate('common.requests')
      }
    },

    {
      path: "/requests/:id",
      props: true,
      name: "request",
      meta: {
        reload: true,
        productType: 'requests',
        breadcrump: i18n.methods.translate('common.request')
      },
      component: () =>
        import("@/views/Product-details-request.vue")
    },

    {
      path: "/requests/:seo/:id",
      name: "request-new-route",
      props: true,
      meta: {
        reload: true,
        productType: 'requests',
        breadcrump: i18n.methods.translate('common.offer')
      },
      component: () =>
        import("@/views/Product-details-request.vue")
    },
    {
      path: "/company/:id",
      props: true,
      name: "company",
      meta: {
        reload: true,
        breadcrump: i18n.methods.translate('common.company')
      },
      component: () =>
        import("@/views/Company-card.vue")
    },
    {
      path: "/cabinet/conversations",
      name: "cabinet-chats",
      meta: {
        requiresAuth: true,
        breadcrump: i18n.methods.translate('common.chats')
      },
      component: () =>
        import("@/views/cabinet/Chat.vue")
    },
    {
      path: "/cabinet/notifications",
      name: "cabinet-notifications",
      meta: {
        requiresAuth: true,
        breadcrump: i18n.methods.translate('common.notifications')
      },
      component: () =>
        import("@/views/cabinet/Notifications-list.vue")
    },
    {
      path: "/cabinet/conversations/:id",
      name: "cabinet-chat",
      props: true,
      meta: {
        requiresAuth: true,
        breadcrump: i18n.methods.translate('common.chats')
      },
      component: () =>
        import("@/views/cabinet/Chat.vue")
    },

    {
      path: "/cabinet/company",
      name: "cabinet-company",
      meta: {
        requiresAuth: true,
        breadcrump: i18n.methods.translate('common.company_profile')
      },
      component: () =>
        import("@/views/cabinet/CompanyProfile.vue")
    },


    {
      path: "/cabinet/offers",
      name: "cabinet-offers",
      meta: {
        requiresAuth: true,
        breadcrump: i18n.methods.translate('common.my_offers'),
        productType: 'offers',
      },
      component: () =>
        import("@/views/cabinet/User-offers.vue")
    },


    {
      path: "/cabinet/offers/all",
      name: "cabinet-company-offers",
      meta: {
        requiresAuth: true,
        breadcrump: i18n.methods.translate('common.my_offers'),
        productType: 'offers',
      },
      component: () =>
        import("@/views/cabinet/User-offers.vue")
    },

    {
      path: "/cabinet/offer/:id",
      name: "cabinet-offer",
      props: true,
      meta: {
        requiresAuth: true,
        breadcrump: i18n.methods.translate('common.my_offers'),
        productType: 'offers',
      },
      component: () =>
        import("@/views/Add-new-offer.vue")
    },
    {
      path: "/cabinet/offers/add",
      name: "add-new-offer",
      meta: {
        productType: 'offers',
        requiresAuth: true,
        breadcrump: i18n.methods.translate('common.add_offer')
      },
      component: () =>
        import("@/views/Add-new-offer.vue")
    },

    {
      path: "/cabinet/requests",
      name: "cabinet-requests",
      meta: {
        requiresAuth: true,
        productType: 'requests',
        breadcrump: i18n.methods.translate('common.my_requests')
      },
      component: () =>
        import("@/views/cabinet/User-requests.vue")
    },

    {
      path: "/cabinet/requests/all",
      name: "cabinet-company-requests",
      meta: {
        requiresAuth: true,
        breadcrump: i18n.methods.translate('common.my_offers'),
        productType: 'requests',
      },
      component: () =>
        import("@/views/cabinet/User-requests.vue")
    },



    {
      path: "/cabinet/requests/add",
      name: "add-new-request",
      meta: {
        productType: 'requests',
        requiresAuth: true,
        breadcrump: i18n.methods.translate('common.add_request')
      },
      component: () =>
        import("@/views/Add-new-request.vue")
    },
    {
      path: "/cabinet/request/:id",
      name: "cabinet-request",
      props: true,
      meta: {
        requiresAuth: true,
        productType: 'requests',
        breadcrump: i18n.methods.translate('common.my_requests')
      },
      component: () =>
        import("@/views/Add-new-request.vue")
    },

    {
      path: "/cabinet/profile/edit",
      name: "edit-profile",
      meta: {
        requiresAuth: true,
        breadcrump: i18n.methods.translate('common.edit_info')
      },
      component: () =>
        import("@/views/cabinet/Edit-profile.vue")
    },
    {
      path: "/cabinet/company/edit",
      name: "edit-company",
      meta: {
        requiresAuth: true,
        breadcrump: i18n.methods.translate('common.edit_info')
      },
      component: () =>
        import("@/views/cabinet/Edit-company.vue")
    },
    {
      path: "/map",
      name: "map",
      meta: {
        reload: true,
        is_map: true,
        breadcrump: i18n.methods.translate('common.map')
      },
      component: () =>
        import("@/views/Map.vue")
    },
    {
      path: "/map/:id",
      name: "map_item",
      props: true,
      meta: {
        reload: true,
        is_map: true,
        breadcrump: i18n.methods.translate('common.map')
      },
      component: () =>
        import("@/views/Map.vue")
    },

    {
      path: "/login",
      name: "login",
      component: Marketplace,
      meta: {
        reload: true,
        showLogin: true,
        productType: 'offers',
        breadcrump: i18n.methods.translate('common.home')
      }
    },
    // {
    //   path: "/logout",
    //   name: "logout",
    //   beforeEnter(to, from, next) {
    //     window.localStorage.clear()
    //     window.location.href = "/logout"
    //   }
    // },
    {
      path: "/profile",
      name: "cabinet",
      meta: {
        requiresAuth: true,
        breadcrump: i18n.methods.translate('common.my_profile')
      },
      component: () =>
        import("@/views/cabinet/User-profile.vue")
    },

    {
      path: "/cabinet/members",
      name: "cabinet-members",
      meta: {
        requiresAuth: true,
        breadcrump: i18n.methods.translate('common.team_members')
      },
      component: () =>
        import("@/views/cabinet/Team-members.vue")
    },
    {
      path: "/cabinet/member/:id",
      name: "member",
      props: true,
      meta: {
        requiresAuth: true,
        breadcrump: i18n.methods.translate('common.edit_info')
      },
      component: () =>
        import("@/views/cabinet/Edit-profile.vue")
    },
    {
      path: "/cabinet/membesr/add",
      name: "add-member",
      meta: {
        requiresAuth: true,
        breadcrump: i18n.methods.translate('common.edit_info')
      },
      component: () =>
        import("@/views/cabinet/Edit-profile.vue")
    },


    {
      path: "/cabinet/transactions",
      name: "cabinet-transactions",
      meta: {
        requiresAuth: true,
        breadcrump: i18n.methods.translate('common.transactions')
      },
      component: () =>
        import("@/views/cabinet/Transactions-list.vue")
    },
    {
      path: "/cabinet/invoices",
      name: "cabinet-invoices",
      meta: {
        requiresAuth: true,
        breadcrump: i18n.methods.translate('common.invoices')
      },
      component: () =>
        import("@/views/cabinet/Invoices-list.vue")
    },
    {
      path: "/cabinet/bids",
      name: "cabinet-bids",
      meta: {
        requiresAuth: true,
        breadcrump: i18n.methods.translate('common.bids')
      },
      component: () =>
        import("@/views/cabinet/Bids-list.vue")
    },
    {
      path: "/cabinet/transactions/all",
      name: "cabinet-company-transactions",
      meta: {
        requiresAuth: true,
        breadcrump: i18n.methods.translate('common.transactions')
      },
      component: () =>
        import("@/views/cabinet/Transactions-list.vue")
    },
    {
      path: "/cabinet/invoices/all",
      name: "cabinet-company-invoices",
      meta: {
        requiresAuth: true,
        breadcrump: i18n.methods.translate('common.invoices')
      },
      component: () =>
        import("@/views/cabinet/Invoices-list.vue")
    },
    {
      path: "/cabinet/bids/all",
      name: "cabinet-company-bids",
      meta: {
        requiresAuth: true,
        breadcrump: i18n.methods.translate('common.bids')
      },
      component: () =>
        import("@/views/cabinet/Bids-list.vue")
    },
    {
      path: "/faq",
      name: "faq",
      meta: {
        breadcrump: i18n.methods.translate('common.faq')
      },
      component: () =>
        import("@/views/Faq.vue")
    },

    {
      path: "/cabinet-menu",
      name: "cabinet-menu",
      meta:{
        requiresAuth: true
      },
      component: () =>
        import("@/views/cabinet/Cabinet-menu.vue")
    },

    {
      path: "/cabinet/processes",
      name: "cabinet-processes",
      meta: {
        requiresAuth: true,
        breadcrump: i18n.methods.translate('common.process')
      },
      component: () =>
        import("@/views/business-process/User-processes.vue")
    },
    {
      path: "/cabinet/process/all",
      name: "cabinet-company-process",
      meta: {
        requiresAuth: true,
        breadcrump: i18n.methods.translate('common.process')
      },
      component: () =>
        import("@/views/business-process/User-processes.vue")
    },
    {
      path: "/cabinet/processes/:id",
      props: true,
      name: "process",
      meta: {
        requiresAuth: true,
        breadcrump: i18n.methods.translate('common.process')
      },
      component: () =>
        import("@/views/business-process/Bp-item.vue")
    },

    {
      path: "/cabinet/processes/:offer_id/new",
      props: true,
      name: "new-process",
      meta: {
        requiresAuth: true,
        breadcrump: i18n.methods.translate('common.process')
      },
      component: () =>
        import("@/views/business-process/Bp-item.vue")
    },

  ]
});

router.beforeEach((to, from, next) => {
  if (to.hash.substr(0,2) === "#/") {
    const path = to.hash.substr(2)
    if(path.length > 3) {
      next(path);
      return
    }
  }
  if(to.matched.some(record => record.meta.requiresAuth)) {
    if (store.getters["users/getItemCurrent"].id) {
      next()
      return
    }
    window.localStorage.clear()
    window.location.href = "/marketplace/login"
  }
  else {
    window.scrollTo(0, 0)
    next()
  }
})

export default router;
