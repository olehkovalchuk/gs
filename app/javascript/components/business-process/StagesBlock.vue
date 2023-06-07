<template lang="pug">
  .stages-block
    .steps
      template(v-for="(stage,i) in allowedSteps" )
        .steps--item(:class="{'active': stage==item.stage}" @click.prevent="setActiveStage(stage)")
          strong {{translate('common.stage')}} {{i + 1}}
          span {{translate('common.steps._' + i)}}
        span.arrow-icon(v-if="i < 2")
    .buttons-block
      .custom-button
        strong {{payType}}
        p {{translate("common.paymnet_terms_short")}}
        svg-icon(name="icon-dollar" class="custom-button--icon")
      .custom-button
        strong {{deliveryType}}
        p {{translate("common.delivery_short")}}
        svg-icon(name="icon-box" class="custom-button--icon")
</template>

<script>
export default {
  props:["item"],
  computed:{
    payType(){
      return this.item.payment_type ? this.item.payment_type.title : ""
    },
    deliveryType(){
      return this.item.delivery ? this.item.delivery.id : ""
    }
  },
  methods:{
    setActiveStage(stage){
      switch(item.stage){
        case 'preparation':
          return;
        break;
        case 'logistic':
          if("finished" == stage){
            return;
          }
          else{
            this.activeStage = stage;
          }
        break;
        case 'finished':
          this.activeStage = stage;
        break;
      }
    },
  },
  data(){
    return {
      activeStage: null,
      allowedSteps: ['preparation','logistic','finished'],
    }
  }
}
</script>

<style lang="css" scoped>
</style>
