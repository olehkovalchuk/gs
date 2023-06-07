<template lang="pug">
div
  .user-name
    .user-name--icon
      img(:src="item.avatar")
    ul.user-name--text
      li.name(v-if="item.user_name") {{item.user_name}}
      li.name(v-if="!item.user_name") {{ item.first_name + ' ' + item.last_name }}
      li.user-position(v-if="item.title")
        | {{ item.title }}
      li.user-contact(v-if="item.email")
        strong Email:
        |  {{ item.email }}
      li.user-contact(v-if="item.phone")
        strong Phone:
        |  {{ item.phone }}
</template>

<script>
export default {
  props: ['item'],
}
</script>

<style lang="scss" scoped>
.user-name {
  display: flex;
  &--icon {
    display: flex;
    align-items: center;
    width: 50px;
    height: 50px;
    overflow: hidden;
    flex-shrink: 0;
    border-radius: 50%;
    border: 1px solid #f1f1f1;
    img {
      width: 100%;
      height: auto;
    }
  }
  &--text {
    margin-left: 15px;
  }
}
</style>
