<template lang="pug">
.container.mt-5
  .row
    .col-xl-3.col-lg-4
      CabinetSideNav
    .col-xl-9.col-lg-8
      router-link(
        :to="{name:'cabinet-menu'}"
        class="back-btn"
        )
        span.arrow-icon
        svg-icon(
          name="icon-bell"
          class="icon-bell back-btn--icon"
        )
        | {{translate("common.chat")}} 
      .chat-block.default-block
        .chat
          .left
            .chat-block--title
              h2 {{translate("common.chat")}}
            .contact-list#infinite-list
              .contact-list--item(v-for="item in converstaions")
                router-link(
                  :to="{ name: 'cabinet-chat', params: { id: item.id }}"
                  class="contact-list--link v_line_hover_effect"
                  :class="{'active': id==item.id }"
                )
                  span.new-msg(v-if="item.has_new_messages")
                  .avatar
                    img(:src="item.company.logo")
                  .text
                    span.time {{item.updated_at}}
                    p.contact-name(v-html="item.company.title")
                    span.msg-preview {{item.last_message}}
                ContextMenu(
                  :options="options"
                  :item="item"
                  @click="contextClick"
                )
          .right(
            :class="{ active: menuShow }"
            )
            .chat-block--title
              span.back(
                @click="closeMenu"
                )
                span.arrow-icon
              CompanyName(:company="chat.company")
            .message-block
              div
                .msg(v-for="message in messages" :class="'msg--' + message.message_cls")
                  img.avatar(:src="message.logo" v-if="'received' == message.message_cls")
                  p.msg-text {{message.text}}
                    span.date {{message.created_at}}
                    span.msg-info(v-if="message.bottom_text" v-html="message.bottom_text")


            form.text-block(@submit.prevent="handleSubmit()")
              textarea(
                :placeholder="translate('common.chat_text')"
                v-model.trim="message"
                name="message"
                v-validate="{ required: true, min: 2 }"
                :disabled="!id"
                @keydown="inputHandler"
                :class="{ 'error': submitted && errors.has('message') }"
                )
              .btn-block
                .attach-file-btn
                  label(for="attach_file") {{attach_text}}
                  input(
                    type="file"
                    id="attach_file"
                    :disabled="!id"
                    @change="attach"
                    ref="file"
                    )
                button.btn(:class="{'btn__grey': !id }") Send
            p.member-restriction(v-if="true || company.rating_code == 'bronze'")
              | Sending messages with your personal information (phones, links, etc.) is not allowed and will not be delivered
              | 
              a(href="/page/policy" target="_blank") (due to PP st. 12.4)
              br
              | To remove all restrictions, change your
              | 
              a(href="/pricing" target="_blank") subscription

</template>


<style lang="scss" scoped>
</style>



<script>
import CabinetSideNav from "@/components/cabinet/CabinetSideNav";
import CompanyName from "@/components/CompanyName";
import ContextMenu from "@/components/ContextMenu";


const MAX_FILE_SIZE = 4000000;
export default {
  props:["id"],
  components: {
    CabinetSideNav,
    CompanyName,
    ContextMenu,
  },
  computed:{
    messages(){
      return this.$store.getters['messages/getMessages'];
    },
    converstaions(){
      return this.$store.getters['messages/getItems'];
    },
    chat(){
      return this.$store.getters['messages/getItem'];
    },
    page(){
      return this.$store.getters['messages/getPage'];
    }
  },

  mounted () {
    // Detect when scrolled to bottom.
    const listElm = document.querySelector('#infinite-list');
    listElm.addEventListener('scroll', e => {
      if(listElm.scrollTop + listElm.clientHeight >= listElm.scrollHeight) {
        this.load();
      }
    });
  },
  methods:{
    inputHandler(e) {
      if (e.keyCode === 13 && !e.shiftKey) {
        e.preventDefault();
        this.handleSubmit();
      }
    },
    reload(){
      
      this.$store.dispatch('messages/SetPage', 1 );
      this.loadedPages = []
      this.$store.dispatch('messages/Clear');
      this.load(1)
    },
    load (page) {
      page = page || this.page
      if( this.loadedPages.includes(page) ){
        return;
      }
      if(page == 1){
        this.$store.dispatch('messages/Clear')
      }
      this.$store.dispatch('messages/SetPage', ( this.page + 1 )  );
      setTimeout(e => {
        this.$isLoading('isLoading', 'items');
        this.loadedPages.push(this.page)
        this.$store.dispatch('messages/List');
      }, 200);
      /**************************************/
      
    },
    attach(){
      const file = this.$refs.file.files[0]
      if(!file){ return }
      if(file.size > MAX_FILE_SIZE){
        this.$store.dispatch('marketplace/Failure',this.translate("common.file_to_large_1"))
        return;
      }
      this.attach_text = file.name
      this.file = file
    },
    reset(){
      this.attach_text = this.translate("common.attach_file")
      this.file = null
      this.message = null
    },
    getMessages(){
      if(this.id){
        this.menuShow = true
        this.$isLoading('isLoading', 'messages');
        this.$store.dispatch('messages/Show', this.id);
      }
      else{
        this.menuShow = false
      }
    },
    getItem(){
      let item ={
        message: this.message,
        id: this.id
      }
      if(this.file){
        item['file'] = this.file
      }
      return item;
    },
    handleSubmit(){
      this.submitted = true

      this.$validator.validateAll().then((result) => {
        if(result){
          this.$isLoading('isLoading', 'item_updated');
          this.$store.dispatch("messages/AddMessage", this.getItem()).then(response => {
            this.submitted = false
            if(response.success){
              this.reset()
              this.getMessages()
            }
            else{
              this.$store.dispatch('marketplace/Failure',response.message)
            }
          }, error => {
            console.log(error)
          })
        }
      })


    },
    closeMenu() {
      this.$router.push({name: "cabinet-chats"})
      this.menuShow = false;
    },
    contextClick({key,item}){
      this[key].apply(this, [item])
    },
    delete(item){
      this.$isLoading('isLoading', 'item_deleted');
      this.$store.dispatch("messages/Delete", item.id).then(response => {
        this.reload();
      }, error => {
        console.log(error)
      })
    },
  },
  data() {
    return {
      loadedPages: [],
      submitted: false,
      menuShow: false,
      message: '',
      attach_text: this.translate("common.attach_file"),
      options: [
        { key: "delete", title: this.translate("common.delete") }
      ]
    }
  },
  created(){
    this.load();
    this.getMessages();
    this.reset()
  },
  watch: {
    // call again the method if the route changes
    '$route': 'getMessages'
  },

}
</script>

<style lang="scss" scoped>

.chat .contact-list--item{
  min-width: 200px;
}
.member-restriction {
  font-size: 12px;
}
</style>
