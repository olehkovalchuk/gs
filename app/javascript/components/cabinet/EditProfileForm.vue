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
          label.form-label {{translate('common.enter_first_name')}} *
          input.txtinput(
            type="text"
            :placeholder="translate('common.first_name')"
            name="first_name"
            v-model="edited.first_name"
            v-validate="'required|min:3'"
            :class="{ 'error': submited && errors.has('first_name') }"
            )
          span.error-msg(v-show="submited && errors.has('first_name')") {{translate("common.this_field_is_requered")}}
        .col-12.col-xl-6
          label.form-label {{translate('common.enter_last_name')}} *
          input.txtinput(
            type="text"
            :placeholder="translate('common.last_name')"
            name="last_name"
            v-model="edited.last_name"
            v-validate="'required|min:3'"
            :class="{ 'error': submited && errors.has('last_name') }"
            )
          span.error-msg(v-show="submited && errors.has('last_name')") {{translate("common.this_field_is_requered")}}
      .row
        .col-12.col-xl-6
          label.form-label {{translate('common.enter_email')}} *
          input.txtinput(
            type="email"
            :placeholder="translate('common.email')"
            name="email"
            v-model="edited.email"
            v-validate="'required|email'"
            :class="{ 'error': submited && errors.has('email') }"
            )
          span.error-msg(v-show="submited && errors.has('email')") {{translate("common.this_field_is_requered")}}
        .col-12.col-xl-6
          label.form-label {{translate('common.enter_phone_number')}} *
          vue-phone-number-input(
            v-model='phone_number'
            v-bind='telProps'
            @update="onUpdate"
            :class="{ 'error': submited && errors.has('phone') }"
            ref="phoneInput"
            )
          span.error-msg(v-show="submited && errors.has('phone')") {{translate("common.this_field_is_requered")}}
      .row
        .col-12.col-xl-6
          label.form-label {{translate('common.enter_position')}} 
          input.txtinput(
            type="text"
            :placeholder="translate('common.position')"
            name="title"
            v-model="edited.title"
            v-validate="'required|min:5'"
            :class="{ 'error': submited && errors.has('title') }"
            )

      .btn-block
        button.btn.btn__grey(@click.prevent="cancell()") {{translate("common.cancel")}}
        button.btn(@click.prevent="submit") {{translate("common.save")}}
</template>

<script>
export default {
  props:["id","endpoint"],
  data() {
    return {
      submited: false,
      phone_number: null,
      telProps: {
        'required': true,
        'default-country-code': gon.config.country,
        'preferred-countries': [gon.config.country],
        'valid-color': 'green',
        'error': false,
        // translations:{
        //   countrySelectorLabel: '',
        //   countrySelectorError: '',
        //   phoneNumberLabel: '',
        //   example: '',
        // }

      },
      userImage: '/avatar.png'
    }
  },
  computed:{
    edited: {
      get(){
        return this.$store.getters['users/getItemEdited'];
      },
      set(){
        this.$store.dispatch('users/SetEdit', {} )
      }
      
    }
  },
  created(){
    if('add-member' != this.$route.name){
      this.getItem()
    }
    else{
      this.edited = {}
    }

  },
  watch: { '$route': 'getItem' },
  methods: {
    getItem(){
      this.edited = {}
      this.$isLoading('isLoading', 'item_edited');
      this.$store.dispatch('users/Edit',(this.id || this.user.id) ).then(response => {
        if(response.success){
          if(this.edited.avatar){
            this.userImage = this.edited.avatar
            this.phone_number = this.edited.phone_number
            this.telProps['default-country-code'] = this.edited.country_code
          }
        }
        else{
          this.$store.dispatch('marketplace/Failure',response.message)
        }
      })
    },
    async validateUserForm(){
      const toValidate = [
        this.$validator.validate('first_name'),
        this.$validator.validate('last_name'),
        // this.$validator.validate('email'),
        this.$validator.validate('title')
      ]
      // if(!this.select.input){
      //   toValidate.push( this.$validator.validate('price') )
      // }
      const results = Promise.all([...toValidate]);
      return (await results).every(isValid => isValid);
    },
    cancell(){
      this.$router.push({name: this.endpoint || "cabinet"})
    },
    submit (e) {
      this.submited = true;
      this.validateUserForm().then((result) => {
        if(result){
          this.$isLoading('isLoading', 'item_saved');
          this.$store.dispatch('users/Save', this.getUser() ).then(response => {
            if(response.success){
              this.cancell()
              this.$store.dispatch('marketplace/Success', this.translate("common.success_saved") )
            }
            else{
              this.$store.dispatch('marketplace/Failure',response.message)
            }
          })

        }
      })

    },
    getUser(){
      return {
        id: this.edited.id,
        country_code: this.edited.country_code,
        phone: this.edited.phone,
        phone_number: this.edited.phone_number,
        first_name: this.edited.first_name,
        last_name: this.edited.last_name,
        title: this.edited.title,
        email: this.edited.email,
        file: this.edited.file,
      }
    },
    onUpdate (e){

      if(e.phoneNumber && e.phoneNumber.includes('+')){

        let country = this.$refs.phoneInput.codesCountries.find( country => country.dialCode === e.formattedNumber.replace(e.nationalNumber, "").replace("+", "") );
        e.countryCode = country.iso2
      }


      this.edited.country_code = e.countryCode
      this.edited.phone = e.formattedNumber
      this.edited.phone_number = e.nationalNumber
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
</style>
