<template lang="pug">
  .check-block
    input(type="checkbox" :name="'offers['+item.id+']'" :id="item.id" v-model="checked" )
    label(:for="item.id" @click="click")
</template>

<script>
export default {
  props:["item"],
  data() {
    return { checked: this.value }
  },
  methods:{
    click(){
      this.checked = !this.checked
    }
  },
  watch: {
    checked(val) {
      this.$emit('input', val);
    },
    value(val) {
      this.checked = val
    }
  }
}
</script>

<style lang="scss" scoped>
</style>
