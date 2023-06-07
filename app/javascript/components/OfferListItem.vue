<template lang="pug">
a(:href="getUrl()" @click.self="pushRoute" :class="{ v_line_hover_effect: hasHoverClass, inactive: !item.active }" class="offer-list--item")
  CheckBlock(v-if="hasCheckBlock" :item="item" v-model="checked")
  .offer-list--item--img(v-if="hasImg")
    img(:src="item.img" :alt="item.title" :title="item.title")
  .offer-list--item--text
    p.product-name {{ item.title }}
    div
      strong.price(v-html="item.price")
      p.product-quantity(v-if="item.quantity > 0") Quantity: {{item.quantity}}
      .delivery-info
        span {{ item.delivery }}
        span.info-icon(v-tooltip.bottom="item.tooltip" v-if="item.tooltip")
    button.btn.btn__small.btn__transparent.showcase-btn(
      @click.prevent.stop="callPopup" 
      v-if="hasShowCase && !item.in_top"
      )
        span(v-show="$route.path == '/cabinet/offers'") Showcase offer
        span(v-show="$route.path == '/cabinet/requests'") Showcase request
  ContextMenu(
    v-if="options"
    :options="options"
    :item="item"
    v-on:click="contextClick"
  )
</template>

<script>
import ContextMenu from '@/components/ContextMenu';
import CheckBlock from '@/components/CheckBlock';

  export default {
    data(){
      return {
        checked: false
      }
    },
    watch: {
      checked(val) {
        this.$store.dispatch("products/Select", {id: this.item.id, val: val})
      }
    },
    props: [
      'item',
      'options',
      'hasImg',
      'hasHoverClass',
      'hasCheckBlock',
      'hasQuantity',
      'hasShowCase'
    ],
    components: {
      ContextMenu,
      CheckBlock,
    },
    methods: {
      callPopup() {
        this.$emit('showPopup', this.item);
      },
      getUrl(){
        return `marketplace/${this.item.type}s/${this.item.id}`
      },
      pushRoute(){
        if(!this.hasCheckBlock){
          this.$router.push({ name: this.item.type, params: { id: this.item.id }})
        }
      },
      contextClick({key,item}){
        this[key].apply(this, item)
      },
      edit(){
        this.$router.push({ name: `cabinet-${this.item.type}`, params: { id: this.item.id } })
      },
      delete(){
        this.$isLoading('isLoading', 'item_deleted');
        this.$store.dispatch("products/Delete", this.item.id).then(response => {
          if(response.success){
            this.$isLoading('isLoading', 'items');
            this.$store.dispatch('products/List', {cabinet: true} );
          }
        }, error => {
          console.log(error)
        })
      },
    }
  }
</script>

<style lang="scss" scoped>

.showcase-btn {
  margin-top: 15px;
}

</style>
