<template lang="pug">
  .user-quick-menu(
    :class="{ active: menuShow }"
    v-on-clickaway="closeMenu"
    @click="toggle()"
    ) {{user.user_name}}
    span.arrow-icon(:class="{ active: menuShow }")
    ul.quick-submenu(
      :class="{ active: menuShow }"
      )
      li.quick-submenu--item(v-for="item in list")
        a.quick-submenu--link(@click.prevent="clickUrl(item)") {{ item.title }}
</template>

<script>
import { directive as onClickaway } from 'vue-clickaway';

export default {
  directives: {
    onClickaway: onClickaway,
  },
  props: ['list'],
  data() {
    return {
      menuShow: false,
    }
  },
  methods: {
    toggle() {
      this.menuShow = !this.menuShow
    },
    closeMenu(){
      this.menuShow = false
    },
    clickUrl(item){
      if(item.url == 'pricing') {
        window.location = '/pricing'
        return
      }
      if(item.url == 'logout') {
        window.localStorage.clear()
        window.location = '/logout'
        return
      }
      if("/marketplace" == window.location.pathname){
        this.$router.push({name: item.url})
      }
      else{
        const url = item.url.replace("marketplace","")
        window.location = this.$router.resolve({name: url}).href
      }
    }
  }
}
</script>

<style lang="scss" scoped>
</style>
