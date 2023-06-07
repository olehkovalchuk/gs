<template lang="pug">
  b-modal(
    :title="translate('common.select_category_title')"
    id="select-category"
    centered
    dialog-class="popup-default popup-default--big"
    content-class="popup-default--content select-category"
    header-class="popup-default--header"
    body-class="popup-default--body"
    hide-footer
    ref="categoryModalRef"
    )
    .category-search
      treeselect(
        class=""
        :options="categoriesForComplete"
        :normalizer="normalizer"
        :disable-branch-nodes="true"
        v-model="value"
        search-nested
      )
    .category-block
      .category-block--item
        ProductNav(:items="items" v-on:select="select" :withSelect="true")
      .category-block--item
        ProductNavSubmenu(:items="subSelected" v-on:selectItem="selectItem" v-on:openItem="openItem" :selected="selectedCategory")
      .category-block--item
        ProductNavSubmenu(:items="lastSelected" v-on:selectItem="selectLast" :selected="selectedCategory")
    .btn-block(v-if="selectedCategory.id")
      p {{translate("common.selected_category")}}:
        span.red
          |  {{selectedCategory.title}}
      div
        span.clear(@click="clearAll") Clear
        button.btn(@click="choose") {{translate("common.done")}}
</template>

<script>
import ProductNav from '@/components/ProductNav';
import ProductNavSubmenu from '@/components/ProductNavSubmenu';
import Treeselect from '@riophae/vue-treeselect'

export default {
  inject: ['$validator'],
  props:["items"],
  components: {
    ProductNav,
    ProductNavSubmenu,
    Treeselect
  },
  methods: {
    prepareCategories(categories){
      if(categories == undefined){
        return []
      }
      const self = this
      return categories.map(function(x) {
        if(x.children.length){
          x.children = self.prepareCategories(x.children)
        }
        else{
          if(x.children.length == 0) {
            delete x["children"]
          }
        }
        return x
      });
    },
    findObjectById(item, id) {
      if(item.id == id){
        return item
      }
      const self = this
      if(item.children && item.children.length){
        for (let i = 0; i < item.children.length; i++) {
          let children = self.findObjectById(item.children[i], id)
          if (children != false){
            return children
          }
        }
      } else {
        return false
      }
      return false
    },
    clearAll(){
      this.selectedCategory = {}
      this.subSelected = []
      this.lastSelected = []
    },
    clear(){
      this.subSelected = []
      this.lastSelected = []
    },
    select(item){
      this.clear()
      this.subSelected = item.children 
    },
    selectItem(item){
      if(item.children.length > 0){
        this.lastSelected = item.children
        this.selectedCategory = {}
      }
      else {
        this.selectedCategory = item
        this.lastSelected = []
      }
    },
    openItem(item){
      let element = event.target
      element.focus()
      if(item.children.length > 0){
        this.lastSelected = item.children
      }
    },
    selectLast(item) {
      this.selectedCategory = item
    },
    choose(){
      this.$emit("input",this.selectedCategory)
      this.$refs.categoryModalRef.hide()
    },
    prepare(newVal){
      let cat = JSON.parse(JSON.stringify(newVal));
      this.categoriesForComplete = this.prepareCategories(cat)
    }
  },
  data() {
    return {
      value: null,
      selectedCategory: {},
      subSelected: [],
      lastSelected: [],
      categoriesForComplete:[],
      normalizer(categoriesForComplete) {
        return {
          label: categoriesForComplete.title,
        }
      },
    }
  },
  created(){
    if(this.items){
      this.prepare(this.items)
    }
  },
  watch: {
    items(newVal, old){
      if(newVal){
        this.prepare(newVal)
      } else {
        this.subSelected = []
        this.lastSelected = []
      }
    },
    value(newVal, old){
      for (let i = 0; i < this.items.length; i++){
        this.selectedCategory = this.findObjectById(this.items[i], newVal);
        if(Object.keys(this.selectedCategory).length > 0) {
          break;
        }
      }
    }
  },

}
</script>

<style lang="scss" scoped>
  .side-nav {
    display: block;
  }
  .clear {
    cursor: pointer;
  }
  .btn-block {
    & > div {
      display: flex;
      justify-content: space-between;
      align-items: center;
      flex: 1;
      max-width: 180px;
    }
  }
</style>

