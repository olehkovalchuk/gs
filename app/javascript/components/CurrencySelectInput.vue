<template lang="pug">
  .currency-select-input
    input.txtinput(type="text")
    v-select(
      class="currency-select"
      v-model="defauldCurrencySelected",
      :options="config.currencies",
      :clearable="false",
      :searchable="false"
    )
</template>

<script>
export default {
  data() {
    return {
      defauldCurrencySelected: "USD",
    }
  }
}
</script>

<style lang="scss" scoped>
</style>
