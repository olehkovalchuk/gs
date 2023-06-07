<script>
import { Doughnut } from 'vue-chartjs';
import ChartDataLabels from 'chartjs-plugin-datalabels';

export default {
  extends: Doughnut,
  props:['chart','options'],
  computed: {
    chartData() {
      return this.chart;
    }
  },
  watch: {
    chart() {
      this._chart = this.renderChart(this.chartData, this.options);
    }
  }
};
</script>
