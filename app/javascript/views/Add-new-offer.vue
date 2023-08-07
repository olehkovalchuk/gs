<template lang="pug">
  div
    .default-block.adding-form.adding-form--offer.mt-5
      .adding-form--title
        h2 {{translate('common.add_new_offer')}}
        p
          strong {{translate('common.step')}} {{step}}
          span /{{totalSteps}}
      .adding-form--content.first(v-show="step === 1")
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
              .subtitle
                h4 {{translate("common.characteristic")}}
                div
                  input(type="checkbox" class="form-checkbox" id="is-active" v-model="item.active")
                  label(for="is-active" class="form-checkbox__label") Active?
          .row.form_row
            .col-md-6
              label.form-label {{translate('common.select_product_category')}} *
              button.btn.btn__transparent(
                @click.prevent="openCategory"
                :class="{ 'error': submited && errors.has('category') }"
              ) {{ item.category.title || translate("common.select_category")}}
              span.error-msg(v-show="submited && errors.has('category')") {{translate("common.this_field_is_requered")}}
            .col-md-6
              label.form-label {{translate('common.select_package_type')}} *
              v-select(
                class="multi-select-input"
                multiple
                :options="availablePackages"
                :placeholder="translate('common.package_type')"
                label="title" v-model="item.packages"
                v-validate="'required'"
                name="packages"
                :class="{ 'error': submited && errors.has('packages') }"
                )
              span.error-msg(v-show="submited && errors.has('packages')") {{translate("common.this_field_is_requered")}}
          .row.form_row
            .col-md-6.flex-content
              label.form-label {{translate('common.select_specification')}}
              .input_group
                InputNumber(:placeholder="translate('common.weight_from')" v-model="item.weight_from")
                .splitter
                InputNumber(:placeholder="translate('common.weight_to')" v-model="item.weight_to")
                v-select(
                  class="form-select form-select__small"
                  :options="weightMesure"
                  v-model="item.weight_type"
                  )
              .input_group
                InputNumber(:placeholder="translate('common.length_from')" v-model="item.length_from")
                .splitter
                InputNumber(:placeholder="translate('common.length_to')" v-model="item.length_to")
                .btn.btn__disabled Cm
            .col-md-6
              label.form-label {{translate('common.select_description')}}
              textarea.txtinput.description-input(:placeholder="translate('common.description')" v-model="item.description")
          .add-photo
            .add-photo--text-block
              h4 {{translate("common.upload_photo")}}
              em {{translate("common.photo_size_notice")}}
            UploadPhotoBlock(:images="product.images" v-on:update="addImage")
          .btn-block
            router-link(
              :to="{name:'cabinet-offers'}"
              class="btn btn__transparent"
            ) {{translate("common.cancel")}}
            input.btn(type="button" :value="translate('common.next')" @click.prevent="next()")
      SelectCategoryPopup(
        :items="availableCategories"
        v-model="item.category"
        v-validate="'required'"
        data-vv-name="category"
      )
      .adding-form--content.first(v-show="step === 2")
        form
          .row.form_row
            h4.col-12 {{translate("common.shipping_and_payment")}}
          .row.form_row
            .col-lg-6.col-12
              label.form-label {{translate('common.select_origin')}} *
              v-select(
                class="form-select"
                :options="config.origins"
                :placeholder="translate('common.origin_country')"
                label="title" v-model="item.origin"
                v-validate="'required'"
                name="origin"
                :class="{ 'error': submited && errors.has('origin') }"
                )
              span.error-msg(v-show="submited && errors.has('origin')") {{translate("common.this_field_is_requered")}}
            .col-lg-6.col-12
              label.form-label {{translate('common.select_delivery_conditions')}} *
              v-select(
                class="multi-select-input"
                :options="config.delivery_conditions"
                multiple
                :placeholder="translate('common.preferable_delivery')"
                label="title" v-model="item.delivery_conditions"
                v-validate="'required'"
                name="delivery_conditions"
                :class="{ 'error': submited && errors.has('delivery_conditions') }"
                )
              span.error-msg(v-show="submited && errors.has('delivery_conditions')") {{translate("common.this_field_is_requered")}}
          .row.form_row(v-if="needPermission || needPort")
            .col-lg-6.col-12(v-if="needPermission")
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
            .col-lg-6.col-12(v-if="needPort")
              label.form-label {{translate('common.select_port')}} *
              v-select(
                class="form-select"
                :options="config.ports"
                :placeholder="translate('common.choose_port')"
                label="title" v-model="item.delivery_port"
                v-validate="'required'"
                name="delivery_port"
                :class="{ 'error': submited && errors.has('delivery_port') }"
                )
              span.error-msg(v-show="submited && errors.has('delivery_port')") {{translate("common.this_field_is_requered")}}
            .col-lg-6.col-12(v-if="needPort && !needPermission || !needPort && needPermission")
              label.form-label {{translate('common.select_payment_types')}} *
              v-select(
                class="multi-select-input"
                multiple
                :options="config.payment_types"
                :placeholder="translate('common.allowed_payment_types')"
                label="title" v-model="item.payment_types"
                v-validate="'required'"
                name="payment_types"
                :class="{ 'error': submited && errors.has('payment_types') }"

                )
              span.error-msg(v-show="submited && errors.has('payment_types')") {{translate("common.this_field_is_requered")}}
          .row.form_row
            .col-lg-4.col-12
              label.form-label {{translate('common.select_quantity')}}
              InputNumber(:placeholder="translate('common.quantity_sell')" v-model="item.quantity")
              //- SelectWithInput(
              //-   :options="weightMesure"
              //-   :placeholder="translate('common.quantity_sell')"
              //-   v-model="item.weight_type"
             
              
              //-   :numbers="true"
                
              //-   )
            .col-lg-4.col-12
              label.form-label {{translate('common.select_price_from')}} *
              SelectWithInput(
                :options="config.currencies"
                :placeholder="translate('common.price_from_mt')"
                v-model="item.price_from"
                v-validate="'required'"
                data-vv-name="price_from"
                :numbers="true"
                :class="{ 'error': submited && errors.has('price_from') }"
                )
              span.error-msg(v-show="submited && errors.has('price_from')") {{translate("common.this_field_is_requered")}}
            .col-lg-4.col-12
              label.form-label {{translate('common.select_price_to')}}
              SelectWithInput(
                :options="config.currencies"
                :placeholder="translate('common.price_to_mt')"
                v-model="item.price_to"
                :numbers="true"
                :class="{ 'error': submited && errors.has('price_to') }"
                )
          .row.form_row
            .col-lg-6.col-12(v-if="!needPermission && !needPort || needPermission && needPort")
              label.form-label {{translate('common.select_payment_types')}} *
              v-select(
                class="multi-select-input"
                multiple
                :options="config.payment_types"
                :placeholder="translate('common.allowed_payment_types')"
                label="title" v-model="item.payment_types"
                v-validate="'required'"
                name="payment_types"
                :class="{ 'error': submited && errors.has('payment_types') }"

                )
              span.error-msg(v-show="submited && errors.has('payment_types')") {{translate("common.this_field_is_requered")}}
          .row.form_row
            .col-lg-6.col-12
              label.form-label {{translate('common.select_documents')}}
              v-select(
                class="multi-select-input"
                :options="availableDocuments"
                multiple
                :placeholder="translate('common.offer_documents')"
                label="title" v-model="item.documents"
                )
            .col-lg-6.col-12
              label.form-label {{translate('common.select_certificates')}}
              v-select(
                class="multi-select-input"
                :options="availableCertificates"
                multiple
                :placeholder="translate('common.certificates')"
                label="title" v-model="item.certificates"
                )
          .btn-block
            a.btn.btn__transparent(href="#" @click.prevent="prev()") {{translate("common.back")}}
            input.btn(type="submit" :value="translate('common.post_offer')" @click.prevent="submit()")
    CongratulationPopup
</template>

<script>
import InputNumber from '@/components/InputNumber';
import UploadPhotoBlock from '@/components/UploadPhotoBlock';
import AddPhotoBtn from '@/components/AddPhotoBtn';
import SelectWithInput from '@/components/SelectWithInput';
import SelectCategoryPopup from '@/components/SelectCategoryPopup';
import Treeselect from '@riophae/vue-treeselect'
import CongratulationPopup from '@/components/cabinet/CongratulationPopup';

export default {
  props: ["id"],
  components: {
    InputNumber,
    AddPhotoBtn,
    UploadPhotoBlock,
    SelectCategoryPopup,
    SelectWithInput,
    Treeselect,
    CongratulationPopup
  },
  provide() {
    return {
      $validator: this.$validator,
    }
  },
  computed: {
    needPort(){
      return this.item.delivery_conditions.some(d => d.need_seller_port);
    },
    needPermission(){
      return this.item.delivery_conditions.some(d => d.need_seller_country);
    },
    product(){
      return this.id ? this.$store.getters['products/getItemEdited'] : {}
    },
    availablePackages(){
      return this.config.packages.filter((x) => {
        return x.markets.includes(this.item.market.id)
      })
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
    getProduct(){
      if(this.id){
        this.$isLoading('isLoading', 'item_edited');
        this.$store.dispatch('products/Edit',this.id)
      }
    },
    openCategory(){
      this.$bvModal.show("select-category")
    },
    addImage(files){
      this.files = files
    },
    prev() {
      this.submited = false;
      this.step--;
    },
    next() {

      this.submited = true;
      this.validateFirstForm().then(result => {
        if(result){
          this.step++;
          this.$validator.reset()
        }
        console.log(this.errors,this.errors.has('category'))
      });
    },
    async validateFirstForm(){
      const toValidate = [
        this.$validator.validate('packages')
      ]
      if(!this.item.category.id){

        this.$validator.errors.add({ field: 'category', msg: `Category is invalid` });

        toValidate.push( this.$validator.validate('category') )
      }
      const results = Promise.all([...toValidate]);
      return (await results).every(isValid => isValid);
    },
    async validateSecondForm(){
      const toValidate = [
        this.$validator.validate('origin'),
        this.$validator.validate('delivery_conditions'),
      ]
      if(!this.item.price_from.input){
        this.$validator.errors.add({ field: 'price_from', msg: `Price is invalid` });
      }
      if(!this.item.price_from.select){
        this.$validator.errors.add({ field: 'price_from', msg: `Price is invalid` });
      }
      if(this.item.price_to.input && !this.item.price_to.select){
        this.$validator.errors.add({ field: 'price_to', msg: `Price is invalid` });
      }
      if(!this.item.payment_types.length){
        this.$validator.errors.add({ field: 'payment_types', msg: `Payment types is invalid` });
      }
      const results = Promise.all([...toValidate]);
      return (await results).every(isValid => isValid);
    },

    submit() {
      this.submited = true;
      this.validateSecondForm().then(result => {
        if(result){
          this.$isLoading('isLoading', 'item_saved');
          this.$store.dispatch('products/Save', this.getOffer()).then((response) => {
            this.submited = false;
            this.$validator.reset()
            // if there is no error go to home page
            if(response.success){
              this.socialTrack('AddOffer', 'add_offer')
              this.socialTrack('Activities')
              this.$router.push({name:'cabinet-offers'})
              this.$bvModal.show("congratulation-popup")
            }
            else{
              this.$store.dispatch('marketplace/Failure',response.message)
            }
          })
        }
      });
    },
    getNumbers: function(start,stop){
      return new Array(stop-start).fill(start).map((n,i)=>n+i);
    },
    availableMarkets(){
      return gon.config.markets;
    },
    getOffer(){
      const item = {
        id: this.item.id,
        active: this.item.active,
        delivery_port: this.item.delivery_port ? this.item.delivery_port.code : null,
        category_id: this.item.category.id,
        plant_number: this.item.plant_number,
        weight_from: Number(this.item.weight_from),
        weight_to: Number(this.item.weight_to),
        length_from: Number(this.item.length_from),
        length_to: Number(this.item.length_to),
        weight_type: this.item.weight_type,
        length_type: "CM",
        certificates: this.item.certificates.map(d => d.id),
        payment_types: this.item.payment_types.map(d => d.id),
        permissions_to: this.item.permissions_to,
        delivery_conditions: this.item.delivery_conditions.map(d => d.id),
        packages: this.item.packages.map(d => d.id),
        documents: this.item.documents.map(d => d.id),
        currency: this.item.price_from.select,
        price_from: Number(this.item.price_from.input),
        price_to: Number(this.item.price_to.input),
        origin: this.item.origin.code,
        description: this.item.description,
        quantity: this.item.quantity || 0,
        market_param: this.item.market.id,
        // week_to: this.item.week_to,
      }
      const files = Object.values(this.files).filter(function(item) {
          return item !== null && item !== undefined;
      })
      if(files.length){
        item['files'] = files
      }
      return item
    }
  },
  data() {
    return {
      item:{
        market: {id: 'meat', title: 'Meat'},
        id: null,
        active: true,
        category: {},
        certificates: [],
        delivery_conditions: [],
        documents: [],
        packages: [],
        payment_types: [],
        permissions_to: [],
        images: {},
        description: null,
        length_from: null,
        length_to: null,
        length_type: null,
        origin: null,
        plant_number: null,
        price_from: {
          input: null,
          select: "USD",
        },
        price_to: {
          input: null,
          select: "USD"
        },
        quantity: null,
        week_from: null,
        week_to: null,
        weight_from: null,
        weight_to: null,
        weight_type: "KG",
        delivery_port: null,
      },
      submited: false,
      files:[],
      step:1,
      totalSteps: 2,
      weightMesure: ['gr', 'KG', 'LB', 'T']
    }
  },
  created() {
    this.$validator.reset()
    this.$nextTick(() => {
      this.getProduct()
      this.$validator.attach({ name: "category", rules: "required" });
      this.$validator.attach({ name: "price_from", rules: "required" });
    })
  },


  watch: {
    product(val){
      if(val){
        this.item = val
      }
    },
    'item.category'(val){
      if(val){
        this.errors.remove('category');
      }
    },
    'item.market'(val, old){
      console.log(val, old)
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
  .second .input_group {
    .form-select {
      flex: 1;
    }
  }
</style>


