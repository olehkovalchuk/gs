<template lang="pug">
.finish-process
  .scale
    span {{translate('common.finish')}}
  .finish-process--text
    p {{translate('common.bp_finished')}}
    .btn-block
      button.btn.btn__transparent.btn__small(@click.prevent="feedback") {{translate('common.leave_feedback')}}
      router-link.btn.btn__small(:to="{name:'marketplace'}") {{translate('common.go_to_find_new_one')}}
</template>

<script>
export default {
  methods:{
    feedback(){
      this.$bvModal.show("feedback-popup")
    }
  }
}
</script>

<style lang="css" scoped>
</style>
