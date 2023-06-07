<template lang="pug">
  .faq-page.mt-5
    .container
      .row
        .col-lg-3
          ul.tab-menu.default-block
            li(
              class="tab-menu--item"
              v-for="(tab, index) in tabs"
              @click="currentTab = tab"
              :class="{active: currentTab.category === tab.category}")
              svg-icon(
                :name="tab.icon"
                class="tab-menu--icon"
                :class="tab.icon"
                )
              | {{tab.name}}
        .col-lg-9
          .tab-content.default-block
            h1 FAQ | Global Supplies
            .tab-content--item(v-show="currentTab.category === k" v-for="(faqs,k) in items" :key="k")
              template(v-for="item in faqs")
                .tab-content--header(v-b-toggle="'accordion-'+ item.id"  :key="item.id" @click="showFaq(item.id)" ) 
                  | {{item.title}}
                  span.arrow-icon
                b-collapse(:id="'accordion-' + item.id" accordion="accordion" :key="k + '_' + item.id")
                  .tab-content--text(v-html='text')
</template>

<script>
  export default {
    data() {
        return {
            currentTab: {category: 'marketplace'},
            tabs: [
              {icon: 'icon-bag', name: 'Marketplace', category: 'marketplace'},
              {icon: 'icon-user', name: 'Account', category: 'account'},
              {icon: 'icon-gs-logo', name: 'About us', category: 'about'},
            ]
        };
    },
    created(){
      this.$isLoading('isLoading', 'items');
      this.$store.dispatch('faq/List');
    },
    methods:{
      showFaq(id){
        this.$isLoading('isLoading', 'item');
        this.$store.dispatch('faq/Show',id);
      }
    },
    computed: {
      items(){
        return this.$store.getters['faq/getItems'];
      },
      text(){
        return this.$store.getters['faq/getItem'];
      }
    }
  }
</script>

<style lang="scss" scoped>
</style>
