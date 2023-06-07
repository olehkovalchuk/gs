<template lang="pug">
.progress-scale
  .progress-scale--item(:class="getStepCls('new')")
    .progress-scale--text
      p {{translate('common.po_status.new')}}
      span.date {{item.created_at}}
  .progress-scale--item.negotiations(:class="getStepCls('negotiations')")
    .info-block(v-if="infoVisible")
      span.close_btn(@click.prevent="infoVisible=false")
      p {{item.step_desc}} 
    .progress-scale--text
      p {{translate('common.po_status.negotiations')}} 
  .progress-scale--item.po-signed(:class="getStepCls('sign')")
    .info-block(v-if="infoVisible")
      span.close_btn(@click.prevent="infoVisible=false")
      p {{item.step_desc}}
    .progress-scale--text
      p {{translate('common.po_status.signed')}}
    button.btn(v-if="item.ready_for_logistic" @click.prevent="next")
      svg-icon(name="icon-check" class="icon-check")


</template>

<script>
export default {
  props:["item"],
  data() {
    return {
      infoVisible: true,
      
    }
  },
  methods:{
    next(){
      this.$isLoading('isLoading', 'item_saved');
      this.$store.dispatch('processes/Sign', this.item.process_id ).then(response => {
        if(response.success){
          this.$store.dispatch('marketplace/Success', this.translate("common.success_saved") )
          this.$isLoading('isLoading', 'item');
          this.$store.dispatch('processes/Show', response.id);
        }
        else{
          this.$store.dispatch('marketplace/Failure',response.message)
        }
      })
    },
    getStepCls(type){
      switch (type) {
        case 'new':
          return this.item.process_id ? 'passed-step' : 'current-step'
        case 'negotiations':
          return 'logistic' == this.item.stage ? 'passed-step' : this.item.confirmed ? 'passed-step' : (this.item.process_id ? 'current-step' : '')  
        case 'sign':
          return 'logistic' == this.item.stage ? 'passed-step' : ( this.item.confirmed ? 'current-step' : '')
      }
    },
  }
}
</script>

<style lang="css" scoped>
</style>
