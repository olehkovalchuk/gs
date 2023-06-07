<template lang="pug">
  .select-with-input(:class="customClass")
    input.txtinput(
      @keydown="onlyNumber" 
      :type="getType()", 
      :placeholder="placeholder", 
      v-model='inputVal.input'
      :disabled="disabled"
      :name="name" 
      :value="inputVal.input" 
      :class="{ 'error': submitted && errors.has(name) }"
      v-validate="validation"
      data-vv-value-path="inputVal.input"
      data-vv-validate-on="input"
      :data-vv-name="name"
      )
    v-select(
      name="select"
      :disabled="disabled"
      class="currency-select"
      v-model="inputVal.select",
      :options="options",
      :clearable="false",
      :searchable="false",
      return-object
    )
</template>

<script>
export default {
  inject: ['$validator'],
  watch: {
    inputVal(val) {
      this.$emit('input', val);
    },
    value(val) {
      this.inputVal = val
    }
  },
  methods:{
    getType(){
      if(this.numbers){
        return "number"
      }
      else{
        return "text"
      }
    }
  },
  data() {
    return { inputVal: this.value }
  },
  props: [ 'options', 'customClass', 'placeholder', 'value', 'numbers' , 'disabled', 'name', 'submitted', 'validation']
}
</script>
