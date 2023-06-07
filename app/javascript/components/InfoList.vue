<template lang="pug">
  ul.info-list(
    :class="{ active: menuShow }"
    )
    li.title(
      v-if="title"
      @click="toggle"
      :class="{ active: menuShow }"
      ) {{ title }}
      span.arrow-icon(:class="{ active: menuShow }")
    li.info-list--item(v-for="item in data")
      strong(v-show="item.title") {{ item.title }}:
      span {{ item.value }}
</template>

<script>
export default {
  props: ['title', 'data'],
  data() {
    return {
      menuShow: false
    }
  },
  methods: {
    toggle: function() {
      this.menuShow = !this.menuShow;
    }
  }
}
</script>

<style lang="scss" scoped>
</style>
