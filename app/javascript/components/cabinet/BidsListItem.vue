<template lang="pug">
  div.default-table--item-wrapper.v_line_hover_effect(
    :class="{active: menuShow}"
    )
    span.show-more(
      @click="toggle"
      )
      span.arrow-icon(:class="{active: menuShow}")
      | Info
    .d-block.d-lg-none
      .default-table--heading
        span.id ID
        span.product Product name
        span.partner Initiator / Partner
        span.price Price
        span.comments Comments
        span.update Last update
    .default-table--item(@click.prevent="open")
      .id
        strong {{ bid.type }}
      .product
        ProductName(:item="bid.product")
      .partner
        .company-name
          .company-name--icon
            img(:src="bid.company.logo")
          div
            p(v-html="bid.company.title")
            p {{bid.sender}}
      .price(v-html="bid.amount")
      .comments
        .comment-block
          p {{bid.comment}}
          //- a.read-more(href="#")
          //-   | Read more
          //-   span.arrow-icon
      .update {{ bid.created_at }}
    ContextMenu(
      v-if="options"
      :options="options"
      :item="bid"
      v-on:click="contextClick"
    )
</template>

<script>
import ProductName from '@/components/ProductName';
import ContextMenu from '@/components/ContextMenu';

export default {
  props: ["bid"],
  components: {
    ProductName,
    ContextMenu
  },
  data() {
    return {
      menuShow: false,
      options: [
        { key: "delete", title: this.translate("common.delete") }
      ],
    }
  },
  methods:{
    open(){
      this.$router.push(this.bid.link)
    },
    toggle: function() {
      this.menuShow = !this.menuShow;
    },
    contextClick({key,item}){
      this[key].apply(this, item)
    },
    delete(){
      this.$isLoading('isLoading', 'item_deleted');
      this.$store.dispatch("bids/Delete", this.bid.id).then(response => {
        if(response.success){
          this.$isLoading('isLoading', 'items');
          this.$store.dispatch('bids/List', true);
        }
      }, error => {
        console.log(error)
      })
    },
  }
}
</script>

<style lang="scss" scoped>
.company-name {
  display: flex;
  align-items: center;
  &--icon {
    width: 50px;
    height: 50px;
    border-radius: 50%;
    img {
      width: 100%;
      height: auto;
      border-radius: 50%;
    }
  }
  p {margin: 0;}
}

.comment-block {
  width: 200px;
  padding: 5px 10px;
  font-style: italic;
  color: #969BA2;
  background: #F6F7F9;
  border-radius: 5px;
  p {
    height: 40px;
    margin: 0;
    overflow: hidden;
  }
  .read-more {
    top: 3px;
    color: #cd1515;
    font-style: normal;
    .arrow-icon {
      &:before,
      &:after {
        height: 6px;
        background: #cd1515;
      }
      &:before {
        left: 6px;
      }
    }
  }
}
</style>
