<template lang="pug">
  .container.mt-5
    .row
      .col-xl-3.col-lg-4
        Aside(v-on:update="update")
      .col-xl-9.col-lg-8
        SearchBar(:placeholder="translate('common.search_' + activeType)" type="products")
        .product-list
          .heading
            h1 {{ getH1() }}
            SortBar(:types="sortButtons" v-on:update="update" place="products")
          div(v-if="0 == items.length && !$root.isLoading")
            EmptyList
          div(v-if="offersIsActive")
            .product-item(v-for="product in items" :key="product.id")
              ProductItemOffer(:product="product")
          div(v-if="requestsIsActive")
            .product-item.product-item--request(v-for="product in items" :key="product.id")
              ProductItemRequest(:product="product")
        Pagination(v-on:update="update" :total="total" :currentPage="currentPage")
    BidPopup
    InquirePopup
    SendOffersPopup(v-if="requestsIsActive")
</template>

<script>
import Aside             from "@/components/Aside";
import SearchBar         from "@/components/SearchBar";
import DealSwitcher      from "@/components/DealSwitcher";
import SortBar           from "@/components/SortBar";
import ProductItemOffer  from "@/components/ProductItemOffer";
import ProductItemRequest  from "@/components/ProductItemRequest";
import EmptyList  from "@/components/EmptyList";
import Pagination        from "@/components/Pagination";
import BidPopup          from "@/components/BidPopup";
import SendOffersPopup     from "@/components/SendOffersPopup";
import InquirePopup from '@/components/InquirePopup';

export default {
  name: "home",
  props: ['seo'],
  components: {
    Aside,
    SearchBar,
    DealSwitcher,
    SortBar,
    DealSwitcher,
    ProductItemOffer,
    ProductItemRequest,
    Pagination,
    BidPopup,
    SendOffersPopup,
    EmptyList,
    InquirePopup
  },
  metaInfo() {
    if(this.metaTitle) {
      return {
        title: this.metaTitle,
        meta: [{
          name: 'description', content: this.metaDesc
        }]
      }
    }
  },
  methods:{
    update({page}){
      this.$router.push({ query: Object.assign({}, this.$route.query, {page: page } ) });
    },
    getH1(){
      if(this.category) {
        if (!this.category.parent_id) {
          return `${this.translate(`common.heading_${this.activeType}`)}: ${this.category.title}`
        } else {
          return this.category.title
        }
      } else {
        return this.translate(`common.heading_${this.activeType}`)
      }
    },
    processQuery(route){
      let query = route.query
      let filters = {}
      let page = 1
      if(Object.entries(query).length){
        if(query.page){
          page = parseInt(query.page) || 1
        }
        if(query.direction && query.field){
          this.$store.dispatch('products/SetSorting', {direction: query.direction, field: query.field } );
        }
        if(query.category_id){
          filters.category_id = query.category_id
        }
        if(query.filters){
          query.filters.split('&').map(function(i){
            let f = i.split('=');
            let v = f[1].split(',');
            filters[f[0]] = v.length == 1 ? v[0] : v
          })
        }
        if(query.title){
          filters.title = query.title
        }
        if(query.active){
          filters.active = query.active
        }

        if(query.ids && !Object.entries(filters).length){
          filters.ids = query.ids
        }
      }
      else{
        filters = {
          origins:[],
          permissions:[],
          payment_types:[],
          delivery:[]
        }
      }
      if(this.seo) {
        filters['category_seo'] = this.seo
      }
      this.$store.dispatch("products/SetActiveItemsType", route.meta.productType)
      this.$store.dispatch('products/SetFilters', filters );
      this.$store.dispatch('products/SetPage', page );
      this.$isLoading('isLoading', 'items');
      this.$store.dispatch('products/List',{});
    }
  },
  watch: {
    '$route'(val) {
      this.processQuery(val)
    }
  },
  computed:{
    total(){
      return this.$store.getters['products/getTotal'];
    },
    activeType(){
      return this.$store.getters['products/getActiveItemType'];
    },
    requestsIsActive(){
      return 'requests' == this.activeType;
    },
    offersIsActive(){
      return 'offers' == this.activeType;
    },
    items(){
      return this.$store.getters['products/getItems'];
    },
    currentPage(){
      return this.$store.getters['products/getPage'];
    },
    metaTitle() {
      if(this.category) {
        return `Buy ${this.category.title} wholesale on Global Supplies`
      } else if(this.$route.meta.title) {
        return this.$route.meta.title
      } else {
        return null
      }
    },
    metaDesc() {
      if(this.category) {
        return `${this.metaTitle} | The most convenient and dynamically developing b2b platform working worldwide | Join us to find wholesale suppliers or to trade your products on a business to business wholesale`
      } else if(this.$route.meta.description) {
        return this.$route.meta.description
      } else {
        return null
      }
    },
    category() {
      const find = (items, seo) => {
        for(const item of items) {
          if(seo == item.seo) {
            return item
          }
          if(item.children.length) {
            const category = find(item.children, seo)
            if(category) {
              return category
            }
          }
        }
        return false
      }
      const id = this.seo || 0
      const category = find((this.config.categories || []), this.seo)
      return category ? category : false
    }
  },
  mounted() {
    if(!window.gon.config.is_lighthouse){
      this.processQuery(this.$route)
    }
    
  },
  data() {
    return {
      sortButtons: [
        'updated_at',
        'rating',
        'price_from',
      ]
    }
  }
}
</script>

<style lang="scss" scoped>
.search-bar {
  @media (max-width: 991.98px) {
    display: none;
  }
}

</style>
