<template lang="pug">
  .sort-bar
    span.title {{ translate("common.sort_by") }}
    div
      button.sort-bar--btn(v-for="type in types" :key="type" @click="setActive(type)") {{ translate("common.sorting." + type) }}
        span.sort-arrow(v-if="isDesc && isActive(type)") ↓
        span.sort-arrow(v-if="isAsc && isActive(type)") ↑
</template>

<script>
export default {
  props: ['types','place'],
  data() {
    return {
    }
  },
  methods: {
    setActive(type){
      const dir = this.isDesc ? 'ASC' : 'DESC'
      this.$store.dispatch('products/SetPage', 1 );
      this.$router.push({ query: Object.assign({}, this.$route.query, {direction: dir, field: type} ) });
    },
    isActive(type){
      return this.$store.getters[ this.place + '/getSorting'].field == type
    },
  },
  computed: {
    currentDirection(){
      return this.$store.getters[ this.place + '/getSorting'].direction;
    },
    isDesc(){
      return "DESC" == this.currentDirection;
    },
    isAsc(){
      return "ASC" == this.currentDirection;
    }
  }
}
</script>

<style lang="scss" scoped>
</style>
