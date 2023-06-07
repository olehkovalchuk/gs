<template lang="pug">
b-modal(
  title=""
  id="order-popup"
  centered
  dialog-class="popup-default popup-default--big order-popup"
  content-class="popup-default--content"
  header-class="popup-default--header"
  body-class="popup-default--body"
  hide-footer
  )
  b-tabs(justified)
    b-tab(:title="translate('common.submit_purchage_order')" active)
      .order-popup--section
        .row
          .col-sm-6.col-lg-4.col-12
            h4 {{translate('common.po_company_info')}}
            CabinetCompanyInfo(:company="item.current_company")
          .col-sm-6.col-lg-4.col-12
            h4 {{translate('common.po_contact_person')}}
            UserName(:item="item.current_user")
          .col-sm-6.col-lg-4.col-12
            .add-person-btn(
              @click="toggle"
              :class="{active: menuShow}"
              v-if="!po.additional_contact_person.email"
              )
              span.plus-icon
              strong(v-if="!menuShow") {{translate('common.add_additional_person')}}
              strong(v-if="menuShow") {{translate('common.cancel')}}
            .new-person-block(v-if="po.additional_contact_person.email && !menuShow")
              h4 {{translate('common.po_additional_contact_person')}}
              UserName(:item="po.additional_contact_person")
              span.edit-link(@click="toggle") {{translate('common.edit_info')}}
        .add-person-form(v-if="menuShow")
          .row.form_row
            .col-12.col-md-4
              label.form-label {{translate('common.first_name')}}
              input.txtinput(
                type="text"
                v-model="person.first_name"
                name="first_name"
                v-validate="'required'"
                :class="{ 'error': submitted && errors.has('first_name') }"
                )
              span.error-msg(v-show="submitted && errors.has('first_name')") {{translate("common.you_need_to_enter_correct")}} {{translate("common.fields.first_name")}}
            .col-12.col-md-4
              label.form-label {{translate('common.email')}}
              input.txtinput(
                type="email"
                v-model="person.email"
                name="user_email"
                v-validate="'required'"
                :class="{ 'error': submitted && errors.has('user_email') }"
                )
              span.error-msg(v-show="submitted && errors.has('user_email')") {{translate("common.you_need_to_enter_correct")}} {{translate("common.fields.email")}}
            .col-12.col-md-4
              label.form-label {{translate('common.phone')}}
              vue-phone-number-input(v-model='person.phone_number' v-bind="telProps" @update="onUserPhoneUpdate" )
              span.error-msg(v-show="submitted && errors.has('user_phone')") {{translate("common.you_need_to_enter_correct")}} {{translate("common.fields.phone")}}
          .row.form_row
            .col-12.col-md-4
              label.form-label {{translate('common.last_name')}}
              input.txtinput(
                type="text"
                v-model="person.last_name"
                name="last_name"
                v-validate="'required'"
                :class="{ 'error': submitted && errors.has('last_name') }"
                )
              span.error-msg(v-show="submitted && errors.has('last_name')") {{translate("common.you_need_to_enter_correct")}} {{translate("common.fields.last_name")}}
            .col-12.col-md-4
              label.form-label {{translate('common.position')}}
              input.txtinput(
                type="text"
                v-model="person.title"
                name="person_position"
                )
            .col-12.col-md-4
              button.btn(@click="addPerson") {{translate('common.add')}}
      .order-popup--section
        h4 {{translate('common.po_company_info')}}
        .row.form_row
          .col-12.col-sm-4
            label.form-label {{translate('common.company_info.company_name')}} *
            input.txtinput(
              type="text"
              v-model="po.company.title"
              name="company_name"
              v-validate="'required'"
              :class="{ 'error': submitted && errors.has('company_name') }"
              )
            span.error-msg(v-show="submitted && errors.has('company_name')") {{translate("common.you_need_to_enter_correct")}} {{translate("common.fields.company_name")}}
          .col-12.col-sm-4
            label.form-label {{translate('common.company_info.address')}} *
            input.txtinput(
              type="text"
              v-model="po.company.address"
              name="company_address"
              v-validate="'required'"
              :class="{ 'error': submitted && errors.has('company_address') }"
              )
            span.error-msg(v-show="submitted && errors.has('company_address')") {{translate("common.you_need_to_enter_correct")}} {{translate("common.fields.address")}}
          .col-12.col-sm-4
            label.form-label {{translate('common.phone')}} *
            vue-phone-number-input(v-model='company_phone_number' v-bind="telProps" @update="onCompanyPhoneUpdate" )
            span.error-msg(v-show="submitted && errors.has('company_phone')") {{translate("common.you_need_to_enter_correct")}} {{translate("common.fields.phone")}}
        .row.form_row
          .col-12.col-sm-6
            label.form-label {{translate('common.company_info.zip_address')}}
            input.txtinput(
              type="text"
              v-model="po.company.zip_address"
              name="company_address"
              )
          .col-12.col-sm-6
            label.form-label {{translate('common.company_info.account_number')}}
            input.txtinput(
              type="text"
              v-model="po.company.account_number"
              name="company_account_number"
              )
      .order-popup--section
        h4 {{translate('common.po_goods')}}
        .product-list
          ProductName(:item="item.offer")
        .row.form_row
          .col-12.col-sm-6
            label.form-label {{translate('common.name_of_goods')}} *
            input.txtinput(
              type="text"
              v-model="po.title"
              name="title"
              :disabled="item.buyer_step"
              v-validate="'required'"
              :class="{ 'error': submitted && errors.has('title') }"
              )
            span.error-msg(v-show="submitted && errors.has('title')") {{translate("common.you_need_to_enter_correct")}} {{translate("common.fields.goods")}}
          .col-12.col-sm-6
            label.form-label {{translate('common.po_country_of_origin')}} *
            v-select(
              class="form-select"
              :options="config.origins"
              :placeholder="translate('common.origin_country')"
              label="title"
              v-validate="'required'"
              :disabled="item.buyer_step"
              v-model="po.origin"
              name="origin"
              :class="{ 'error': submitted && errors.has('origin') }"
              )
            span.error-msg(v-show="submitted && errors.has('origin')") {{translate("common.you_need_to_enter_correct")}} {{translate("common.fields.origin")}}
        .row.form_row
          .col-12.col-sm-4.col-md-3
            label.form-label {{translate('common.po_quantity')}} *
            InputNumber(:submitted="submitted" :placeholder="translate('common.po_quantity')" v-model="po.quantity" name="quantity" validation="required")

          .col-12.col-sm-4.col-md-3
            label.form-label {{translate('common.po_price')}} *
            SelectWithInput(
              :submitted="submitted"
              :options="config.currencies"
              :placeholder="translate('common.price_mt')"
              validation="required"
              name="price"
              v-model="po"
              :numbers="true"
              :disabled="item.buyer_step"
              :class="{ 'error': submitted && errors.has('price'), 'disabled': item.buyer_step }"
              customClass="red-select"
              )
            span.error-msg(v-show="submitted && errors.has('price')") {{translate("common.you_need_to_enter_correct")}} {{translate("common.fields.price")}}
          .col-12.col-sm-4.col-md-3
            label.form-label {{translate('common.po_month_of_production')}}
            v-select(
              class="form-select"
              :options="monthList"
              :placeholder="translate('common.po_month_of_production')"
              label="title"
              :disabled="item.buyer_step"
              v-model="po.month_of_production"
              name="months_of_production"
              )
          .col-12.col-sm-4.col-md-3
            label.form-label {{translate('common.package_type')}}
            v-select(
              class="form-select"
              :options="config.packages"
              :placeholder="translate('common.package_type')"
              label="title"
              v-model="po.packing"
              :disabled="item.buyer_step"
              name="packing"
              )
      .order-popup--section
        h4 {{translate('common.po_pay_title')}}
        .row
          .col-12.col-sm-6.col-md-4
            label.form-label {{translate('common.po_pay_terms')}}*
            v-select(
              class="form-select"
              :options="config.payment_types"
              :placeholder="translate('common.po_pay_terms')"
              label="title"
              v-model="po.payment_type"
              v-validate="'required'"
              name="payment_type"
              :class="{ 'error': submitted && errors.has('payment_type') }"
              )
            span.error-msg(v-show="submitted && errors.has('payment_type')") {{translate("common.you_need_to_enter_correct")}} {{translate("common.fields.payment_type")}}
          .col-3(v-if="needPaymentParts")
            label.form-label {{translate('common.po_pre_pay')}} *
            InputNumber(:submitted="submitted" :placeholder="translate('common.po_pre_pay')" v-model="po.pre_pay" name="pre_pay" validation="required")
            span.error-msg(v-show="submitted && errors.has('pre_pay')") {{translate("common.you_need_to_enter_correct")}} {{translate("common.fields.pre_pay")}}

          .col-3(v-if="needPaymentParts")
            label.form-label {{translate('common.po_post_pay')}} *
            InputNumber(:submitted="submitted" :placeholder="translate('common.po_post_pay')" v-model="po.post_pay" name="post_pay" validation="required")
            span.error-msg(v-show="submitted && errors.has('post_pay')") {{translate("common.you_need_to_enter_correct")}} {{translate("common.fields.post_pay")}}
      .order-popup--section
        h4 {{translate('common.po_delivery_title')}}
        .row.form_row
          .col-12.col-sm-4.col-md-3
            label.form-label {{translate('common.po_delivery')}} *
            v-select(
              class="form-select"
              :options="config.delivery_conditions"
              :placeholder="translate('common.po_delivery')"
              v-validate="'required'"
              name="delivery"
              label="title"
              v-model="po.delivery"
              :class="{ 'error': submitted && errors.has('delivery') }"
              )
            span.error-msg(v-show="submitted && errors.has('delivery')") {{translate("common.you_need_to_enter_correct")}} {{translate("common.fields.delivery")}}
          .col-12.col-sm-4.col-md-3(v-if="needPort")
            label.form-label {{translate('common.port_of_desination')}} *
            v-select(
              class="form-select"
              :options="config.ports"
              :placeholder="translate('common.choose_port')"
              label="title"
              v-validate="'required'"
              name="delivery_port"
              v-model="po.destination_port"
              :class="{ 'error': submitted && errors.has('delivery_port') }"
              )
            span.error-msg(v-show="submitted && errors.has('delivery_port')") {{translate("common.you_need_to_enter_correct")}} {{translate("common.fields.delivery_port")}}
          .col-12.col-sm-4.col-md-3(v-if="needSeaLine")
            label.form-label {{translate('common.shiping_lines')}} *
            v-select(
              class="form-select"
              :options="config.sea_lines"
              :placeholder="translate('common.shiping_lines')"
              label="title"
              v-model="po.sea_lines"
              v-validate="'required'"
              name="sea_lines"
              :class="{ 'error': submitted && errors.has('sea_lines') }"
              )
            span.error-msg(v-show="submitted && errors.has('sea_lines')") {{translate("common.you_need_to_enter_correct")}} {{translate("common.fields.sea_lines")}}
      .order-popup--section(v-if="item.buyer_step")
        h4 {{translate('common.po_documents')}}
        ul.document-list
          li.document-list--item(v-for="document in neededDocuments")
            input.form-checkbox(
              type="checkbox"
              v-model="po.documents[document.id]"
              :id="document.id")
            label.form-checkbox__label(
              :for="document.id"
              ) {{ document.title }}
      .order-popup--section(v-if="item.seller_step && neededAttachments.length")
        .required-docs
          h4 {{translate('common.po_documents')}}
          p.subtitle {{translate('common.po_please_upload')}}
          .attachment
            template(v-for="doc in neededAttachments")
              .attachment--item(v-if="item.attachments[doc.id]" @click.prevent="download(doc.id)")
                svg-icon(name="icon-clip" class="mr-2")
                | {{item.attachments.title}}
              .not-loaded(v-if="!item.attachments[doc.id]")
                label.attachment--item(:for="'load-file-' + doc.id" )
                  svg-icon(name="icon-clip" class="mr-2")
                  | {{doc.title}}
                input( :name="'file_' + doc.id" type="file" :id="'load-file-' + doc.id" :ref="'file_' + doc.id" @change="onFileChange($event, doc.id)")
                span.error-msg(v-show="errors.has('file_' + doc.id)") {{translate("common.you_need_to_load_documents")}}
      .order-popup--section
        h4 {{translate('common.comments')}}
        .comment-block
          .form-row
            label.form-label {{translate('common.comment')}}
            textarea.txtinput(v-model="po.comment")
      .order-popup--section(v-if="!item.confirmed")
        .btn-block
          button.btn.btn__transparent(@click.prevent="submit(true)" v-if="!item.process_id") {{translate('common.save_as_draft')}}
          button.btn.btn__transparent(@click.prevent="decline()" v-if="canBeDeclided()") {{translate('common.decline')}}
          button.btn(@click.prevent="submit(false)") {{ item.seller_step ? translate('common.confirm_po') : translate('common.submit_po')}}
        .agreement-block
          input(type="checkbox" id="is_safe" class="form-radio" v-model="item.is_safe" name="is_safe")
          label(for="is_safe" class="form-radio--label")
            | {{ translate('common.want_to_be_in_safe') }}
            p {{translate('common.start_as_safe')}}


</template>

<script>
import CabinetCompanyInfo from '@/components/cabinet/CabinetCompanyInfo';
import UserName from "@/components/UserName";
import ProductName from "@/components/ProductName";
import SelectWithInput from "@/components/SelectWithInput";
import InputNumber from "@/components/InputNumber";

export default {
  props:['item'],
  components: {
    CabinetCompanyInfo,
    UserName,
    ProductName,
    SelectWithInput,
    InputNumber
  },
  created(){
    this.po.select = this.config.default_currency
    this.$root.$on('bv::modal::show', (bvEvent, modalId) => {
      if(modalId == "order-popup"){
        this.loadPo()
      }
    })
    this.$validator.attach({ name: "company_phone", rules: "required" });
    this.$validator.attach({ name: "currency", rules: "required" });
    this.$validator.attach({ name: "price", rules: "required" });
    this.telProps['default-country-code'] = this.item.current_user.country_code
  },
  computed: {
    needPort(){
      return this.po.delivery ? this.po.delivery.need_seller_port : false;
    },
    needSeaLine(){
      return this.po.delivery ? this.po.delivery.need_sea_line : false;
    },
    needPaymentParts(){
      return this.po.payment_type ? this.po.payment_type.has_prepay : false;
    },
    neededDocuments(){
      return this.item.seller_step ? [] : (this.config.po_documents || []).filter(d=> !d.need_sign)
    },
    neededAttachments(){
      return this.item.seller_step ? (this.item.documents || []).filter(d=>d.need_before_sign) : []
    }
  },
  data() {
    return {
      personSubmited: false,
      submitted: false,
      telProps: {
        'required': true,
        'default-country-code': gon.config.country,
        'preferred-countries': [gon.config.country],
        'valid-color': 'green',
        'error': false
      },
      files: {},
      person:{
        phone_number: null,
        phone: null,
        country_code: null,
      },
      company_phone_number: '',
      po:{
        is_safe: false,
        additional_contact_person: {},
        company: {
          phone_number: null,
          phone: null,
          country_code: null,
        },
        input: null, // price
        select: null, //currency
        title: null,
        origin: null,
        month_of_production: null,
        quantity: null,
        payment_type: null,
        delivery:null,
        pre_pay: null,
        post_pay: null,
        destination_port: null,
        packing: null,
        sea_lines: null,
        documents:{},
        comment:null,
      },
      menuShow: false,
      monthList: this.$moment.months().map((m,i)=>{ return {title: m, id: (i+1) } }),
    }
  },
  methods: {
    canBeDeclided(){
      return this.item.process_id
    },
    download(id){
      window.open(`/processes/${this.item.process_id}/download?doc_id=${id}`, '_blank');
    },
    onFileChange(e, id){
      this.files[`doc_${id}`] = (e.target.files || e.dataTransfer.files)[0]
      this.errors.remove(`file_${id}`)
    },
    loadPo(){
      const loaded = {
        is_safe: this.item.is_safe,
        additional_contact_person: this.item.additional_contact_person || {},
        attachments: this.item.attachments || [],
        company: this.item.company_details,
        title: this.item.title,
        origin: this.item.origin,
        input: this.item.price,
        select: this.item.currency,
        product_id: this.item.product_id,
        quantity: this.item.quantity,
        delivery: this.item.delivery,
        payment_type: this.item.payment_type,
        packing: this.item.packing,
        documents: this.item.documents || {},
        comment: this.item.comment,
        destination_port: this.item.destination_port || null,
        sea_lines: this.item.shiping_line || null,
      }
      this.po = Object.assign({}, this.po, loaded)
      this.company_phone_number = this.po.company.phone_number
    },
    toggle() {
      this.menuShow = !this.menuShow;
    },
    getNumbers(start,stop){
      return new Array(stop-start).fill(start).map((n,i)=>n+i);
    },
    getPo(draft){
      const po = {
        is_safe: this.item.is_safe,
        draft: draft,
        product_id: this.item.offer.id,
        title: this.po.title,
        quantity: this.po.quantity,
        price: this.po.input,
        currency: this.po.select,
        origin: this.po.origin.code,
        month_of_production: this.po.month_of_production ? this.po.month_of_production.id : null,
        delivery_code: this.po.delivery.id,
        payment_type_id: this.po.payment_type.id,
        pre_pay: this.po.pre_pay,
        post_pay: this.po.post_pay,
        shiping_line: this.po.sea_lines ? this.po.sea_lines.id : null,
        destination_port: this.po.destination_port ? this.po.destination_port.code : null,
        packing: this.po.packing ? this.po.packing.id : null,
        documents: Object.keys(this.po.documents).reduce((r, e) => {
          if (this.po.documents[e]) {
            r.push(e)
          }
          return r;
        }, []),
        comment: this.po.comment || '',
        company: this.po.company,
        id: this.item.process_id,
        additional_contact_person: this.po.additional_contact_person,
      }
      if(this.item.seller_step && this.neededAttachments.length > 0){
        po['files'] = this.files
      }
      else{
        po['files'] = {}
      }
      return po;
    },

    async validateForm(){
      const toValidate = [
        this.$validator.validate('company_name'),
        this.$validator.validate('company_address'),
        this.$validator.validate('company_phone'),

        this.$validator.validate('title'),
        this.$validator.validate('origin'),
        this.$validator.validate('quantity'),

        this.$validator.validate('payment_type'),
        this.$validator.validate('delivery'),

      ]

      if(this.needPaymentParts){
        toValidate.push( this.$validator.validate('pre_pay') )
        toValidate.push( this.$validator.validate('post_pay') )
      }

      if( this.item.seller_step && this.neededAttachments.length ){
        for (var i = 0; i < this.neededAttachments.length; i++) {
          if(!this.files[`doc_${this.neededAttachments[i].id}`]){
            toValidate.push( this.$validator.validate(`file_${this.neededAttachments[i].id}`) )
          }

        }
      }

      if(this.needPort){
        if(this.po.destination_port && !this.po.destination_port.code){
          this.po.destination_port = null
        }
        toValidate.push( this.$validator.validate('delivery_port') )
      }

      if(this.needSeaLine){
        if(this.po.sea_lines && !this.po.sea_lines.id){
          this.po.sea_lines = null
        }
        toValidate.push( this.$validator.validate('sea_lines') )
      }

      if(!this.po.input){
        toValidate.push( this.$validator.validate('price') )
      }
      const results = Promise.all([...toValidate]);
      return (await results).every(isValid => isValid);
    },


    async validateUserForm(){
      const toValidate = [
        this.$validator.validate('first_name'),
        this.$validator.validate('last_name'),
        this.$validator.validate('user_email'),
        this.$validator.validate('user_phone'),
      ]
      const results = Promise.all([...toValidate]);
      return (await results).every(isValid => isValid);
    },


    submit (draft) {
      draft = draft || false
      this.submitted = true;
      this.validateForm().then((result) => {
        if(this.phoneIsValid){
          this.errors.remove('company_phone')
        }
        if(!this.errors.items.length){
          this.$isLoading('isLoading', 'item_saved');
          this.$store.dispatch('processes/Save', this.getPo(draft) ).then(response => {
            this.$bvModal.hide("order-popup")
            if(response.success){
              this.$store.dispatch('marketplace/Success', this.translate("common.success_saved") )
              this.$isLoading('isLoading', 'item');
              if(this.item.process_id){
                this.$store.dispatch('processes/Show', response.id);
              }
              else{
                this.$router.push({name:'process',params:{id:response.id}})
              }

            }
            else{
              this.$store.dispatch('marketplace/Failure',response.message)
            }
          })
        }
      })

    },
    onCompanyPhoneUpdate(e){
      this.po.company.country_code = e.countryCode
      this.po.company.phone = e.formattedNumber
      this.po.company.phone_number = e.nationalNumber
      if(e.isValid){
        this.phoneIsValid = true
        this.errors.remove('company_phone')
      }
      else{
        this.phoneIsValid = false
      }
      return e;
    },
    onUserPhoneUpdate(e){
      this.person.country_code = e.countryCode
      if(e.formattedNumber){
        this.person.phone = e.formattedNumber
      }
      if(e.nationalNumber){
        this.person.phone_number = e.nationalNumber
      }
      if(e.isValid){
        this.userPhoneIsValid = true
        this.errors.remove('user_phone')
      }
      else{
        this.userPhoneIsValid = false
      }
      return e;
    },


    addPerson(){
      this.personSubmited = true
      this.$validator.attach({ name: "user_phone", rules: "required" });
      this.validateUserForm().then((result) => {
        if(this.userPhoneIsValid){
          this.errors.remove('user_phone')
        }
        if(!this.errors.items.length){
          this.po.additional_contact_person = Object.assign({}, this.person)
          this.menuShow = false
        }
      })
    }
  },
  watch: {
    "po"(val){
      if(val){
        for (var i = 0; i < this.neededAttachments.length; i++) {
          this.$validator.attach({ name: `file_${this.neededAttachments[i].id}`, rules: "required" });
        }
      }
    },
    "po.input" (val){
      if(val){
        this.errors.remove('price');
      }
    }
  }
}
</script>

<style lang="scss" scoped>
.agreement-block {
  margin: 10px 0 0 0;
  p{
    color: red;
    font-weight: bold;
    padding-left: 5px;
  }
}
</style>
