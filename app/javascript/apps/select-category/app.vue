<template lang="pug">
  div
    button.btn.btn__transparent.category-btn(
      @click.prevent="openCategory"
      :class="{ 'error': submited && errors.has('category') }"
    ) {{ translate("common.select_category")}}
    SelectCategoryPopup(
      :items="config.categories"
      v-model="category"
      @input="pushSelectedCategory"
      v-validate="'required'"
      data-vv-name="category"
    )
</template>

<script>
import SelectCategoryPopup from '@/components/SelectCategoryPopup';

export default {
  props: ["id"],
  components: {
    SelectCategoryPopup
  },
  methods:{
    getProduct(){
      if(this.id){
        this.$isLoading('isLoading', 'item_edited');
        this.$store.dispatch('products/Edit',this.id)
      }
    },
    openCategory(){
      this.$bvModal.show("select-category")
    },
    pushSelectedCategory(item) {
      console.log(item)
      this.$store.dispatch('products/SendAlert', {category_id: item.id}).then(response => {
        if(response.success){
          this.categoryTitleList.push(item.title)
          this.$store.dispatch('marketplace/Success', this.translate("common.success_saved"))
        }
        else{
          this.$store.dispatch('marketplace/Failure',response.message)
        }
      })

    }
    
  },
  data() {
    return {
      categoryTitleList: [],
      category: {},
      submited: false,
    }
  },
  created() {
    this.categoryTitleList = this.user.alert_titles || []
  },

}
</script>
<style lang="scss">
  @import 'node_modules/@riophae/vue-treeselect/dist/vue-treeselect';
</style>
