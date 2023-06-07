<template lang="pug">
  div
    swiper.gallery-top(:options="swiperOptionTop", ref="swiperTop")
      swiper-slide.slide-item(v-for="(item, i) in images" :key="i")
        .swiper-zoom-container
          img(:src="item" :title="photoTitle(i)" :alt="photoTitle(i)")
      .js-gallery-btn-prev.gallery-btn.gallery-btn--mobile.gallery-btn--mobile__prev(v-show="images.length > 1" slot="button-next")
      .js-gallery-btn-next.gallery-btn.gallery-btn--mobile.gallery-btn--mobile__next(v-show="images.length > 1" slot="button-prev")
    swiper.gallery-thumbs(:options="swiperOptionThumbs", ref="swiperThumbs" v-show="images.length > 1")
      swiper-slide.slide-item(v-for="(item, i) in images" :key="i")
        .swiper-zoom-container
          img(:src="item")
      .js-gallery-btn-prev.gallery-btn.gallery-btn--thumbs.gallery-btn--thumbs__prev(v-show="images.length > 1" slot="button-next")
      .js-gallery-btn-next.gallery-btn.gallery-btn--thumbs.gallery-btn--thumbs__next(v-show="images.length > 1" slot="button-prev")
</template>

<script>
export default {
  props:['items','title'],
  data() {
    return {
      images: [],
      showSlider: false,
      swiperOptionTop: {
        //autoHeight: true,
        spaceBetween: 10,
        loop: true,
        loopedSlides: 0,
        navigation: {
          nextEl: '.js-gallery-btn-next',
          prevEl: '.js-gallery-btn-prev'
        },
        zoom: {
          maxRatio: 5,
        },
      },
      swiperOptionThumbs: {
        spaceBetween: 10,
        slidesPerView: 4,
        touchRatio: 0.2,
        loop: true,
        loopedSlides: 0,
        slideToClickedSlide: true,
        centeredSlides: true,
        navigation: {
          nextEl: '.js-gallery-btn-next',
          prevEl: '.js-gallery-btn-prev'
        }
      }
    }
  },
  watch: {
    items(val,old) {
      this.images = val
    }
  },
  methods: {
    photoTitle(index) {
      if(0 === index) {
        return this.title
      } else {
        return `${this.title} photo ${index}`
      }
    }
  },
  mounted() {
    this.$nextTick(() => {
      const swiperTop = this.$refs.swiperTop.swiper
      const swiperThumbs = this.$refs.swiperThumbs.swiper
      swiperTop.controller.control = swiperThumbs
      swiperThumbs.controller.control = swiperTop

    })
  }
}
</script>

<style lang="scss" scoped>
</style>
