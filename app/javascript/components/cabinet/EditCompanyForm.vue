<template lang="pug">
  form.edit-profile(@submit.prevent="submit")
    .edit-profile--photo
      img(:src="userImage")
      .change-photo-btn
        input(type="file" @change="onFileChange")
        svg-icon(name="icon-camera" class="change-photo-btn--icon")
        span {{translate("common.change_photo")}}
    .edit-profile--info
      .row
        .col-12.col-xl-6
          label.form-label {{translate('common.enter_company_role')}} *
          v-select(
            class="form-select"
            :options="config.roles"
            :placeholder="translate('common.company_info.role')"
            label="title" v-model="edited.role"
            name="role"
            v-validate="'required'"
            :class="{ 'error': submited && errors.has('role') }"
            )
          span.error-msg(v-show="submited && errors.has('role')") {{translate("common.this_field_is_requered")}}
        .col-12.col-xl-6
          label.form-label {{translate('common.enter_company_name')}} *
          input.txtinput(
            type="text"
            :placeholder="translate('common.company_info.company_name')"
            name="title"
            v-model="edited.title"
            v-validate="'required|min:3'"
            :class="{ 'error': submited && errors.has('title') }"
            )
          span.error-msg(v-show="submited && errors.has('title')") {{translate("common.this_field_is_requered")}}
      .row
        .col-12.col-xl-6
          label.form-label {{translate('common.enter_year_establishment')}} 
          v-select(
            class="form-select"
            :options="years"
            :placeholder="translate('common.company_info.year_establishment')"
            label="title" v-model="edited.year_establishment"
            name="year_establishment"
            :class="{ 'error': submited && errors.has('year_establishment') }"
            )
        .col-12.col-xl-6
          label.form-label {{translate('common.enter_total_emploees')}} 
          InputNumber(:placeholder="translate('common.company_info.total_emploees')" v-model="edited.total_emploees")
      .row
        .col-12
          label.form-label {{translate('common.enter_fabout')}} 
          textarea.txtinput.description-input(:placeholder="translate('common.company_info.about')" v-model="edited.about")
      //- Identification details
      .row
        .col-xl-4.col-12
          label.form-label {{translate('common.enter_tic')}} 
          input.txtinput(
            type="text"
            :placeholder="translate('common.company_info.tic')"
            name="tic"
            v-model="edited.tic"
            :class="{ 'error': submited && errors.has('tic') }"
            )
        .col-xl-4.col-12
          label.form-label {{translate('common.enter_vat')}} 
          input.txtinput(
            type="text"
            :placeholder="translate('common.company_info.vat')"
            name="vat"
            v-model="edited.vat"
            :class="{ 'error': submited && errors.has('vat') }"
            )
        .col-xl-4.col-12
          label.form-label {{translate('common.enter_eori')}} 
          input.txtinput(
            type="text"
            :placeholder="translate('common.company_info.eori')"
            name="eori"
            v-model="edited.eori"
            :class="{ 'error': submited && errors.has('eori') }"
            )
      //- Bank details
      .row
        .col-12.col-xl-6
          label.form-label {{translate('common.enter_bank_country')}} 
          v-select(
            class="form-select"
            :options="config.origins"
            :placeholder="translate('common.company_info.bank_country')"
            label="title" v-model="edited.bank_country"
            name="bank_country"
            :class="{ 'error': submited && errors.has('bank_country') }"
            )
        .col-12.col-xl-6
          label.form-label {{translate('common.enter_bank')}} 
          input.txtinput(
            type="text"
            :placeholder="translate('common.company_info.bank')"
            name="bank"
            v-model="edited.bank"
            :class="{ 'error': submited && errors.has('bank') }"
            )
      .row
        .col-12.col-xl-6
          label.form-label {{translate('common.enter_swift')}} 
          input.txtinput(
            type="text"
            :placeholder="translate('common.company_info.swift')"
            name="swift"
            v-model="edited.swift"
            :class="{ 'error': submited && errors.has('swift') }"
            )
        .col-12.col-xl-6
          label.form-label {{translate('common.enter_iban')}} 
          input.txtinput(
            type="text"
            :placeholder="translate('common.company_info.iban')"
            name="iban"
            v-model="edited.iban"
            :class="{ 'error': submited && errors.has('iban') }"
            )

      //- Company address
      .row
        .col-12.col-xl-6
          label.form-label {{translate('common.enter_country')}} *
          v-select(
            class="form-select"
            :options="config.origins"
            :placeholder="translate('common.company_info.country')"
            label="title" v-model="edited.country"
            name="country_code"
            v-validate="'required'"
            :class="{ 'error': submited && errors.has('country_code') }"
            )
          span.error-msg(v-show="submited && errors.has('country_code')") {{translate("common.this_field_is_requered")}}
        .col-12.col-xl-6
          label.form-label {{translate('common.enter_city')}} 
          input.txtinput(
            type="text"
            :placeholder="translate('common.company_info.city')"
            name="city"
            v-model="edited.city"
            :class="{ 'error': submited && errors.has('city') }"
            )
      .row
        .col-12.col-xl-6
          label.form-label {{translate('common.enter_address')}} 
          input.txtinput(
            type="text"
            :placeholder="translate('common.company_info.address')"
            name="address"
            v-model="edited.address"
            :class="{ 'error': submited && errors.has('address') }"
            )
        .col-12.col-xl-6
          label.form-label {{translate('common.enter_zip')}} 
          input.txtinput(
            type="text"
            :placeholder="translate('common.company_info.zip')"
            name="zip"
            v-model="edited.zip"
            :class="{ 'error': submited && errors.has('zip') }"
            )
      .row
        .col-12.col-xl-6
          label.form-label {{translate('common.enter_zip_address')}} 
          input.txtinput(
            type="text"
            :placeholder="translate('common.company_info.zip_address')"
            name="zip_address"
            v-model="edited.zip_address"
            :class="{ 'error': submited && errors.has('zip_address') }"
            )
        .col-12.col-xl-6
          label.form-label {{translate('common.enter_plant_number')}} 
          input.txtinput(
            type="text"
            :placeholder="translate('common.company_info.plant_number')"
            name="plant_number"
            v-model="edited.plant_number"
            :class="{ 'error': submited && errors.has('plant_number') }"
            )
      .row
        .col-12.col-xl-6
          label.form-label {{translate('common.select_certificates')}} 
          v-select(
            class="multi-select-input"
            :options="config.certificates"
            multiple
            :placeholder="translate('common.certificates')"
            label="title" v-model="edited.certificates"
            )
      .btn-block
        button.btn.btn__grey(@click.prevent="cancell()") {{translate("common.cancel")}}
        button.btn(@click.prevent="submit") {{translate("common.save")}}
</template>

<script>
import InputNumber from '@/components/InputNumber'

export default {
  data() {
    return {
      submited: false,
      userImage: require('@/assets/img/avatar_big.png')
    }
  },
  components:{
    InputNumber
  },
  computed:{
    edited(){
      return this.$store.getters['companies/getItemEdited']
    },
    years(){
      const currentYear = (new Date()).getFullYear();
      const range = (start, stop, step) => Array.from({ length: (stop - start) / step + 1}, (_, i) => start + (i * step));
      return range(currentYear, currentYear - 70, -1)
    }
  },
  created(){
    this.$isLoading('isLoading', 'item_edited');
    this.$store.dispatch('companies/Edit', this.user.company_id );
  },
  watch:{
    edited(val){
      if(val.logo){
        this.userImage = val.logo
      }
    }
  },
  methods: {
    cancell(){
      this.$router.push({name:"cabinet-company"})
    },
    getEdited(){
      return {
        id: this.user.company_id,
        title: this.edited.title,
        country_code: this.edited.country.code,
        role: this.edited.role.id,
        about: String(this.edited.about),
        address: String(this.edited.address),
        total_emploees: Number(this.edited.total_emploees),
        year_establishment: this.edited.year_establishment,
        plant_number: String(this.edited.plant_number),
        representative: String(this.edited.representative),
        iban: String(this.edited.iban),
        swift: String(this.edited.swift),
        tic: String(this.edited.tic),
        vat: String(this.edited.vat),
        eori: String(this.edited.eori),
        account_number: String(this.edited.account_number),
        zip: String(this.edited.zip),
        zip_address: String(this.edited.zip_address),
        bank_country: this.edited.bank_country.code,
        bank: String(this.edited.bank),
        city: String(this.edited.city),
        file: this.edited.file,
        certificates: this.edited.certificates.map(d => d.id),
      }
    },
    submit (e) {
      this.submited = true;
      this.$validator.validateAll().then((result) => {
        if(result){
          this.$isLoading('isLoading', 'update');
          this.$store.dispatch('companies/Update', this.getEdited() ).then(response => {
            if(response.success){
              this.$router.push({ name: 'cabinet-company'})
              this.$store.dispatch('marketplace/Success', this.translate("common.success_saved") )
            }
            else{
              this.$store.dispatch('marketplace/Failure',response.message)
            }
          })
        }
      })
    },
    onFileChange(e) {
      var files = e.target.files || e.dataTransfer.files;
      if (!files.length)
        return;
      this.createImage(files[0]);
    },
    createImage(file) {
      var userImage = new Image();
      var reader = new FileReader();
      var vm = this;

      reader.onload = (e) => {
        vm.userImage = e.target.result;
        this.edited.file = file
      };
      reader.readAsDataURL(file);
    },
    removeImage: function (e) {
      this.userImage = '';
    }
  }
}
</script>

<style lang="scss" scoped>
.edit-company .txtinput{
  max-width: 100%;
}
</style>
