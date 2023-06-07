<template lang="pug">
  .side-nav--item(
    :class="{ active: menuShow }"
    v-show="item.children.length"
    )
    span(
      class="side-nav--link"
      @click="this.toggle"
    )
      MessageCounter(v-if="item.name == this.translate('common.inbox')")
      svg-icon(
        :name="item.icon"
        class="side-nav--icon user"
      )
      | {{ item.name }}
      span.arrow-icon(:class="{ active: menuShow }")
    ul.side-nav--submenu
      li.side-nav--submenu-item(v-for="item in item.children")
        router-link(
          :to="{name: item.path}"
          class="side-nav--submenu-link"
          ) {{ item.name }}
</template>

<script>
import MessageCounter from "@/components/MessageCounter";
export default {
  props: ['item'],
  components: {
    MessageCounter
  },
  data() {
    return {
      menuShow: false,
    }
  },
  created(){
    if(this.item.children.find(st => st.path === this.$route.name)){
      this.menuShow = true
    }
    this.eventHub.$on('toggle', item => {
      if(this.item.icon != item.icon){
        this.menuShow = false
      }

    })
  },
  methods: {
    toggle: function() {
      this.eventHub.$emit('toggle',this.item)
      this.menuShow = !this.menuShow;
    }
  }
}
</script>

<style lang="scss" scoped>
  .side-nav {
    &--item {
      position: relative;
      &.active {
        .side-nav--submenu {
          display: block;
        }
      }
    }
    &--link {
      .arrow-icon {
        transform: rotate(0);
      }
    }
    &--submenu {
      display: none;
    }

    .router-link-active {
      color: #CD1515;
      background-color: #FCE7EE;
      .arrow-icon {
        &:before {
          transform: rotate(45deg);
        }
        &:after {
          transform: rotate(-45deg);
        }
      }
      & ~ .side-nav--submenu {
        display: block;
      }
    }
  }

  .message-counter {
    right: auto;
    top: 4px;
    left: 24px;
    pointer-events: none;
  }
</style>
