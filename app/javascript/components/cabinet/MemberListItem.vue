<template lang="pug">
  a(
    href="#"
    class="members-list--item v-line-hover-effect"
    )
    .member-image( style="background:#C5CBD4")
      img(:src="item.avatar" v-if="item.id")
    .member-info
      p.member-name {{ item.user_name }}
      span.member-position {{ item.title }}
    ContextMenu(:options="context()" :item="item" v-on:click="contextClick" v-if="item.id")
</template>

<script>
import ContextMenu from '@/components/ContextMenu'
export default {
  props: ["item"],
  components: {
    ContextMenu
  },
  methods:{
    context(){
      const options = [...this.defaultOptions];

      if(this.user.id != this.item.id){
        options.push( { key: "delete", title: this.translate("common.delete") } )
      }
      return options;
    },
    edit(){
      this.$router.push({ name: 'member', params: { id: this.item.id } })
    },
    delete(){
      this.$isLoading('isLoading', 'item_deleted');
      this.$store.dispatch("users/Delete", this.item.id).then(response => {
        if(response.success){
          this.$isLoading('isLoading', 'items');
          this.$store.dispatch('users/List');
        }
      }, error => {
        console.log(error)
      })
    },
    contextClick({key,item}){
      this[key].apply(this, item)
    }
  },
  data(){
    return {
      defaultOptions:[
        { key: "edit", title: this.translate("common.edit") }
      ]
    }
  }
}
</script>

<style lang="scss" scoped>
</style>
