<template lang="pug">
.chart-block
  .row
    .col-xl-6.col-lg-12.col-md-6.chart-block--item
      .chart-block--title
        h3 {{translate("common.users_activity")}}
        SortBar(v-on:update="update" chart="in")
      Chart(
        :width="230",
        :height="230",
        :chart="chartIn"
        :options="options" v-if="inData")
    .col-xl-6.col-lg-12.col-md-6.chart-block--item
      .chart-block--title
        h3 {{translate("common.your_activity")}}
        SortBar(v-on:update="update" chart="out")
      Chart(
        :width="230",
        :height="230"
        :chart="chartOut"
        :options="options" v-if="outData")
</template>
<script>
import Chart from "@/components/cabinet/Chart";
import SortBar from "@/components/cabinet/SortBar";

const options = {
  responsive: true,
  maintainAspectRatio: false,
  borderWidth: 0,
  legend: {
    position: 'right',
    labels: {
      boxWidth: 10
    }
  },
  plugins: {
    datalabels: {
      color: '#fff',
      font: {
        family: 'Roboto',
        size: 18,
        weight: 500
      }
    }
  },
}

export default {
  components: {
    Chart,
    SortBar,
  },
  computed:{
    inData(){
      return this.$store.getters['users/getUserChartIn'];
    },
    outData(){
      return this.$store.getters['users/getUserChartOut'];
    },
    chartIn(){
      return {
        labels: this.inData.labels,
        datasets: [
          {
            backgroundColor: ['#ADCAFA', '#C5E7F0', '#EB8E8E', '#FF7257', '#D7576C', '#67BBC7', '#ADCAFA'],
            data: this.inData.data,
            borderWidth: 0,
          }
        ]
      }
    },
    chartOut(){
      return {
        labels: this.outData.labels,
        datasets: [
          {
            backgroundColor: ['#ADCAFA', '#C5E7F0', '#EB8E8E', '#FF7257', '#D7576C', '#67BBC7', '#ADCAFA'],
            data: this.outData.data,
            borderWidth: 0,
          }
        ]
      }
    },
  },
  mounted(){
    this.$isLoading('isLoading', 'show');
    // this.$store.dispatch('users/Show', this.user.id);
  },
  data() {
    return {
      options
    }
  },
  methods:{
    update({period, chart}){
      this.$store.dispatch('account/LoadChart',{period: period, chart: chart});
    }
  }
}
</script>
