<template lang="pug">
  .notifications-list--item(@click.prevent)
    .left
      .user-avatar
        img(:src="item.user.avatar")
      .user-action
        span.date {{ item.created_at }}
        p
          strong.user-name {{ item.user.user_name }}
          span(v-html="item.comment")
    router-link.btn.btn__small.btn__transparent( :to="{name: item.button.route, params: item.button.query, query: item.button.query }" )
      span {{item.button.text}}
</template>

<script>
export default {
  props: ['item'],
}
</script>
