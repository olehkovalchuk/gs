<template lang="pug">
  form.register-form
    .row.form_row
      .col-12
        input.txtinput(type="email" :placeholder="translate('common.email_placeholder')" v-model.trim="item.email" v-validate="'required|email'" :class="{ 'errorr': submitted && errors.has('email') }" name="email")
        span.error-msg(v-show="submitted && errors.has('email')") {{translate("common.you_need_to_enter_correct")}} {{translate("common.fields.email")}}
    .btn-block
      vue-recaptcha(
        ref="recaptcha"
        size="invisible"
        :sitekey="captchaKey"
        @verify="verifyCaptcha"
        @expired="onCaptchaExpired"
      )
        input.btn(type="submit" @click.prevent="submit" :value="translate('common.restore')")
      a(href="#" @click.prevent="showLogin") {{ translate('common.login') }}
</template>

<script>

export default {
  data() {
    return {
      submitted: false,
      item: {
        email: null,
        captcha: null,
      },
    }
  },

  methods:{
    onCaptchaExpired(e){
      console.log(e)
    },
    verifyCaptcha(e){
      console.log(e)
      this.item.captcha = e
      this.submit()
    },
    showLogin(){
      this.$store.dispatch('account/AddItem', {type: 'auth', items: 'login' });
    },
    submit (e) {
      if(!this.item.captcha){
        return
      }
      this.submitted = true;
      this.$validator.validateAll().then((result) => {
        if(result){
          this.$isLoading('isLoading', 'remind');
          this.$store.dispatch('users/Remind', {user: this.item} ).then(response => {
            if(response.success){
              this.$store.dispatch('account/AddItem', {type: 'auth', items: 'login' });
              this.$store.dispatch('marketplace/Success', this.translate("common.check_your_email") )
            }
            else{
              this.$store.dispatch('marketplace/Failure',response.message)
            }
          })
        }
      })

    }
  }

}


</script>

