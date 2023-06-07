<template lang="pug">
  form.register-form
    .row.form_row
      .col-12
        input.txtinput(type="email" :placeholder="translate('common.email_placeholder')" v-model.trim="login.email" v-validate="'required|email'" :class="{ 'errorr': submitted && errors.has('email') }" name="email")
        span.error-msg(v-show="submitted && errors.has('email')") {{translate("common.you_need_to_enter_correct")}} {{translate("common.fields.email")}}
    .row.form_row
      .col-12
        input.txtinput(name="password" type="password" :placeholder="translate('common.password_placeholder')" v-model.trim="login.password" v-validate="{ required: true, min: 5 }" :class="{ 'errorr': submitted && errors.has('password') }" )
        span.error-msg(v-show="submitted && errors.has('password')") {{translate("common.you_need_to_enter_correct")}} {{translate("common.fields.password")}}
        a.forgot-password(href="#" @click.prevent="showResore") {{translate('common.forgot_password')}}
    .btn-block
      input.btn(type="submit" @click.prevent="submit" :value="translate('common.login')")
      span {{translate('common.did_you_havent_account_yet')}}
      a(href="#" @click.prevent="showRegister") {{translate('common.register')}}
</template>

<script>
export default {
  data() {
    return {
      parentComponent: null,
      submitted: false,
      login: {
        email: null,
        password: null
      },
    }
  },
  methods:{
    onCaptchaExpired(e){
      console.log(e)
    },
    verifyCaptcha(e){
      console.log(e)
    },
    showResore(){
      this.$store.dispatch('account/AddItem', {type: 'auth', items: 'restore' });
    },
    showRegister(){
      this.$store.dispatch('account/AddItem', {type: 'auth', items: 'register' });
    },
    submit (e) {
      this.submitted = true;
      this.$validator.validateAll().then((result) => {
        if(result){
          this.$isLoading('isLoading', 'item_current');
          this.$store.dispatch('users/Login', {user: this.login} ).then(response => {
            this.$bvModal.hide("register-popup")
            if(response.success && this.$route.meta.reload){
              this.socialTrack('LogInSuccess', 'login_success')
              window.location.reload()
            }
          })
        }
      })

    }
  }

}


</script>

