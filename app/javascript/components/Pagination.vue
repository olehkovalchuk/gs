<template lang="pug">
  .pagination-block(v-if="total > 1")
    v-pagination(
      v-model="currentPage"
      :labels="{first: false, last: false}"
      :page-count="total"
    )
    .go-to-page(v-if="!type")
      span {{translate('common.go_to_page')}}:
      .input-block
        input.txtinput(type="number" v-model="newPage")
        button.btn(@click="jumpToPage") {{translate('common.go')}}
</template>

<script>
import vPagination from 'vue-plain-pagination'
  export default {
    props: ['total','currentPage','type'],
    components: {
      vPagination
    },
    data() {
      return {
        newPage: undefined,
      }
    },
    methods: {
      jumpToPage: function() {
        if(this.newPage){
          this.currentPage = parseInt(this.newPage);
        }
      }
    },
    watch: {
      currentPage: {
        handler(val){
          this.$emit("update", {type:this.type, page:val})
        }
      }
    }
  }
</script>
