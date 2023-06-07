<template lang="pug">
  form.register-form
    .row.form_row
      .col-sm-6
        input.txtinput(type="email" :placeholder="translate('common.email_placeholder')" v-model.trim="account.email" v-validate="'required|email'" :class="{ 'errorr': submitted && errors.has('email') }" name="email")
        span.error-msg(v-show="submitted && errors.has('email')") {{translate("common.you_need_to_enter_correct")}} {{translate("common.fields.email")}}
      .col-sm-6
        vue-phone-number-input(v-model='phone' v-bind="telProps" @update="onUpdate" ref="phoneInput" )
        span.error-msg(v-show="submitted && errors.has('phone')") {{translate("common.you_need_to_enter_correct")}} {{translate("common.fields.phone")}}
    .row.form_row
      .col-sm-6
        input.txtinput(name="first_name" type="text" :placeholder="translate('common.username_placeholder')" v-model.trim="account.first_name" v-validate="{ required: true }" :class="{ 'errorr': submitted && errors.has('first_name') }" )
        span.error-msg(v-show="submitted && errors.has('first_name')") {{translate("common.you_need_to_enter_correct")}} {{translate("common.fields.first_name")}}
      .col-sm-6
        input.txtinput(type="text" :placeholder="translate('common.last_name')" v-model.trim="account.last_name" v-validate="'required'" :class="{ 'errorr': submitted && errors.has('last_name') }" name="last_name"  )
        span.error-msg(v-show="submitted && errors.has('last_name')") {{translate("common.you_need_to_enter_correct")}} {{translate("common.fields.last_name")}}
    .row.form_row
      .col-sm-6
        input.txtinput(type="text" :placeholder="translate('common.company_name')" v-model.trim="account.company_name" v-validate="'required'" :class="{ 'errorr': submitted && errors.has('company_name') }" name="company_name"  )
        span.error-msg(v-show="submitted && errors.has('company_name')") {{translate("common.you_need_to_enter_correct")}} {{translate("common.fields.company_name")}}
      .col-sm-6
        v-select(
          name="role"
          class="form-select"
          v-model="role",
          :options="roles()",
          label="title"
          :clearable="false",
          :searchable="false",
          v-validate="'required'"
          :placeholder="translate('common.company_info.role')"
          :class="{ 'errorr': submitted && errors.has('role') }"
        )
        span.error-msg(v-show="submitted && errors.has('role')") {{translate("common.you_need_to_enter_correct")}} {{translate("common.fields.role")}}
    .row.form_row
      .col-sm-6
        v-select(
          name="markets"
          multiple
          class="form-select"
          v-model="markets",
          :options="availableMarkets()",
          label="title"
          :clearable="false",
          :searchable="false",
          v-validate="'required'"
          :placeholder="translate('common.sell_on_markets')"
          :class="{ 'errorr': submitted && errors.has('markets') }"
        )
        span.error-msg(v-show="submitted && errors.has('markets')") {{translate("common.you_need_to_enter_correct")}} {{translate("common.fields.markets")}}
    .row.form_row
      .col-sm-6
        input.txtinput(name="password" type="password" :placeholder="translate('common.password_placeholder')" ref="password" v-model.trim="account.password" v-validate="{ required: true, min: 6 }" :class="{ 'errorr': submitted && errors.has('password') }" )
        span.error-msg(v-show="submitted && errors.has('password')") {{translate("common.you_need_to_enter_correct")}} {{translate("common.fields.password")}}
      .col-sm-6
        input.txtinput(type="password" :placeholder="translate('common.password_confirm_placeholder')" v-model.trim="account.password_confirmation" v-validate="'required|confirmed:password'" :class="{ 'errorr': submitted && errors.has('password_confirmation') }" data-vv-as="password" name="password_confirmation"  )
        span.error-msg(v-show="submitted && errors.has('password_confirmation')") {{translate("common.you_need_to_enter_correct")}} {{translate("common.fields.password_confirmation")}}

    .form_row
      .agreement-block
        input(type="checkbox" id="agree" class="form-radio" v-model="account.agree" v-validate="'required'" name="agree")
        label(for="agree" class="form-radio--label")
          | {{ translate('common.i_agree') }}
          a(:href="staticPath('page/policy')" target="_blank")  
            | {{ translate('common.terms_and_conditions') }}
        span.error-msg(v-show="submitted && errors.has('agree')") {{translate("common.you_need_agree")}}
    .btn-block
      vue-recaptcha(
        ref="recaptcha"
        size="invisible"
        :sitekey="captchaKey"
        @verify="verifyCaptcha"
        @expired="onCaptchaExpired"
      )
        input.btn(type="submit" :value="translate('common.register')" @click.prevent="handleSubmit")
      span {{ translate('common.already_registered') }}
      a(href="#" @click.prevent="showLogin") {{ translate('common.login') }}
</template>

<script>
import logger from '@/mixins/logger';

export default {
  computed:{
    error(){
      if(this.success){
        return null;
      }
      else{
        return this.$store.getters['account/getRegister'].message;
      }
    },
    success(){
      return this.$store.getters['users/getItemCurrent'].user_name
    }
  },
  watch: {
    success (newValue, oldValue) {
      if(newValue){
        this.$emit("closePopup")
      }
    }
  },
  created(){
    this.$validator.attach({ name: "phone", rules: "required" });
  },
  methods: {
    roles(){
      return gon.config.roles;
    },
    availableMarkets(){
      return gon.config.markets;
    },
    onCaptchaExpired(e){
      this.$refs.recaptcha.reset();
    },
    verifyCaptcha(e){
      this.captcha = e
      this.handleSubmit()
    },
    showLogin(){
      this.$store.dispatch('account/AddItem', {type: 'auth', items: 'login' });
    },
    async validateForm(){
      const toValidate = [

        this.$validator.validate('first_name'),
        this.$validator.validate('last_name'),
        this.$validator.validate('company_name'),
        this.$validator.validate('password'),
        this.$validator.validate('email'),
        this.$validator.validate('password_confirmation'),

      ]

      const results = Promise.all([...toValidate]);
      return (await results).every(isValid => isValid);
    },
    handleSubmit (e) {
      if(!this.captcha){
        return
      }
      this.submitted = true;
      this.$validator.validateAll().then((result) => {
        if(this.phoneIsValid){
          this.errors.remove('phone')
        }
        if(!this.errors.items.length){
          this.$isLoading('isLoading', 'item_current');
          this.$store.dispatch('users/Register', {user: this.getAccount()}).then(response => {
            this.socialTrack('Lead', 'lead', {content_name: this.role.title})
            this.$store.dispatch('marketplace/Success',response.message, {root: true})
            window.location.href = response.redirect
          });
          this.$refs.recaptcha.reset();
        }
      })
    },
    getAccount(){
      const acc = this.account
      acc.role = this.role.id
      acc.captcha = this.captcha
      acc.markets = this.markets.map(x => x.id)
      return acc;
    },
    onUpdate(e){
      if(e.isValid){
        this.phoneIsValid = true
        this.errors.remove('phone')

        if(e.phoneNumber.includes('+')){

          let country = this.$refs.phoneInput.codesCountries.find( country => country.dialCode === e.formattedNumber.replace(e.nationalNumber, "").replace("+", "") );
          e.countryCode = country.iso2
        }

        this.account.country_code = e.countryCode
        this.account.phone = e.formattedNumber
        this.account.phone_number = e.nationalNumber

      }
      else{
        this.phoneIsValid = false
      }
      return e;
    },
  },
  data() {
    return {
      ff:null,
      fullPage: true,
      submitted: false,
      phone: null,
      captcha: null,
      role: null,
      markets: [],
      account: {
        role: 'trader',
        agree: false,
        email: null,
        password: null,
        first_name: null,
        company_name: null,
        password_confirmation: null,
        phone: null,
        country_code: gon.config.country,
        phone_number: null,
        t: null
      },
      telProps: {
        'required': true,
        'default-country-code': gon.config.country,
        'preferred-countries': [gon.config.country],
        'valid-color': 'green',
        'error': false
      }
    }
  }
}
</script>

