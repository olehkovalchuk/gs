<template lang="pug">
  b-modal(
    :title="translate(titleKey)"
    id="register-popup"
    centered
    :dialog-class="cls"
    content-class="popup-default--content"
    header-class="popup-default--header"
    body-class="popup-default--body"
    hide-footer
    ref="registerModalRef"
    )
    .auth-form(v-if="'login' == activeAuth")
      LoginForm(v-on:closePopup="close")
    .auth-form(v-if="'register' == activeAuth")
      RegisterForm(v-on:closePopup="close")
    .auth-form(v-if="'restore' == activeAuth")
      RestoreForm(v-on:closePopup="close")
</template>

<script>
import LoginForm from '@/components/LoginForm';
import RegisterForm from '@/components/RegisterForm';
import RestoreForm from '@/components/RestoreForm';

export default {
  components: {
    LoginForm,
    RegisterForm,
    RestoreForm
  },
  methods:{
    close(){
      this.$refs.registerModalRef.hide()
    },
  },
  computed: {
    activeAuth(){
      return this.$store.getters['account/getAuth'];
    },
    titleKey(){
      return 'common.' + this.activeAuth;
    },
    cls(){
      let cls = ["popup-default"]
      if('register'!=this.activeAuth){
        cls.push("popup-default--small")
      }
      return cls.join(" ")
    }
  },
  data() {
    return {}
  }
}
</script>
