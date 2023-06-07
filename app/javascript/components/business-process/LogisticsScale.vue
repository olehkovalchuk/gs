<template lang="pug">
.progress-scale-block.logistics
  span.prev(@click="moveScaleDown") Previous
    span.arrow-icon
  span.next(@click="moveScaleUp") Next
    span.arrow-icon
  .progress-scale(:style="{'margin-top': scaleOffset + 'px'}")
    .progress-scale--item(v-for="step in item.steps" :class="{'passed-step': step.completed, 'current-step': step.current}")
      .progress-scale--text
        p {{step.title}}
        span.date(v-if="step.completed_at") {{step.completed_at}}
      button.btn(v-if="step.current && step.editable" @click.prevent="showStep(step)")
        svg-icon(name="icon-plus" class="icon-plus")
</template>

<script>
export default {
  props:["item"],
  data() {
    return {
      scaleOffset: 0,
    }
  },
  methods: {
    showStep(step){
      this.$isLoading('isLoading', 'current_step');
      this.$store.dispatch('processes/ShowStep', {step: step.id, id: this.item.process_id } ).then(response => {
        if(response.success){
          this.$bvModal.show("step-popup")
        }
        else{
          this.$store.dispatch('marketplace/Failure',response.message)
        }
      })
    },
    moveScaleUp: function() {
      this.scaleOffset -= 30;
    },
    moveScaleDown: function() {
      this.scaleOffset += 30;
    }
  }
}
</script>

<style lang="scss" scoped>
.prev,
.next {
  display: none;
  align-items: center;
  position: absolute;
  right: 12px;
  cursor: pointer;
  font-size: 12px;
  color: #cd1515;
  z-index: 1;
  .arrow-icon {
    margin-left: 10px;
    &:before,
    &:after {
      height: 9px;
      background: #cd1515;
    }
    &:before {
      left: 4px;
    }
  }
}
.prev {
  top: 12px;
  .arrow-icon {
    transform: rotate(180deg);
  }
}
.next {
  bottom: 12px;
}
@media (max-width: 767.98px) {
  .prev,
  .next {
    display: flex;
  }
  .logistics {
    position: relative;
    overflow: hidden;
    .progress-scale {
      display: block;
      &--item {
        height: 58px;
        &:before {
          top: 0;
        }
        .btn {
          bottom: -11px;
          z-index: 1;
        }
      }
      &--text {
        position: relative;
        top: -3px;
      }
    }
  }
}
</style>
