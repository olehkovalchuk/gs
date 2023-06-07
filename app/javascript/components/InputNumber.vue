<template lang="pug">
  .input-number
    span.number-up.arrow-icon(@click="inputVal++")
    span.number-down.arrow-icon(@click="inputVal--")
    input.txtinput(
      :placeholder="placeholder" 
      :name="name" 
      type="number" 
      v-model="inputVal" 
      @keydown="onlyNumber" 
      :disabled="disabled"
      :class="{ 'error': submitted && errors.has(name) }"

       v-validate="validation"
       data-vv-value-path="value"
       data-vv-validate-on="input"
       :data-vv-name="name"

    )
    span.error-msg(v-show="submitted && errors.has(name)") {{translate("common.you_need_to_enter_correct")}} {{translate("common.fields." + name)}}
</template>

<script>
export default {
  inject: ['$validator'],
  props: ['placeholder','value', 'disabled', 'name', 'submitted', 'validation'],
  data() {
    return { inputVal: this.value }
  },
  watch: {
    inputVal(val) {
      this.$emit('input', val);
    },
    value(val) {
      this.inputVal = val
    }
  }
}
</script>

<style lang="scss" scoped>
</style>
