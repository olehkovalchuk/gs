<template lang="pug">
  header.header
    .container
      .row.align-items-center
        .col-xl-2.col-lg-3.col-md-4.col-sm-4.col-12
          .header--item
            .burger-btn.d-xl-none(
              @click="toggle()"
              :class="{ active: menuShow }"
              )
              span.line.line--top
              span.line.line--center
              span.line.line--bottom
            router-link.header--logo(:to="{name:'marketplace'}" v-if="show_map")
              img(src="@/assets/img/logo.svg" alt="Global Supplies" title="Global Supplies")
            a.header--logo(href="/" v-if="!show_map")
              img(src="@/assets/img/logo.svg" alt="Global Supplies" title="Global Supplies")
        .col
          .header-nav-block.d-none.d-sm-flex
            div
              ul.header-nav.d-none.d-xl-flex
                li.header-nav--item(:class="{ active: 'marketplace' == activeTab }" v-if="config.marketplaces.length > 1")
                  a.header-nav--link(href="#" @click.prevent)
                    | {{translate("common.marketplace")}}
                    span.arrow-icon
                  ul.header-nav-submenu
                    li.header-nav-submenu--item(v-for="(t,k) in translate('common.marketplaces')")
                      a.header-nav-submenu--link(:href="marketLink(k)") {{t}}
                li.header-nav--item(:class="{ active: 'marketplace' == activeTab }" v-else)
                  a.header-nav--link(href="/marketplace") {{translate("common.marketplace")}}
                li.header-nav--item(:class="{ active: 'benefits' == activeTab }")
                  a.header-nav--link(href="#")
                    | {{translate("common.benefits")}}
                    span.arrow-icon
                  ul.header-nav-submenu
                    li.header-nav-submenu--item(v-for="(t,k) in translate('common.benefits_list')")
                      a.header-nav-submenu--link(:href="'/benefits/' + k ") {{t}}
                li.header-nav--item(v-if="!user.user_name || !show_map" :class="{ active: 'about' == activeTab }")
                  a.header-nav--link(href="/about") {{translate("common.about_us")}}
                li.header-nav--item(:class="{ active: 'how_it_works' == activeTab }")
                  a.header-nav--link(href="/how_it_works") {{translate("common.how_it_works")}}
                li.header-nav--item(v-if="!user.user_name || !show_map" :class="{ active: 'articles' == activeTab }")
                  a.header-nav--link(href="/articles") {{translate("common.news")}}
                li.header-nav--item(:class="{ active: 'faq' == activeTab }")
                  a.header-nav--link(href="/faq") {{translate("common.faq")}}
            //- a.d-none.d-xl-block.btn(@click.prevent="goToLogin" href="#" v-if="show_map && !user.user_name") {{translate("common.login")}}
            div(style="display: flex; align-items: center").buttons
              a.d-none.d-xl-block.btn(@click.prevent="goToLogin" href="#" v-if="!user.user_name") {{translate("common.login")}}
              .user-menu(v-if="user.user_name")
                router-link.user-menu--avatar(
                  :to="{name:'cabinet-menu'}"
                  v-if="this.window.width <= 991.98"
                  )
                  MessageCounter
                  img(:src="user.avatar")
                .avatar-wrapper
                  router-link.user-menu--avatar(
                    :to="{name:'cabinet'}"
                    v-if="this.window.width > 992"
                    )
                    img(:src="user.avatar")
                  MessageCounter
                QuickMenu(:list="userMenuList")
                .header--menu--item
              //- v-select(
              //-   class="simple-select lang-select"
              //-   v-model="defauldLangSelected",
              //-   :options="lang",
              //-   :clearable="false",
              //-   :searchable="false"
              //- )
              //- a.d-none.d-xl-block.btn(@click.prevent="goToLogin" href="#" v-if="!show_map && !user.user_name") {{translate("common.login")}}
              router-link(
                v-if="show_map && isNotMap"
                :to="{name: 'map'}"
                ).btn {{translate("common.go_to_map")}}
                span.arrow-sign →
              router-link(
                v-if="!isNotMap"
                :to="{name: 'marketplace'}"
                ).btn.d-none.d-xl-block {{translate("common.got_to_market")}}
                span.arrow-sign →
        //- .d-none.d-md-block.col-xl-2.col-lg-3.col-md-3.col-sm-4
          //- .header--menu--item
          //-   //- v-select(
          //-   //-   class="simple-select lang-select"
          //-   //-   v-model="defauldLangSelected",
          //-   //-   :options="lang",
          //-   //-   :clearable="false",
          //-   //-   :searchable="false"
          //-   //- )
          //-   a.d-none.d-xl-block.btn(@click.prevent="goToLogin" href="#" v-if="!show_map && !user.user_name") {{translate("common.login")}}
          //-   router-link(
          //-     v-if="show_map && isNotMap"
          //-     :to="{name: 'map'}"
          //-     ).btn {{translate("common.go_to_map")}}
          //-     span.arrow-sign →
          //-   router-link(
          //-     v-if="!isNotMap"
          //-     :to="{name: 'marketplace'}"
          //-     ).btn.d-none.d-xl-block {{translate("common.got_to_market")}}
          //-     span.arrow-sign →
      .user-menu.d-flex.d-none.d-sm-none(v-if="user.user_name")
        router-link.user-menu--avatar(
          :to="{name:'cabinet-menu'}"
          v-if="this.window.width <= 991.98"
          )
          MessageCounter
          img(:src="user.avatar")
        .avatar-wrapper
          router-link.user-menu--avatar(
            :to="{name:'cabinet'}"
            v-if="this.window.width > 992"
            )
            img(:src="user.avatar")
          MessageCounter
        QuickMenu(:list="userMenuList")

    .header--mobile-menu(  :class="{ active: menuShow }" )
      //- .header--mobile-menu--item
      //-   v-select(
      //-     class="lang-select simple-select"
      //-     v-model="defauldLangSelected",
      //-     :options="lang",
      //-     :clearable="false",
      //-     :searchable="false"
      //-   )
      .header--mobile-menu--item(@click="toggle()")
        a.btn(@click.prevent="goToLogin" href="#" v-if="!user.user_name") {{translate("common.login")}}
        router-link(
          v-if="show_map"
          :to="{name: 'map'}"
          ).btn {{translate("common.go_to_map")}}
          span.arrow-sign →
      .header--mobile-menu--nav()
        NavMenu
        ExternalLinks
    Breadcrumbs(v-if="showBreadcrumbs")
    AuthPopup(v-if="!user.user_name")
</template>

<script>
import NavMenu from "@/components/NavMenu";
import ExternalLinks from "@/components/ExternalLinks";
import MessageCounter from "@/components/MessageCounter";
import QuickMenu from "@/components/QuickMenu";
import Breadcrumbs from "@/components/Breadcrumbs";
import AuthPopup from "@/components/AuthPopup.vue";

export default {
  components: {
    NavMenu,
    ExternalLinks,
    MessageCounter,
    QuickMenu,
    Breadcrumbs,
    AuthPopup
  },
  data() {
    return {
      menuShow: false,
      defauldLangSelected: "En",
      activeTab: window.location.pathname.replace('/',''),
      lang: ["En"],
      window: {
        width: 0
      },
      userMenuList: [
        {title: this.translate('common.my_profile'), url: 'cabinet'},
        {title: this.translate('common.messages'), url: 'cabinet-chats'},
        {title: this.translate('common.company_profile'), url: 'cabinet-company'},
        {title: this.translate('common.add_offer'), url: 'add-new-offer'},
        {title: this.translate('common.add_request'), url: 'add-new-request'},
        {title: this.translate('common.faq'), url: 'faq'},
        {title: this.translate('common.logout'), url: 'logout', logout: true},
      ]
    }
  },
  methods: {
    goToLogin(){
      this.socialTrack('LogIn', 'login')
      this.showLogin()
      if("login" != this.$router.name){
        this.$router.push({name: "login"})
      }
    },
    marketLink(market){
      return this.config.default_market == market ? '/marketplace' : `/${market}/marketplace/`
    },
    toggle: function() {
      this.menuShow = !this.menuShow
    },
    handleResize() {
      this.window.width = window.innerWidth;
    },
  },
  created() {
    window.addEventListener('resize', this.handleResize)
    this.handleResize();
  },
  destroyed() {
    window.removeEventListener('resize', this.handleResize)
  },
  computed:{
    isNotMap(){
      return 'map' != this.$route.name
    },
    show_map(){
      return gon.config.show_map;
    },
    showBreadcrumbs(){
      return this.show_map && !this.$route.meta.is_map
    }
  }

}
</script>
<style lang="scss" scoped>
  .header-nav--item.active .header-nav--link:after {
    width: 100%;
  }
  .buttons a:last-child {
      margin-left: 10px;
    }
</style>
