<template lang="pug">
  .context-menu(
    @click.prevent.stop="openMenu"
    )
    span.dot
    span.dot
    span.dot
    .context-menu--item(
        v-if="menuShow"
        v-on-clickaway="closeMenu"
      )
      a(href="#" v-for="option in options" @click.prevent.stop="click(option)") {{option.title}}
</template>

<script>
import { directive as onClickaway } from 'vue-clickaway';
export default {
  props: ["options","item"],
  directives: {
    onClickaway: onClickaway,
  },
  data() {
    return {
      menuShow: false,
    }
  },
  methods: {
    click(option){
      this.$emit("click", {key: option.key, item: this.item} )
      this.closeMenu()
    },
    openMenu(e) {
      this.menuShow = true;
    },
    closeMenu() {
      this.menuShow = false;
    },
  },
}
</script>

<style lang="scss" scoped>
.context-menu{
  cursor: pointer;
}
</style>
