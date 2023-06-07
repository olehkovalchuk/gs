<template lang="pug">
  .default-block.adding-form.adding-form--offer.mt-5
    .adding-form--title
      h2 {{translate("common.add_request")}}
    .adding-form--content
      form
        .row.form_row
          .col-12
            .subtitle
              h4 {{translate("common.market")}}
            v-select(
              name="market"
              class="form-select"
              v-model="item.market",
              :options="availableMarkets()",
              label="title"
              item-value="id"
              :clearable="false",
              :searchable="false",
              v-validate="'required'"
              :placeholder="translate('common.market')"
              :class="{ 'errorr': submited && errors.has('market') }"
            )
            span.error-msg(v-show="submited && errors.has('market')") {{translate("common.you_need_to_enter_correct")}} {{translate("common.fields.market")}}
        .row.form_row
          .col-12
            input(type="checkbox" class="form-checkbox" id="is-active" v-model="item.active" )
            label(for="is-active" class="form-checkbox__label") Active?
        .row.form_row
          .col-md-6
            label.form-label {{translate('common.select_product_category')}} *
            button.btn.btn__transparent(
              @click.prevent="openCategory"
              :class="{ 'error': submited && errors.has('category') }"
            ) {{ this.item.category.title || translate("common.select_category")}}
            span.error-msg(v-show="submited && errors.has('category')") {{translate("common.this_field_is_requered")}}
          .col-md-6
            label.form-label {{translate('common.select_delivery_conditions')}}
            v-select(
              class="multi-select-input"
              :options="config.delivery_conditions"
              multiple
              :placeholder="translate('common.preferable_delivery')"
              label="title" v-model="item.delivery_conditions"
              v-validate="'required'"
              name="delivery"
              :class="{ 'error': submited && errors.has('delivery') }"
              )
            span.error-msg(v-show="submited && errors.has('delivery')") {{translate("common.this_field_is_requered")}}
        .row.form_row
          .col-md-6
            label.form-label {{translate('common.select_origin')}}
            v-select(
              class="multi-select-input"
              :options="config.origins"
              multiple
              :placeholder="translate('common.origin_country')"
              label="title" v-model="item.origins"
              v-validate="'required'"
              name="origins"
              :class="{ 'error': submited && errors.has('origins') }"
              )
            span.error-msg(v-show="submited && errors.has('origins')") {{translate("common.this_field_is_requered")}}
          .col-md-6
            label.form-label {{translate('common.select_payment_types')}}
            v-select(
              class="multi-select-input"
              multiple
              :options="config.payment_types"
              :placeholder="translate('common.allowed_payment_types')"
              label="title"
              v-model="item.payment_types"
              v-validate="'required'"
              name="payment_types"
              :class="{ 'error': submited && errors.has('payment_types') }"

              )
            span.error-msg(v-show="submited && errors.has('payment_types')") {{translate("common.this_field_is_requered")}}
        .row.form_row
          .col-md-6.flex-content
            label.form-label {{translate('common.select_permissions_to')}}
            treeselect(
              :placeholder="translate('common.permissions')"
              class="multi-select-input"
              v-model="item.permissions_to"
              :multiple="true"
              label="title"
              :options="config.permissions"
              :class="{ 'error': submited && errors.has('permissions_to') }"
            )
          .col-md-6.flex-content
            label.form-label {{translate('common.select_quantity')}}
            InputNumber(:placeholder="translate('common.quantity')" v-model="item.quantity")


        .row.form_row
          .col-md-6
            label.form-label {{translate('common.select_price_from')}}
            SelectWithInput(
              :options="config.currencies"
              :placeholder="translate('common.price_from_mt')"
              v-model="item.price_from"
              :numbers="true"
              )
          .col-md-6
            label.form-label {{translate('common.select_price_to')}}
            SelectWithInput(
              :options="config.currencies"
              :placeholder="translate('common.price_to_mt')"
              v-model="item.price_to"
              :numbers="true"
              )
        .row.form_row
          .col-6
            label.form-label {{translate('common.select_documents_need')}}
            v-select(
              class="multi-select-input"
              :options="availableDocuments"
              multiple
              :placeholder="translate('common.offer_documents')"
              label="title" v-model="item.documents"
              )
          .col-6
            label.form-label {{translate('common.select_certificates')}}
            v-select(
              class="multi-select-input"
              :options="availableCertificates"
              multiple
              :placeholder="translate('common.certificates')"
              label="title" v-model="item.certificates"
              )

        .row.form_row
          .col-md-12
            label.form-label {{translate('common.select_description')}}
            textarea.txtinput.description-input(:placeholder="translate('common.description')" v-model="item.description")
        .btn-block
          router-link(
            :to="{name:'cabinet-requests'}"
            class="btn btn__transparent"
          ) {{translate("common.cancel")}}
          input.btn(type="submit" :value="translate('common.post_request')" @click.prevent="submit()")
        .agreement-block
          input(type="checkbox" id="subscribe" class="form-radio" v-model="item.subscribe" name="subscribe")
          label(for="subscribe" class="form-radio--label")
            | {{ translate('common.want_to_be_get_proposals') }}
            p {{translate('common.subscribe_for_offers')}}


    SelectCategoryPopup(
      :items="availableCategories"
      v-model="item.category"
      v-validate="'required'"
      data-vv-name="category"
    )
    CongratulationPopup
</template>

<script>
import InputNumber from '@/components/InputNumber';
import SelectWithInput from '@/components/SelectWithInput';
import SelectCategoryPopup from '@/components/SelectCategoryPopup';
import Treeselect from '@riophae/vue-treeselect'
import CongratulationPopup from '@/components/cabinet/CongratulationPopup';

export default {
  props:['id'],
  components: {
    SelectWithInput,
    SelectCategoryPopup,
    InputNumber,
    Treeselect,
    CongratulationPopup
  },
  computed: {
    product(){
      return this.id ? this.$store.getters['products/getItemEdited'] : {}
    },
    availableDocuments(){
      return this.config.documents.filter((x) => {
        return x.markets.includes(this.item.market.id)
      })
    },
    availableCertificates(){
      return this.config.certificates.filter((x) => {
        return x.markets.includes(this.item.market.id)
      })
    },
    availableCategories(){
      return this.config.categories.filter((x) => {
        return x.markets.includes(this.item.market.id)
      })
    }
  },
  methods:{
    availableMarkets(){
      return gon.config.markets;
    },
    openCategory(){
      this.$bvModal.show("select-category")
    },
    getProduct(){
      if(this.id){
        this.$isLoading('isLoading', 'item_edited');
        this.$store.dispatch('products/Edit',this.id)
      }
    },
    async validateFirstForm(){
      const toValidate = []
      if(!this.item.category.id){
        if(!this.$validator.errors.has("category")){
          this.$validator.errors.add({ field: 'category', msg: `Category is invalid` });
        }
        return false;
      }
      return true;
    },
    submit() {
      this.submited = true;
      this.validateFirstForm().then(result => {
        if(result){
          this.$isLoading('isLoading', 'item_saved');
          this.$store.dispatch('products/Save', this.getOffer()).then((response) => {
            this.submited = false;

            // if there is no error go to home page
            if(response.success){
              this.socialTrack('AddRequest', 'add_request')
              this.socialTrack('Activities')
              this.$bvModal.show("congratulation-popup")
              this.$router.push({name:'cabinet-requests'});

            }
            else{
              this.$store.dispatch('marketplace/Failure',response.message)
            }
          })
        }
      });
    },
    getOffer(){
      return {
        id: this.item.id,
        category_id: this.item.category.id,
        quantity: this.item.quantity || 0,
        active: this.item.active,
        documents: this.item.documents.map(d => d.id),
        certificates: this.item.certificates.map(d => d.id),
        payment_types: this.item.payment_types.map(d => d.id),
        permissions_to: this.item.permissions_to,
        delivery_conditions: this.item.delivery_conditions.map(d => d.id),
        origins: this.item.origins.map(d => d.code),

        currency: this.item.price_from.select,
        price_from: Number(this.item.price_from.input),
        price_to: Number(this.item.price_to.input),

        description: this.item.description,
        market_param: this.item.market.id,
      }
    }
  },
  data() {
    return {
      submited: false,
      item:{
        id: null,
        market: {id: 'meat', title: 'Meat'},
        active: true,
        category: {},
        certificates: [],
        payment_types:[],
        permissions:[],
        delivery_conditions: [],
        permissions_to: [],
        packages: [],
        documents: [],
        description: null,
        origins: [],
        quantity: null,
        price_from: {
          input: null,
          select: "USD"
        },
        price_to: {
          input: null,
          select: "USD"
        }
      }
    }
  },
  created: function () {
    this.$nextTick(function () {
      this.getProduct()
      this.$validator.attach({ name: "category", rules: "required" });
    })
  },
  watch: {
    product(val){
      if(val){
        this.item = val
      }
    },
    'item.category'(val){
      console.log(val)
      if(val){
        this.errors.remove('category');
      }
    },
    'item.price_from'(val){
      if(val){
        this.errors.remove('price_from');
      }
    }
  }
}
</script>

<style lang="scss" scoped>
.agreement-block {
  float: right;
  margin: 10px 30px;
  p{
    color: red;
    font-weight: bold;
    padding-left: 5px;
  }
}
</style>
