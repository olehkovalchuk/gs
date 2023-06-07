import Vue from "vue";
import Router from "vue-router";
import store from '@/store/index'

Vue.use(Router);

let router = new Router({
  routes: [
    {
      path: "/login",
      beforeEnter(to, from, next) {
        window.location = "/login" 
      }
    },
  ]
});


router.beforeEach((to, from, next) => {
  if(to.matched.some(record => record.meta.requiresAuth)) {
    if (store.getters.isLoggedIn || true) {
      next()
      return
    }
    next('/login') 
  } 
  else {
    next() 
  }
})

export default router;
