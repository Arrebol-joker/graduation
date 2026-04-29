<template>
  <div class="dashboard">
    <el-row :gutter="20" class="dashboard-statistics">
      <el-col :span="6">
        <el-card class="statistic-card">
          <div class="statistic-content">
            <div class="statistic-icon" style="background-color: #40c9c620; color: #40c9c6">
              <el-icon><Collection/></el-icon>
            </div>
            <div class="statistic-info">
              <div class="statistic-title">非遗项目</div>
              <div class="statistic-value">{{ homeCount.heritageCount }}个</div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card class="statistic-card">
          <div class="statistic-content">
            <div class="statistic-icon" style="background-color: #34bfa320; color: #34bfa3">
              <el-icon><User/></el-icon>
            </div>
            <div class="statistic-info">
              <div class="statistic-title">传承人</div>
              <div class="statistic-value">{{ homeCount.masterCount }}名</div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card class="statistic-card">
          <div class="statistic-content">
            <div class="statistic-icon" style="background-color: #f4516c20; color: #f4516c">
              <el-icon><Document/></el-icon>
            </div>
            <div class="statistic-info">
              <div class="statistic-title">新闻资讯</div>
              <div class="statistic-value">{{ homeCount.newsCount }}篇</div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card class="statistic-card">
          <div class="statistic-content">
            <div class="statistic-icon" style="background-color: #43a04720; color: #43a047">
              <el-icon><Picture/></el-icon>
            </div>
            <div class="statistic-info">
              <div class="statistic-title">活动预告</div>
              <div class="statistic-value">{{ homeCount.eventCount }}个</div>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <el-row :gutter="20" class="dashboard-statistics">
      <el-col :span="6">
        <el-card class="statistic-card">
          <div class="statistic-content">
            <div class="statistic-icon" style="background-color: #ff980020; color: #ff9800">
              <el-icon><ChatDotRound/></el-icon>
            </div>
            <div class="statistic-info">
              <div class="statistic-title">留言反馈</div>
              <div class="statistic-value">{{ homeCount.contactCount }}条</div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card class="statistic-card">
          <div class="statistic-content">
            <div class="statistic-icon" style="background-color: #9c27b020; color: #9c27b0">
              <el-icon><ChatDotSquare/></el-icon>
            </div>
            <div class="statistic-info">
              <div class="statistic-title">评论</div>
              <div class="statistic-value">{{ homeCount.commentCount }}条</div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card class="statistic-card">
          <div class="statistic-content">
            <div class="statistic-icon" style="background-color: #40c9c620; color: #40c9c6">
              <el-icon><Collection/></el-icon>
            </div>
            <div class="statistic-info">
              <div class="statistic-title">用户</div>
              <div class="statistic-value">{{ homeCount.userCount }}名</div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card class="statistic-card">
          <div class="statistic-content">
            <div class="statistic-icon" style="background-color: #34bfa320; color: #34bfa3">
              <el-icon><UserFilled/></el-icon>
            </div>
            <div class="statistic-info">
              <div class="statistic-title">传承人</div>
              <div class="statistic-value">{{ homeCount.masterCount }}名</div>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <el-row :gutter="20" class="dashboard-charts">
      <el-col :span="14">
        <el-card>
          <template #header>
            <div class="card-header">
              <span>数据统计</span>
            </div>
          </template>
          <div ref="barChartContainer" class="chart-container"/>
        </el-card>
      </el-col>
      <el-col :span="10">
        <el-card>
          <template #header>
            <div class="card-header">
              <span>分类统计</span>
            </div>
          </template>
          <div ref="pieChartContainer" class="chart-container"/>
        </el-card>
      </el-col>
    </el-row>

    <el-row :gutter="20" class="dashboard-charts">
      <el-col :span="24">
        <el-card>
          <template #header>
            <div class="card-header">
              <span>传承状态分布</span>
            </div>
          </template>
          <div ref="statusChartContainer" class="chart-container"/>
        </el-card>
      </el-col>
    </el-row>

  </div>
</template>

<script setup>
import {onMounted, ref} from 'vue'
import {selectBarData, selectHomeCount, selectPieData, selectStatusPieData} from "@/api/ich/homePage.js";
import {ChatDotRound, ChatDotSquare, Collection, Document, Picture, User, UserFilled} from "@element-plus/icons-vue";
import * as echarts from 'echarts'

const homeCount = ref({})

const barChartContainer = ref(null)
const pieChartContainer = ref(null)
const statusChartContainer = ref(null)
let barChartInstance = null
let pieChartInstance = null
let statusChartInstance = null

const initBarChart = (categories, data) => {
  if (barChartContainer.value) {
    barChartInstance = echarts.init(barChartContainer.value)
    const option = {
      tooltip: {trigger: 'axis'},
      legend: {bottom: 'bottom'},
      xAxis: {type: 'category', data: categories},
      yAxis: {type: 'value'},
      series: [{
        name: '数量',
        data: data,
        type: 'bar',
        barWidth: '50%',
        itemStyle: {
          color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
            {offset: 0, color: '#83bff6'},
            {offset: 0.5, color: '#188df0'},
            {offset: 1, color: '#188df0'}
          ])
        }
      }]
    }
    barChartInstance.setOption(option)
  }
}

const initPieChart = (pieData, container, title) => {
  const instance = echarts.init(container)
  const option = {
    tooltip: {trigger: 'item'},
    legend: {bottom: 'bottom'},
    series: [{
      type: 'pie',
      radius: ['40%', '70%'],
      avoidLabelOverlap: false,
      itemStyle: {borderRadius: 10, borderColor: '#fff', borderWidth: 2},
      emphasis: {
        label: {show: true, fontSize: '18', fontWeight: 'bold'}
      },
      data: pieData
    }]
  }
  instance.setOption(option)
  return instance
}

onMounted(() => {
  selectHomeCount().then(res => {
    homeCount.value = res.data
  })

  selectBarData().then(res => {
    const barData = res.data
    initBarChart(barData.categories, barData.data)
  })

  selectPieData().then(res => {
    const pieData = res.data
    pieChartInstance = initPieChart(pieData, pieChartContainer.value)
  })

  selectStatusPieData().then(res => {
    const statusData = res.data
    statusChartInstance = initPieChart(statusData, statusChartContainer.value)
  })
})
</script>

<style scoped>
.dashboard {
  padding: 5px;
  background-color: #f5f7f9;
}

.dashboard-statistics {
  margin-bottom: 20px;
}

.statistic-card {
  border-radius: 8px;
  border: none;
}

.statistic-content {
  display: flex;
  align-items: center;
}

.statistic-icon {
  width: 60px;
  height: 60px;
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-right: 15px;
  font-size: 50px;
}

.statistic-title {
  font-size: 14px;
  color: #999;
  margin-bottom: 5px;
}

.statistic-value {
  font-size: 24px;
  font-weight: bold;
  color: #333;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.chart-container {
  width: 100%;
  height: 540px;
}
</style>
