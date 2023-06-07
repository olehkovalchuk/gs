<template lang="pug">
div
  .side-nav--item(
    :key="item.id"
    v-show="item.children.length"
    )
    a.side-nav--link(
      @mouseover.prevent="openMenu(item)"
      @click.prevent="openMenu(item)"
      :class="item.className"
      :href="getHref"
      )
      svg-icon(
        :name="item.icon"
        class="side-nav--icon"
        :class="item.className"
      )
      span {{item.title}}
      span.arrow-icon(v-show="item.children.length")
  .submenu(
    v-if="menuShow"
    v-on-clickaway="closeMenu"
    )
    ProductNavSubmenuList(v-for="sub in item.children" :key="item.id" :item="sub" v-on:update="closeMenu" :path="path" v-if="!withSelect")
    a.show-all-link(:href="getHref" @click.prevent="setCategory(item)") {{ translate("common.all_categories") }}
</template>

<script>
import Vue from 'vue';
const eventBus = new Vue();
import { directive as onClickaway } from 'vue-clickaway';
import ProductNavSubmenu from '@/components/ProductNavSubmenu';
import ProductNavSubmenuList from '@/components/ProductNavSubmenuList';
export default {
  props: ['item','path','withSelect'],
  directives: {
    onClickaway: onClickaway,
  },
  components: {
    ProductNavSubmenu,
    ProductNavSubmenuList
  },
  data(){
    return {
      menuShow: false,
    }
  },
  created (){
    eventBus.$on('close', (data) => {
      this.closeMenu()
    })
  },
  methods: {
    // getHref(item) {
    //   return `${this.$store.getters['products/getActiveItemType']}/category/${item.seo}`
    // },
    setCategory(item) {
      this.$store.dispatch('products/SetPage', 1 );
      let params = {}
      if(false && this.path){
        params = {path: `/${this.path}`}
      } else {
        params = {name: `${this.$store.getters['products/getActiveItemType']}-category`, params: {seo: item.seo} }
      }
      this.$router.push(params);
      this.menuShow = false;
      this.$emit("update")
    },
    openMenu(item) {
      if(this.withSelect){
        this.$emit("select",item)
      }
      else if(item.children.length){
        eventBus.$emit('close')
        this.menuShow = true;
      }
      else{
        this.$router.push({ query: Object.assign({}, this.$route.query, {category_id: item.id} ) });
      }
    },
    closeMenu() {
      this.menuShow = false;
    }
  },
  computed: {
    getHref() {
      return `${this.$store.getters['products/getActiveItemType']}/category/${this.item.seo}`
    },
  },
}
</script>

<style lang="scss" scoped>
  @media (max-width: 1199.98px) {
    width: 200%;
  }
</style>
