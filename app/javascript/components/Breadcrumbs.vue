<template lang="pug">
  .breadcrumbs
    .container
      ul
        li(v-if="previous")
          a(href="#" @click.prevent="back") {{previous.title}}
        li.arrow(v-if="previous && previous.title") →
        li(v-if="current")
          a.active(href="#" @click.prevent) {{current.title}}
</template>


<script>
export default {
  computed:{
    previous(){
      return this.breadcrumbs.length ? this.breadcrumbs[(this.breadcrumbs.length - 1)] : null;
    },
    back(){
      this.$router.push({path: this.previous.path, params: {back: true} })
      this.$store.dispatch("marketplace/RemoveBreadcrumps")
    },
    current(){
      return { title: this.$route.meta.breadcrump }
    },
    breadcrumbs(){
      return this.$store.getters['marketplace/breadcrumbs'] || [];
    }
  },
}
</script>

<style lang="scss" scoped>
.breadcrumbs {
  width: 100%;
  background-color: #fff;
  border-top: 2px solid #F6F7F9;
  font-size: 12px;
  .container {
    padding-top: 5px;
    padding-bottom: 5px;
  }
  ul {
    display: flex;
    align-items: center;
    .arrow {
      margin: 0 10px;
    }
  }
  a {
    color: #000;
    &:hover {
      text-decoration: underline;
    }
    &.active {
      padding: 2px 12px;
      color: #CD1515;
      background: #FFF0F5;
      border-radius: 5px;
      &:hover {
        text-decoration: none;
      }
    }
  }
}
</style>
