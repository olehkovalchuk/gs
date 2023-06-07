<template lang="pug">
  .filters
    .filters--mobile-bar
      v-select(
        class="simple-select sort-select"
        v-model="sorter"
        :options="getSort()"
        :clearable="false"
        :searchable="false"
        label="title"
      )
      button.btn.btn__transparent.btn__icon(
        @click="toggleMenu"
        )
        | {{translate("common.filters")}}
        svg-icon(name="icon-filter" class="ml-2")
    //- /tablets and mobile
    .filters--wrapper(
      :class="{ active: menuShow }"
      )
      .filters--mobile-header(:class="{ active: menuShow }")
        .filters--mobile-header__top
          span.close-btn(@click="toggleMenu")
          h3.filters--mobile-header__title {{translate("common.filters")}}
          span.clear(@click.prevent="clear") {{translate("common.clear_all")}}
        .btn-block
          button.btn(@click.prevent="update") {{translate("common.apply")}}


      .filters--item
        .filters--item-header
          div(v-b-toggle.filter_item_1 variant="primary") {{ translate('common.origin') }}:
            span.collapse-icon
        b-collapse(id="filter_item_1" visible)
          .collapsed-block
            v-select(:resetOnOptionsChange="true" ref="origin" class="multi-select-input" multiple :options="items.origins" label="title" v-model="filters.origins" )
      .filters--item
        .filters--item-header
          div(v-b-toggle.filter_item_2 variant="primary") {{ translate('common.permissions') }}:
            span.collapse-icon
        b-collapse(id="filter_item_2")
          .collapsed-block
            treeselect(
              class="multi-select-input"
              v-model="filters.permissions"
              :multiple="true"
              label="title"
              :options="items.permissions"
            )

      .filters--item
        .filters--item-header
          div(v-b-toggle.filter_item_3 variant="primary") {{ translate('common.paymnet_terms') }}:
            span.collapse-icon
        b-collapse(id="filter_item_3")
          .collapsed-block
            v-select(class="multi-select-input" multiple ref="payment_types" :options="items.payment_types" :placeholder="translate('common.paymnet_terms_plc')" v-model="filters.payment_types"  label="title")
      .filters--item
        .filters--item-header
          div(href="#" v-b-toggle.filter_item_4 variant="primary") {{ translate('common.delivery') }}:
            span.collapse-icon
        b-collapse(id="filter_item_4")
          .collapsed-block
            v-select(class="multi-select-input" ref="delivery" multiple :options="items.delivery_conditions" :placeholder="translate('common.delivery_plc')" v-model="filters.delivery" label="title" )

      .filters--item
        .filters--item-header
          div(href="#" v-b-toggle.filter_item_5 variant="primary") {{translate('common.price_filter')}} :
            span.collapse-icon
        b-collapse(id="filter_item_5")
          .collapsed-block
            .price-range
              .range-input-block
                input(class="txtinput" type="number" v-model="filters.prices[0]")
                .splitter
                input(class="txtinput" type="number" v-model="filters.prices[1]")
                button.btn.btn__grey(@click="update") {{translate('common._OK')}}
              vue-slider(
                v-model="filters.prices"
                :min="min"
                :max="max"
                :enable-cross="false"
              )

      .filters--btn-block
        button.btn.btn__disabled.btn__small(@click.prevent="clear" v-if="filtered") {{translate("common.clear_all")}}
        button.btn.apply(@click.prevent="update") {{translate("common.apply")}}

</template>

<script>
import VueSlider from 'vue-slider-component';
import Treeselect from '@riophae/vue-treeselect'

export default {
  props:['items'],
  components: {
    VueSlider,
    Treeselect
  },
  // mounted(){

  //   this.filters = this.activeFilters
  //   console.log(this.filters)
  // },
  methods:{
    clear(){
      this.$router.push({ query: {} });
      this.menuShow = false;
      this.filtered = false;
      this.filters.delivery = [],
      this.filters.payment_types = [],
      this.filters.origins = [],
      this.filters.permissions = [],
      this.filters.prices = [0, 100000]
    },
    getSort(){
      return ['updated_at','rating','price_from'].map( i => {
        return { sorter: i, title: this.translate("common.sorting." + i) }
      })
    },
    update(){
      let newFilers = {}
      this.menuShow = false;
      if(this.filters.delivery.length){
        newFilers.delivery = this.filters.delivery.map(i => i.code)
      }

      if(this.filters.origins.length){
        newFilers.origins = this.filters.origins.map(i => i.code)
      }

      if(this.filters.payment_types.length){
        newFilers.payment_types = this.filters.payment_types.map(i => i.code)
      }

      if(this.filters.permissions.length){
        newFilers.permissions = this.filters.permissions
      }

      if(this.filters.prices.length && this.filters.prices.length > 0 && Number(this.filters.prices[1]) > 0){
        newFilers.prices = this.filters.prices
      }
      this.$store.dispatch('products/SetPage', 1 );
      if(Object.entries(newFilers).length){
        this.filtered = true
        newFilers = Object.keys(newFilers).map(key => key + '=' + newFilers[key]).join('&');
        this.$router.push({ query: Object.assign({}, this.$route.query, {filters: newFilers } ) });
      }
      else{
        this.filtered = false
        this.$router.push({ query: {} });
      }
    },
    toggleMenu() {
      this.menuShow = !this.menuShow;
    }
  },
  data() {
    return {
      sorter:null,
      menuShow: false,
      min: 0,
      max: 100500,
      filtered: false,
      sorter:{ sorter: 'updated_at', title: this.translate("common.sorting.updated_at") },
      filters:{
        delivery:[],
        payment_types: [],
        origins:[],
        permissions:[],
        prices: [0, 100000]
      }
    }
  },
  computed:{
    prices(){
      return this.items.prices[0] ? this.items.prices : [0, 100000];
    },
    activeFilters(){
      return this.$store.getters["products/getFilters"]
    }
  },
  'watch':{
    'activeFilters.origins'(val){
      if(this.$refs.origin && (!val || !val.length)){
        this.$refs.origin.updateValue([])
      }
    },

    'activeFilters.delivery'(val){
      if(this.$refs.delivery && (!val || !val.length)){
        this.$refs.delivery.clearSelection()
      }
    },

    'activeFilters.payment_types'(val){
      if(this.$refs.payment_types &&  (!val || !val.length)){
        this.$refs.payment_types.clearSelection()
      }
    },
    'activeFilters.permissions'(val){
      if( (!val || !val.length)){
        this.filters.permissions = []
      }
    },
    sorter(val){
      this.$router.push({ query: Object.assign({}, this.$route.query, {direction: 'ASC', field: val.sorter} ) });
    }
  }
}
</script>

<style lang="scss" scoped>
</style>
