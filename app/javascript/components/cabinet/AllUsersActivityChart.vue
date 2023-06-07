<script>
import Chart from "@/components/cabinet/Chart";
const options = {
  responsive: true,
  maintainAspectRatio: false,
  animation: {
    animateRotate: false
  }
}

export default {
  components: {
    Chart
  },
  data() {
    return {
      options,
        chartData: {
        labels: [''],
        datasets: [
          {
            backgroundColor: ['red', 'green', 'blue', 'grey'],
            data: [10, 20, 30, 40]
          }
        ]
      }
    }
  },
  computed: {
    currentDataSet () {
      return this.chartData.datasets[0].data
    }
  }
}
</script>
