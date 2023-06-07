<template lang="pug">
  .map-page(
    :class="{ list_view: listView }"
    )
    .search-block--mobile
      button.btn.btn__icon.change-view-btn(
        @click="toggleListView"
        )
        svg-icon(
          name="icon-menu"
          class="change-view-btn--icon btn-icon"
          :class="{ active: !listView }"
          )
        svg-icon(
          name="icon-pin"
          class="change-view-btn--icon btn-icon pin-icon"
          :class="{ active: listView }"
          )
        span(
          class="change-view-btn--text"
          :class="{ active: !listView }"
          ) {{translate("common.list_view")}}
        span(
          class="change-view-btn--text"
          :class="{ active: listView }"
          ) {{translate("common.map_view")}}
      SearchBar(:placeholder="translate('common.map_search')" type="companies")
    .map-menu(:class="{ active: activeMenu }")
      button.category-btn(
        @click="toggleMenu"
        )
        | {{translate("common.categories")}}
        span.arrow-icon(
          :class="{ active: activeMenu }"
          )
      .search-block
        SearchBar(:placeholder="translate('common.map_search')" type="companies")
      .side-menu.default-block
        b-tabs(
          justified
          nav-class="trade-type"

          )
          b-tab(:title="translate('common.' + type)" :title-link-class="type" v-for="type in types"  :key="type" @click="clearCategory(type)")
            CategoryBlock(:class="type" v-on:fit="fit")
            .company-list
              CompanyItem(
                :company="company"
                :key="company.id"
                @click.native="showCompanyOffers(company.id)"
                v-for="company in companies"
                )
      .company-offer(
        :class="{ active: isActive }"
        )
        button.close(
          @click="isActive = false"
          )
          span.arrow-icon
        CompanyInfo(:company="selectedCompnay")
        .offer-list-wrapper
          h4 {{translate("common.sellers_offers")}}
          OfferList(
            :items="offers",
            hasHoverClass="true",
            hasTooltip="true")
        .btn-block
          button.btn.btn__transparent.btn__back(
            @click="isActive = false"
            ) ← {{translate("common.back_to_list")}}
          button.btn.btn__icon( @click.prevent="startChat(selectedCompnay.r_id)")
            svg-icon(name="icon-chat" class="mr-2")
            | {{translate("common.start_chat")}}
      .btn-block
        button.btn(v-b-modal.contact-popup) {{translate("common.add_my_company_to_map")}}
      .map-menu--footer
        a(v-b-modal.contact-popup href="#") {{translate("common.contact_us")}}
        span {{translate("common.all_rights_reserved")}}
    .map-block
      gmap-map(:center="center" :zoom='5' style="width: 100%; height: 100%" ref="map")
        gmapInfoWindow(
          :options="infoOptions"
          :position="infoWindowCompany.position"
          :opened="infoOpened"
          @closeclick="infoOpened=false;clicked=false"
          )
          .marker-info-block
            CompanyName(:company="infoWindowCompany")
            .product-preview(v-if="infoWindowCompany.images.length")
              img(:src="i" v-for="i in infoWindowCompany.images")
              a.read-more-link(href="#" @click.prevent="showCompanyOffers(infoWindowCompany.id)")
                | More
                span.arrow-icon
        gmap-cluster(v-for="(group, type) in markers" :class="type" :image-path="getClusterPath(type)" image-extension="svg" :key="type")
          gmap-marker(
            v-for='(m, index) in group'
            :position='m.position'
            :clickable='true'
            @click="toggleInfo(m, index)"
            @mouseover="changeMarkerHover(m, index, true)"
            @mouseout="changeMarkerHover(m, index)"
            :key='index'
            :icon="getMarkerIcon(type,m)"
            v-if="(activeType == `${type}s` || 'all' == activeType)"
          )

    ContactPopup
</template>

<script>
import SearchBar from '@/components/SearchBar';
import CategoryBlock from '@/components/map/CategoryBlock';
import CompanyName from '@/components/CompanyName';
import CompanyItem from '@/components/map/CompanyItem';

import CompanyInfo from '@/components/map/CompanyInfo';
import OfferList from '@/components/OfferList';
import ContactPopup from '@/components/ContactPopup';
export default {
  props:['id'],
  components: {
    SearchBar,
    CategoryBlock,
    CompanyName,
    CompanyInfo,
    OfferList,
    ContactPopup,
    CompanyItem
  },
  computed:{
    companies(){
      return this.$store.getters['companies/getItems'].filter(c => {
        let typeActive = `${c.role}s` == this.activeType || 'all' == this.activeType
        if(this.activeCategory.id){
          return typeActive && c.category_ids.includes(this.activeCategory.id)
        }
        return typeActive;
      });
    },
    selectedCompnay(){
      return this.$store.getters['companies/getItemCurrent'];
    },
    offers(){
      return this.$store.getters['companies/getProducts'];
    },
    activeCategory(){
      return this.$store.getters['companies/getActiveCategory'].cls || 'default';
    },
    markers(){
      return this.companies.reduce((obj, item) => {
        if(this.$store.getters['companies/getActiveCategory'].id){
          if(item.category_ids.includes(this.$store.getters['companies/getActiveCategory'].id)){
            obj[item.role] = obj[item.role] || []
            obj[item.role].push(item)
          }
        }
        else{
          obj[item.role] = obj[item.role] || []
          obj[item.role].push(item)
        }
        return obj
      }, {})
    },
    activeType(){
      return this.$store.getters['companies/getActiveType'];
    },
  },
  created(){
    this.$isLoading('isLoading', 'items');
    this.$store.dispatch('companies/List')
  },
  mounted() {

    if(this.id){
      setTimeout(() => this.showCompanyOffers(this.id), 1000);
    }
    else{
      this.$refs.map.$mapPromise.then((map) => {
        this.fit()
      });
      setTimeout(() => this.fit(), 2000);
    }

  },
  data(){
    return {
      hovered: {},
      center: {lat:49, lng:32},
      types: ['all','sellers','buyers','traders'],
      infoWindowCompany: {images:[]},
      bounds: [],
      isActive: false,
      listView: false,
      activeMenu: false,
      productType: [
        {className: "beef", icon: "icon-cow"},
        {className: "pork", icon: "icon-pork"},
        {className: "poultry", icon: "icon-chicken"},
        {className: "eggs", icon: "icon-egg"},
        {className: "other", icon: "icon-rabbit"}
      ],
      infoPosition: null,
      infoContent: null,
      infoOpened: false,
      infoOptions: {
        pixelOffset: {
          width: 0,
          height: -50
        }
      },
    }
  },
  watch: {
    activeCategory(){
      this.fit()
    },
    '$route.query'(query) {
      let filters = {}
      if(Object.entries(query).length){
        if(query.direction && query.field){
          this.$store.dispatch('companies/SetSorting', {direction: query.direction, field: query.field } );
        }
        if(query.title){
          filters.title = query.title
        }
      }
      this.$store.dispatch('companies/SetFilters', filters );
      this.$isLoading('isLoading', 'items');
      this.$store.dispatch('companies/List');
    },
    '$route.params.id'(from,id) {
      if(id){
        setTimeout(() => this.showCompanyOffers(id), 1000);
      }
    }
  },
  methods: {
    fit() {
      this.infoOpened = false;
      if(this.companies.length){
        let bounds = new google.maps.LatLngBounds();
        this.companies.forEach((marker) => {
          bounds.extend(new google.maps.LatLng(marker.position.lat, marker.position.lng));
        });
        this.$refs.map.$mapObject.fitBounds(bounds);

        if(1 == this.companies.length){
          this.$refs.map.$mapObject.setOptions({
            zoom: 5
          });
        }
      }
      else{
        this.$refs.map.$mapObject.setOptions({
          center: this.center,
          zoom: 5
        });
      }


    },
    getMarkerIcon(type,m){
      let sufix = this.hovered[m.id] ? '_hover' : '';


      return {
        url: `/markers/${type}/${this.activeCategory}${sufix}.png`,
        size: {width: 71, height: 86, f: 'px', b: 'px'},
        anchor: {x: 34, y: 60, f: 'px', b: 'px'}
      }


       
    },
    getClusterPath(type){
      return `/markers/${type}/`
    },
    showCompanyOffers(id){
      this.$isLoading('isLoading', 'item_current');
      this.$store.dispatch('companies/Show', id ).then(response => {
        if(response.success){
          this.center = response.item.position,
          this.infoWindowCompany = response.item
          this.infoOpened = true
          this.$isLoading('isLoading', 'products');
          this.$store.dispatch('companies/ClearProducts' )
          this.$store.dispatch('companies/Products', id ).then(response => {
            if(response.success){

              this.isActive = true;
            }
            else{
              this.$store.dispatch('marketplace/Failure',response.message)
            }
          })
        }
        else{
          this.$store.dispatch('marketplace/Failure',response.message)
        }
      })
    },
    clearCategory(type){
      this.$store.dispatch('companies/setActiveType', type )
      this.$store.dispatch('companies/ClearActiveCategory' )
      this.fit()
    },
    toggleMenu() {
      this.activeMenu = !this.activeMenu;
    },
    toggleListView() {
      this.listView = !this.listView;
    },
    changeInfowindow(company){
      this.infoWindowCompany = company
      this.infoPosition = company.position;
      this.infoContent = company.full_name;
      this.infoOpened = true;
    },
    toggleInfo(company, key) {
      this.clicked = true;
      this.changeInfowindow(company)
    },
    changeMarkerHover(company, key, is_hovered) {
      is_hovered = is_hovered || false
      if(is_hovered){
        this.changeInfowindow(company)
      }
      else{
        // if(!this.clicked){
        //   this.infoOpened = false;
        // }

      }
      this.hovered[company.id] = is_hovered
    }
  }
}
</script>

<style lang="scss">
.marker-info-block {
  .company-name-block {
    min-width: 300px;
    padding-bottom: 10px;
    border-bottom: 2px solid #F6F7F9;
    .company-logo {
      width: 60px;
      height: 60px;
    }
    .company-name {
      strong {
        margin-bottom: 5px;
        font-weight: bold;
        font-size: 18px;
      }
    }
  }
  .product-preview {
    display: flex;
    align-items: center;
    padding-top: 10px;
    img {
      width: 50px;
      height: 50px;
      margin: 0 6px;
    }
  }
  .read-more-link {
    .arrow-icon {
      margin-left: 2px;
      transform: rotate(-90deg);
      &:before,
      &:after {
        height: 7px;
      }
      &:after {
        right: 5px;
      }
    }
  }
}
</style>
