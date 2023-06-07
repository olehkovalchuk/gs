<template lang="pug">
  .side-nav
    CabinetSideNavItem(
      :item="item"
      :key="item.name"
      v-for="item in cabinetNavList()"
    )
    .side-nav--btn-block
      router-link(
        :to="{name: 'add-new-offer'}"
        class="btn"
        ) {{translate("common.add_new_offer")}}
      router-link(
        :to="{name: 'add-new-request'}"
        class="btn"
        ) {{translate("common.add_new_request")}}
</template>

<script>
import CabinetSideNavItem from '@/components/cabinet/CabinetSideNavItem';
import MessageCounter from '@/components/MessageCounter';
export default {
  components: {
    CabinetSideNavItem,
    MessageCounter
  },
  methods:{
    cabinetNavList(){
      const menuList = [
        {
          name: this.translate("common.my_information"),
          icon: 'icon-user',
          children: [
            { name: this.translate("common.my_profile"), path: 'cabinet' },
            { name: this.translate("common.my_offers"), path: 'cabinet-offers' },
            { name: this.translate("common.my_requests"), path: 'cabinet-requests' },
            { name: this.translate("common.my_bids"), path: 'cabinet-bids' },
            { name: this.translate("common.my_invoices"), path: 'cabinet-invoices' },
            { name: this.translate("common.my_transactions"), path: 'cabinet-transactions' },
            { name: this.translate("common.my_processes") , path: 'cabinet-processes' },
          ]
        },
        {
          name: this.translate("common.inbox"),
          icon: 'icon-bell',
          children: [
            { name: this.translate("common.chats"), path: 'cabinet-chats' },
            { name: this.translate("common.notifications"), path: 'cabinet-notifications' }
          ]
        }
      ]
      if(this.user.is_company_owner || true){
        menuList.push({
          name: this.translate("common.company_information"),
          icon: 'icon-company',
          children: [
            { name: this.translate("common.company_profile"), path: 'cabinet-company' },
            { name: this.translate("common.heading_offers"), path: 'cabinet-company-offers' },
            { name: this.translate("common.heading_request"), path: 'cabinet-company-requests' },
            { name: this.translate("common.bids"), path: 'cabinet-company-bids' },
            { name: this.translate("common.invoices"), path: 'cabinet-company-invoices' },
            { name: this.translate("common.transactions"), path: 'cabinet-company-transactions' },
            { name: this.translate("common.all_processes") , path: 'cabinet-company-process' },
            { name: this.translate("common.team_members"), path: 'cabinet-members' },
          ]
        })
      }

      return menuList
    }
  }
}
</script>

<style lang="scss" scoped>
  .side-nav {
    margin-bottom: 20px;
    &--btn-block {
      margin-top: 10px;
      padding: 20px;
      border-top: 1px solid #F6F7F9;
      .btn {
        margin-bottom: 10px;
        &:last-child {
          margin: 0;
        }
      }
    }
    .message-counter {
      top: calc(50% - 10px);
      right: 17px;
    }
  }
</style>
