<template lang="pug">
.category-block
  span.category-block--title {{translate("common.select_category_title")}}:
  ul.product-category
    li(
      v-for="item in availableCategories"
      class="product-category--item"
      )
      a(
        href="#"
        @click.prevent="setCategory(item)"
        class="product-category--link"
        :class="[item.cls, {'active':item.id==activeCategory.id }]"
        )
        svg-icon(
          :name="item.icon"
          class="product-category--icon"
          :class="item.cls"
        )
  .line
  SortBar(:types="sortButtons" v-on:update="update" place="companies")
  .category-block--btn-block
    button.btn.btn__transparent {{translate("common.apply")}}
</template>

<script>
import SortBar from '@/components/SortBar';
export default {
  components: {
    SortBar
  },
  methods:{
    update(){
      this.$emit("update")
    },
    setCategory(item){
      this.$store.dispatch('companies/ActiveCategory', item )
      this.$emit("fit")
    }
  },
  computed:{
    activeCategory(){
      return this.$store.getters['companies/getActiveCategory'];
    },
    availableCategories(){
      return this.config.categories.filter((x) => {
        return x.markets.includes(window.gon.config.market)
      })
    }
  },
  data() {
    return {
      listView: false,
      productType: [
        {className: "beef", icon: "icon-cow"},
        {className: "pork", icon: "icon-pork"},
        {className: "poultry", icon: "icon-chicken"},
        {className: "eggs", icon: "icon-egg"},
        {className: "other", icon: "icon-rabbit"}
      ],
      sortButtons: [
        'updated_at',
        'rating'
      ]
    }
  },
}
</script>

<style lang="scss" scoped>
.product-category--link.active{
  background: #fff;
}
</style>
