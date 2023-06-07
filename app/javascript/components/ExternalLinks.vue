<template lang="pug">
  ul.external-links
    li(v-for="link in links()")
      a(:href="`${link.path}`" target="_blank" rel="nofollow") {{link.title}}
</template>

<script>
export default {
  methods:{
    links(){
      return [
        {
          path: "https://eurocommerce.biz/",
          title: "Eurocommerce LTD"
        },
        {
          path: "/page/policy",
          title: "Privacy policy"
        },
        {
          path: "https://www.instagram.com/globsupplies/",
          title: "Instagram"
        },
        {
          path: "https://www.linkedin.com/company/glob-supplie/",
          title: "Linkedin"
        },
        {
          path: "https://www.facebook.com/GlobSupplies/",
          title: "Facebook"
        },
        {
          path: "https://www.youtube.com/channel/UCTj0h40no-xFHrpP_vslnHw",
          title: "Youtube"
        }

        
      ];
    }
  }
}
</script>

<style lang="scss" scoped>
  .external-links {
    margin-top: 25px;
    padding-top: 14px;
    border-top: 1px solid #C5CBD4;
    a {font-size: 14px;}
  }
</style>
