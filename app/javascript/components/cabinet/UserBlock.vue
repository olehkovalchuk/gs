<template lang="pug">
  .cabinet-page.user-profile.default-block
    h2 {{translate("common.my_profile")}}
    router-link(
        :to="{name: 'edit-profile'}"
        class="edit-link"
      ) {{translate("common.edit_my_info")}}
    .user-profile--info
      .user-profile--image
        img(:src='user.avatar')
      .user-profile--text
        h3 {{user.user_name}}
        span {{user.title}}
    DealButtons(:item="user")
    
    .limits(v-if="user.company")
      .row
        .col-xl-4
          h3 Account communication and publication statistics
          CompanyName(:company="user.company")
        .col-8
          .limits-list
            .limits-list--item(
              v-for="item in user.company.limits"
              :class="[{expired: item.max - item.used <= 0}, {attention: item.max - item.used == 1}]"
              )
              span.title {{item.title}}
              .scale
                .loading(:style="{ width: item.used / item.max * 100 + '%' }")
                span 
                  strong {{item.used}}
              .info-icon(v-tooltip.top="translate(item.tooltip)")
              .alert-block
                .attention_tooltip(
                  v-tooltip.top="`Used inquiries ${item.used}/${item.max}`"
                  v-show="item.max - item.used == 1"
                )
                  img(src="@/assets/img/icon-attention.svg" alt=".")
                .alert_tooltip(
                  v-tooltip.top="`Used inquiries ${item.used}/${item.max}`"
                  v-show="item.max - item.used <= 0"
                )
                  img(src="@/assets/img/icon-alert.svg" alt=".")
    ActivityChart   
</template>

<script>
import DealButtons from "@/components/cabinet/DealButtons";
import ActivityChart from "@/components/cabinet/ActivityChart";
import CompanyName from "@/components/CompanyName";

export default {
  components: {
    DealButtons,
    ActivityChart,
    CompanyName
  },
  mounted(){
    this.$isLoading('isLoading', 'item_current');
    this.$store.dispatch('users/Show', this.user.id);
  },
  computed:{
    user(){
      return this.$store.getters["users/getItemCurrent"]
    }
  },
  data() {
    return {

    }
  },
  methods: {
    submit() {
      this.socialTrack('GetMoreLimits', 'get_more_limits')
    }
  }
}
</script>

<style lang="scss" scoped>

</style>
