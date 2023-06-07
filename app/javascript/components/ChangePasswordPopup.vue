<template lang="pug">
  b-modal(
    title="Create password"
    id="change-passsword-popup"
    centered
    dialog-class="popup-default popup-default--small"
    content-class="popup-default--content"
    header-class="popup-default--header"
    body-class="popup-default--body"
    hide-footer
    ref="changePasswordModal"
    )
    .auth-form
      form.register-form
        .row.form_row
          .col-12
            input.txtinput(name="password" type="password" :placeholder="translate('common.password_placeholder')" ref="password" v-model.trim="account.password" v-validate="{ required: true, min: 6 }" :class="{ 'errorr': submitted && errors.has('password') }" )
            span.error-msg(v-show="submitted && errors.has('password')") {{translate("common.you_need_to_enter_correct")}} {{translate("common.fields.password")}}
        .row.form_row
          .col-12
            input.txtinput(type="password" :placeholder="translate('common.password_confirm_placeholder')" v-model.trim="account.password_confirmation" v-validate="'required|confirmed:password'" :class="{ 'errorr': submitted && errors.has('password_confirmation') }" data-vv-as="password" name="password_confirmation"  )
            span.error-msg(v-show="submitted && errors.has('password_confirmation')") {{translate("common.you_need_to_enter_correct")}} {{translate("common.fields.password_confirmation")}}
        .btn-block
          input.btn(type="submit" @click.prevent="submit" value="Create")

</template>

<script>

export default {
  methods:{
    close(){
      this.$refs.changePasswordModal.hide()
    },
    submit (e) {
      this.submitted = true;
      this.$validator.validateAll().then((result) => {
        if(!this.errors.items.length){
          this.$isLoading('isLoading', 'change_password');
          this.$store.dispatch('users/ChangePassword', this.account ).then(response => {
            this.close()
            if(response.success){
              this.$store.dispatch('marketplace/Success', response.message )
              window.location.href = `https://globsupplies.com/marketplace/cabinet/conversations/${response.id}`
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
      submitted: false,
      account:{}
    }
  }
}
</script>
