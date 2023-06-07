<template lang="pug">
  .bp-item.default-block
    .bp-item--title
      router-link.back(
        :to="{name: 'cabinet-processes'}"
        )
        span.arrow-icon
      h2 {{item.process_id}}
      ContextMenu(:options="context()" :item="item" v-on:click="contextClick" v-if="item.process_id")
    StagesBlock(:item="item")
    FinishProcess(v-if="'finished' == item.stage")
    LogisticsScale(:item="item" v-if="'logistic' == item.stage")
    .progress-scale-block(v-if="'preparation' == item.stage")
      .d-none.d-md-block.purchase-order__desktop(v-if="item.process_id")
        PurchaseOrder(:item="item")
      ProgressScale(:item="item")
    StartDeal(:item="item" v-if="!item.process_id")
    InfoMessage(v-if="'finished' != item.stage")
    .d-md-none.purchase-order__mobile(v-if="item.process_id")
      PurchaseOrder(:item="item" v-if="'preparation' == item.stage")
    Attachments(:item="item")
    Notifications(:notifications="item.notifications" v-if="item.process_id && item.notifications.length")
    StepPopup(v-if="'logistic' == item.stage")
    DocumentPopup(v-if="'preparation' == item.stage")
    SafeDealPopup
    FeedBackPopup
</template>

<script>
import ContextMenu from '@/components/ContextMenu';
import FeedBackPopup from '@/components/FeedBackPopup';
import StagesBlock from '@/components/business-process/StagesBlock';
import LogisticsScale from '@/components/business-process/LogisticsScale';
import PurchaseOrder from '@/components/business-process/PurchaseOrder';
import ProgressScale from '@/components/business-process/ProgressScale';
import StartDeal from '@/components/business-process/StartDeal';
import Attachments from '@/components/business-process/Attachments';
import Notifications from '@/components/business-process/Notifications';
import InfoMessage from '@/components/business-process/InfoMessage';
import FinishProcess from '@/components/business-process/FinishProcess';
import DocumentPopup from '@/components/business-process/DocumentPopup';
import StepPopup from '@/components/business-process/StepPopup';
import SafeDealPopup from '@/components/business-process/SafeDealPopup';

export default {
  props:["item"],
  components: {
    ContextMenu,
    DocumentPopup,
    StepPopup,
    StagesBlock,
    LogisticsScale,
    PurchaseOrder,
    ProgressScale,
    StartDeal,
    Attachments,
    Notifications,
    InfoMessage,
    FinishProcess,
    SafeDealPopup,
    FeedBackPopup
  },
  methods:{
    context(){
      return [
        { key: "cancell", title: this.translate("common.cancell") },
        { key: "complain", title: this.translate("common.complain") }
      ];
    },
    cancell(){

    },
    complain(){

    },
    contextClick({key,item}){
      this[key].apply(this, item)
    }
  }
}
</script>

<style lang="css" scoped>
</style>
