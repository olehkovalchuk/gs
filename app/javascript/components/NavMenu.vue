<template lang="pug">
  ul.nav-menu
    li.nav-menu--item(v-if="config.marketplaces.length > 1" v-for="(t,k) in translate('common.marketplaces')")
      a(:href="marketLink(k)") {{t}} {{translate("common.marketplace")}} 
    li.nav-menu--item(v-else)
      a(href="/marketplace") {{translate("common.marketplace")}} 
    li.nav-menu--item(v-for="(t,k) in translate('common.services_list')")
      a(:href="'/services/' + k ") {{t}}
    li.nav-menu--item
      a(href="/pricing") {{translate("common.pricing")}}
    li.nav-menu--item(v-for="(t,k) in translate('common.benefits_list')")
      a(:href="'/benefits/' + k ") {{t}}
    li.nav-menu--item
      a(href="/faq") {{translate("common.faq")}}
    li.nav-menu--item
      a(href="/articles") {{translate("common.news")}}
    li.nav-menu--item
      a(href="/how_it_works") {{translate("common.how_it_works")}}
    li.nav-menu--item
      a(href="/about") {{translate("common.about_us")}} 
</template>

<script>
export default {
  methods: {
    marketLink(market){
      return this.config.default_market == market ? '/marketplace' : `/${market}/marketplace/`
    }
  }
}
</script>

<style lang="scss" scoped>
.nav-menu {
  &--item {
    margin-bottom: 15px;
    &:last-child {
      margin: 0;
    }
  }
}
</style>
