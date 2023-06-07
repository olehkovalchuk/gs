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
        breadcrump: i18n.methods.translate('common.offers')
      },
      beforeEnter(to, from, next) {
        window.location.href = "/marketplace/offers"
      }
    },
    {
      path: "/company/:id",
      props: true,
      name: "company",
      meta: {
        reload: true,
        breadcrump: i18n.methods.translate('common.company')
      },
      beforeEnter(to, from, next) {
        window.location.href = `/marketplace#${to.path}`
      }
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
      beforeEnter(to, from, next) {
        window.location.href = `/marketplace#${to.path}`
      }
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
    {
      path: "/logout",
      name: "logout",
      beforeEnter(to, from, next) {
        window.localStorage.clear()
        window.location.href = "/logout"
      }
    },
    {
      path: "/profile",
      name: "cabinet",
      meta: {
        requiresAuth: true,
        breadcrump: i18n.methods.translate('common.my_profile')
      },
      component: () =>
        import("@/views/cabinet/User-profile.vue")
    }
  ]
});


router.beforeEach((to, from, next) => {
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
