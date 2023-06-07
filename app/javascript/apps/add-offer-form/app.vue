<template lang="pug">
  form.main-form
    h3 Add your offer in 30 seconds
    .form_row
      div
        button.btn.btn__transparent.category-btn(
          @click.prevent="openCategory"
          :class="{ 'error': submited && errors.has('category') }"
        ) {{ item.category.title || translate("common.select_category")}}
        span.error-msg(v-show="submited && errors.has('category')") {{translate("common.this_field_is_requered")}}
        SelectCategoryPopup(
          :items="config.categories"
          v-model="category"
          @input="pushSelectedCategory"
          v-validate="'required'"
          data-vv-name="category"
        )
    .form_row
      v-select(
        class="form-select"
        :options="config.origins"
        :placeholder="translate('common.country_of_production')"
        label="title" 
        v-model="item.country"
        v-validate="'required'"
        name="country"
        :class="{ 'error': submited && errors.has('country') }"
        )
      span.error-msg(v-show="submited && errors.has('country')") {{translate("common.this_field_is_requered")}}
    .form_row
      input.txtinput(
        type="number"
        @keydown="onlyNumber"
        v-validate="'required'"
        name="price"
        v-model="item.price"
        :placeholder="translate('common.po_price')"
        :class="{ 'error': submited && errors.has('price') }"
      )
      span.error-msg(v-show="submited && errors.has('price')") {{translate("common.this_field_is_requered")}}
    .form_row
      input.txtinput(
        type="email"
        name="email"
        v-model="item.email"
        placeholder="Email"
        :class="{ 'error': submited && errors.has('email') }"
      )
      span.error-msg(v-show="submited && errors.has('email')") {{translate("common.this_field_is_requered")}}
    .form_row
      b-form-file(
        multiple 
        :file-name-formatter="formatNames"
        :browse-text="' '"
        v-model="item.files"
        accept=".jpg, .png, .gif"
        )
      //- .attach-file-block
      //-   input#file.inputfile(type="file" name="file" multiple="true")
      //-   label.inputfile_label(for="file") 
      //-     span Choose file
      //-     .button
      //-       svg(height="17", viewbox="0 0 20 17", width="20", fill="#fff", xmlns="http://www.w3.org/2000/svg")
      //-         path(d="M10 0l-5.2 4.9h3.3v5.1h3.8v-5.1h3.3l-5.2-4.9zm9.3 11.5l-3.2-2.1h-2l3.4 2.6h-3.5c-.1 0-.2.1-.2.1l-.8 2.3h-6l-.8-2.2c-.1-.1-.1-.2-.2-.2h-3.6l3.4-2.6h-2l-3.2 2.1c-.4.3-.7 1-.6 1.5l.6 3.1c.1.5.7.9 1.2.9h16.3c.6 0 1.1-.4 1.3-.9l.6-3.1c.1-.5-.2-1.2-.7-1.5z")
    .form_row
      button.btn(@click.prevent="submit") {{ translate("common.add_offer")}}
</template>

<script>
import SelectCategoryPopup from '@/components/SelectCategoryPopup';

export default {
  props: ["id"],
  components: {
    SelectCategoryPopup
  },
  methods:{
    formatNames(files) {
      if (files.length === 1) {
        return files[0].name
      } else {
        return `${files.length} files selected`
      }
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
      this.$validator.errors.remove('category')
      this.item.category = item
    },
    getPayload(){
      console.log(this.item)
      return {
        country_code: this.item.country.code,
        category_id: this.item.category.id,
        ...this.item
      }
    },
    async validateForm(){
      this.errors.clear()
      console.log(this.item)
      const toValidate = [
        this.$validator.validate('price'),
        // this.$validator.validate('email'),
        this.$validator.validate('country')
      ]
      if(!this.item.category.id){
        this.$validator.errors.add({ field: 'category', msg: `Category is invalid` });
      }
      const results = Promise.all([...toValidate]);
      return (await results).every(isValid => isValid);
    },
    submit (e) {
      this.submited = true;
      this.validateForm().then((result) => {
        console.log(this.errors.items)
        if(!this.errors.items.length){
          this.$isLoading('isLoading', 'item_saved');
          this.$store.dispatch('products/CreateQuick', this.getPayload() ).then(response => {
            this.submited = false
            if(response.success){
              this.$store.dispatch('marketplace/NeedLogin',true)
              this.$store.dispatch('marketplace/Success',response.message)
            }
            else{
              this.$store.dispatch('marketplace/Failure',response.message)
            }
          });
        }
      })
    },
  },
  data() {
    return {
      categoryTitleList: [],
      category:{},
      submited: false,
      item: {
        category: {}
      }
    }
  },
  created() {
    this.categoryTitleList = this.user.alert_titles || []
  },
  mounted(){
    if(!window.gon.config.is_lighthouse){
      this.$isLoading('isLoading', 'global_config');
      this.$store.dispatch('marketplace/GlobalConfig');
    }
  }
}
</script>
<style lang="scss">
  @import "@/assets/styles/main.scss";
</style>
<style lang="scss" scoped>

@import 'node_modules/@riophae/vue-treeselect/dist/vue-treeselect';

/deep/.custom-file-input:focus ~ .custom-file-label {
  border: 1px solid #ced4da;
  box-shadow: none;
}

/deep/.custom-file-label {
  padding: 7px 20px;
  text-align: left;
  color: #C5CBD4;
  &:after {
    width: 50px;
    height: auto;
    padding: 7px 10px;
    font-size: 18px;
    color: #fff;
    border-left: none;
    background: #cd1515 url("~assets/img/icon-file.svg") no-repeat 50% 45%;
  }
}
</style>