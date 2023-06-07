<template lang="pug">
  .submenu-list(
    :class="{ active: menuShow }"
    )
    div(:class="{'submenu-list--title': item.children.length, 'submenu-list--item': !item.children.length}" )
      a(
        @click.prevent="setCategory(item)"
        class="submenu-list--link"
        :href="getHref(item)"
        )
        strong {{ item.title }}
    .submenu-list--item(
      v-for="sub in item.children"
      :key="item.id"
      )
      a(:href="getHref(sub)" @click.prevent="setCategory(sub)" class="submenu-list--link") {{ sub.title }}
</template>

<script>
export default {
  props: ["item","path"],
  data() {
    return {
      menuShow: false
    }
  },
  computed: {
    // getHref() {
    //   return `${this.$store.getters['products/getActiveItemType']}/category/${this.item.seo}`
    // },
  },
  methods: {
    getHref(item) {
      return `${this.$store.getters['products/getActiveItemType']}/category/${item.seo}`
    },
    setCategory(item) {
      this.$store.dispatch('products/SetPage', 1 );
      const type = this.path || this.$store.getters['products/getActiveItemType']
      const params = {name: `${type}-category`, params: {seo: item.seo} }
      this.$router.push(params)
      this.menuShow = false;
      this.$emit("update")
    }
  }
}
</script>

<style lang="scss" scoped>
</style>
