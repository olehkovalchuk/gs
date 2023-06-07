<template lang="pug">
  .set-alert.default-block
    h3.title Set buyer alert
    .form_row
      button.btn.btn__transparent.category-btn(
        @click.prevent="openCategory"
        :class="{ 'error': submited && errors.has('category') }"
      ) {{ translate("common.select_category")}}
      span.error-msg(v-show="submited && errors.has('category')") {{translate("common.this_field_is_requered")}}
      button.btn.submit-btn(@click="submit()") Set alert
    small.selected-list(v-if="categoryTitleList.length > 0") Selected categories: {{ categoryTitleList.join(", ") }}
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
    submit() {

    },
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
      this.$store.dispatch('products/SendAlert', {category_id: item.id}).then(response => {
        if(response.success){
          this.socialTrack('Activities')
          this.socialTrack('SetAlert', 'set_alert')
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
      category:{},
      submited: false,
    }
  },
  created() {
    this.categoryTitleList = this.user.alert_titles || []
  },

}
</script>

<style lang="scss" scoped>

.set-alert {
  margin-top: 20px;
  padding: 20px;
  background: url("~assets/img/gradient_bg.png") no-repeat;
  background-position: 50%;
  background-size: cover;
  h3 {
    margin-bottom: 20px;
    color: #fff
  }
  .form_row {
    display: flex;
  }
  .category-btn {
    flex: 2;
    max-width: 450px;
    border-right: none;
    border: none;
    background: #fff;
    border-radius: 5px 0 0 5px;
  }
  .submit-btn {
    min-width: 150px;
    border-left: none;
    border-radius: 0 5px 5px 0;
  }
  .selected-list {
    color: #fff;
  }
}

</style>


