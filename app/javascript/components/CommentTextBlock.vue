<template lang="pug">
  .comment-text-block {{comment}}
</template>

<script>
export default {
  props:["comment"]
}
</script>

<style lang="scss">
.comment-text-block {
  display: flex;
  align-items: center;
  min-height: 80px;
  padding: 0 14px;
  font-size: 12px;
  color: #969BA2;
  font-style: italic;
  background: #F6F7F9;
  border-radius: 5px;
}
</style>
