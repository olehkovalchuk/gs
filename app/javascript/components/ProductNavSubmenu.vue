<template lang="pug">
  ul.submenu-list
    li.submenu-list--item(v-for="item in items")
      a.submenu-list--link(href="#" @mouseover="open(item)" @click.prevent="select(item)" :class="{selected: selected.id == item.id || selected.parent_id == item.id }")
        | {{ item.title }}
        span.arrow-icon(v-show="item.children.length")
</template>

<script>
export default {
  props: ['items','selected'],
  methods: {
    select(item){
      this.eventHub.$emit('selectCategory', item)
      this.$emit("selectItem",item)
    },
    open(item){
      this.$emit("openItem",item)
    },
  },
  computed: {
    selectedItem() {
      this.eventHub.$on('selectCategory', item => {
        this.selected = item
      })
    }
  }
}
</script>

<style lang="scss" scoped>
</style>
