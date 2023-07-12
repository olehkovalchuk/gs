<template lang="pug">
  footer.footer
    .container.footer--container
      ToTopBtn
      .row.footer--top
        .col-xl-3.col-lg-3.col-sm-6
          NavMenu
          ExternalLinks
        .col-xl-3.col-lg-3.col-sm-6
          ul.contacts
            li.contacts--item.address 67G Chornovola avenue, Lviv, Ukraine, 79058
            li.contacts--item.phone
              a(href="tel:+380673741103" target="_blank") +38 (067) 374 11 03
            li.contacts--item.mail
              a(href="mailto:info@globsupplies.com" target="_blank") info@globsupplies.com
            li.contacts--item.skype
              a(href="skype:live:.cid.bff6d787f85f7c83" target="_blank" @click="trackMesssenger") Global Supplies
            li.contacts--item.wechat
              a(href="#" target="_blank" @click.prevent="showPopup") WeChat
            li.contacts--item.whatsapp
              a(href="https://wa.me/380636338244" target="_blank" @click="trackMesssenger") WhatsApp 
            li.contacts--item.viber
              a(href="viber://chat/?number=%2B380686167726" target="_blank" @click="trackMesssenger") Viber
            li.contacts--item.telegram
              a(href="https://t.me/Global_Supplies" target="_blank" @click="trackMesssenger") Telegram
        .col-xl-6.col-lg-6.col-sm-12
          form.footer--contact-form
            span.h2 {{translate("common.contact_us")}}
            .row
              .col-sm-6.col-12.flex-content
                input.txtinput(
                  type="text"
                  :placeholder="translate('common.your_name')"
                  name="name"
                  v-model="contact.name"
                  v-validate="'required|min:2'"
                  :class="{ 'error': submited && errors.has('name') }"
                  )
                input.txtinput(
                  type="email"
                  :placeholder="translate('common.your_email')"
                  v-model="contact.email"
                  v-validate="'required|email'"
                  name="email"
                  :class="{ 'error': submited && errors.has('email') }"
                  )
              .col-sm-6.col-12
                textarea.txtinput(
                  :placeholder="translate('common.your_message')"
                  v-model="contact.text"
                  v-validate="'required|min:2'"
                  name="text"
                  :class="{ 'error': submited && errors.has('text') }"
                  )
            .footer--contact-form--btn-block
              input.btn(type="submit" :value="translate('common.send')" @click.prevent="submit")
      .mobile-external-links
        ExternalLinks
      .footer--bottom
        p 2020 All rights reserved
        p Developed by:
          a(rel="nofollow" href="https://beone.software" target="_blank") BeOne Software
    WechatPopup
</template>

<script>
import NavMenu from "@/components/NavMenu";
import ExternalLinks from "@/components/ExternalLinks";
import ToTopBtn from "@/components/ToTopBtn";
import WechatPopup from "@/components/WechatPopup";
export default {
  components: {
    NavMenu,
    ExternalLinks,
    ToTopBtn,
    WechatPopup
  },
  methods:{
    showPopup() {
      this.socialTrack('StartConversation', 'start_conversation')
      this.$bvModal.show("wechat-popup")
    },
    trackMesssenger() {
      this.socialTrack('StartConversation', 'start_conversation')
    },
    submit(){
      this.submited = true;
      this.$validator.validateAll().then((result) => {
        if(result){
          this.$isLoading('isLoading', 'contact_saved');
          this.$store.dispatch('marketplace/Contact', this.contact ).then(response => {
            if(response.success){
              this.socialTrack('Contact', 'contact')

              this.contact = {
                email: null,
                text: null,
                name: null,
              }
              this.$store.dispatch('marketplace/Success', response.message )
            }
          })
        }
      })
    }
  },
  data() {
    return {
      submited: false,
      contact:{
        email: null,
        text: null,
        name: null
      }

    }
  }
}
</script>

<style lang="scss" scoped>
  .h2 {
    margin: 0;
  }
  .footer--contact-form .h2 {
    margin-bottom: 25px;
    font-size: 22px;
    font-weight: 700;
    display: block;
  }
</style>
