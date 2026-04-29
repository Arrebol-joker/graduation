<template>
  <div class="event-page">
    <div class="section-container">
      <div class="filter-container">
        <div class="search-bar">
          <el-input
              v-model="keyword"
              placeholder="搜索活动名称..."
              clearable
              class="search-input"
              @keyup.enter="handleSearch"
          >
            <template #prefix>
              <el-icon><Search/></el-icon>
            </template>
          </el-input>
          <el-input
              v-model="organizer"
              placeholder="搜索主办单位..."
              clearable
              class="search-input"
              @keyup.enter="handleSearch"
          >
            <template #prefix>
              <el-icon><OfficeBuilding/></el-icon>
            </template>
          </el-input>
          <el-button type="primary" class="search-btn" @click="handleSearch">搜索</el-button>
          <el-button class="reset-btn" @click="handleReset">重置</el-button>
        </div>
      </div>

      <div class="event-list">
        <div v-for="item in eventList"
             :key="item.eventId"
             class="event-card"
             @click="goToDetail(item.eventId)"
        >
          <div class="card-image">
            <img :src="item.image" :alt="item.title" @error="handleImageError">
            <div class="overlay">
              <div class="overlay-content">
                <span>查看详情</span>
              </div>
            </div>
          </div>
          <div class="card-content">
            <h3 class="card-title">{{ item.title }}</h3>
            <div class="card-info">
              <div class="info-row">
                <el-icon><Calendar/></el-icon>
                <span>{{ item.date }} {{ item.time }}</span>
              </div>
              <div class="info-row">
                <el-icon><Location/></el-icon>
                <span>{{ item.location }}</span>
              </div>
              <div class="info-row">
                <el-icon><OfficeBuilding/></el-icon>
                <span>{{ item.organizer }}</span>
              </div>
            </div>
          </div>
        </div>
      </div>

      <pagination
          style="display: flex; justify-content: center"
          v-show="total>0"
          :total="total"
          v-model:page="query.pageNum"
          v-model:limit="query.pageSize"
          @pagination="getList"
          :pageSizes="[30,60,90,120]"
      />
    </div>
  </div>
</template>

<script setup>
import {onMounted, ref} from "vue";
import {listEvent} from "@/api/ich/event.js";
import {Calendar, Location, OfficeBuilding, Search} from "@element-plus/icons-vue";
import {useRouter} from "vue-router";

const keyword = ref('')

const organizer = ref('')

const query = ref({
  pageNum: 1,
  pageSize: 30,
  title: null,
  organizer: null,
})

const eventList = ref([])

const total = ref(0)

const handleSearch = () => {
  query.value.pageNum = 1
  query.value.pageSize = 30
  query.value.title = keyword.value || null
  query.value.organizer = organizer.value || null
  getList()
}

const handleReset = () => {
  keyword.value = ''
  organizer.value = ''
  query.value.title = null
  query.value.organizer = null
  query.value.pageNum = 1
  query.value.pageSize = 30
  getList()
}

const getList = () => {
  listEvent({
    ...query.value,
    _t: Date.now()
  }).then(res => {
    eventList.value = res.rows
    total.value = res.total
  })
}

const router = useRouter()

const goToDetail = (eventId) => {
  router.push('/index/eventDetail/' + eventId)
}

const handleImageError = (e) => {
  e.target.src = 'data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48cmVjdCB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCIgZmlsbD0iI2Y4ZjlmYSIvPjx0ZXh0IHg9IjUwJSIgeT0iNTAlIiBkb21pbmFudC1iYXNlbGluZT0ibWlkZGxlIiB0ZXh0LWFuY2hvcj0ibWlkZGxlIiBmb250LXNpemU9IjE0IiBmaWxsPSIjNmM3NTdkIj7mtYHph4Hml6XmnJ/vvIzpgILmlbDmja4gPC90ZXh0Pjwvc3ZnPg=='
}

onMounted(() => {
  getList()
})
</script>

<style scoped>
.event-page {
  width: 100%;
  background: #f8f9fa;
}

.section-container {
  max-width: 1300px;
  margin: 0 auto;
  padding: 0 20px 40px;
}

.search-bar {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 12px;
  margin-bottom: 20px;
}

.search-input {
  width: 300px;
}

.search-input :deep(.el-input__wrapper) {
  border-radius: 30px;
  padding-left: 20px;
}

.search-btn {
  border-radius: 30px !important;
  padding: 8px 24px !important;
}

.reset-btn {
  border-radius: 30px !important;
  padding: 8px 24px !important;
}

.filter-container {
  padding: 25px;
  background: #f8f9fa;
  border-bottom: 1px solid #e9ecef;
}

.event-list {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
  gap: 30px;
  padding: 30px;
  background: #fff;
}

.event-card {
  border-radius: 15px;
  overflow: hidden;
  box-shadow: 0 6px 15px rgba(0, 0, 0, 0.08);
  transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.1);
  cursor: pointer;
  background: white;
  position: relative;
}

.event-card:hover {
  transform: translateY(-10px) scale(1.02);
  box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15);
}

.event-card:hover .overlay {
  opacity: 1;
}

.event-card:hover .card-image img {
  transform: scale(1.1);
}

.card-image {
  height: 220px;
  overflow: hidden;
  position: relative;
}

.card-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.5s ease;
}

.overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(64, 158, 255, 0.7);
  display: flex;
  align-items: center;
  justify-content: center;
  opacity: 0;
  transition: opacity 0.4s ease;
  z-index: 1;
}

.overlay-content {
  color: white;
  text-align: center;
  font-size: 18px;
  font-weight: 500;
}

.card-content {
  padding: 25px;
}

.card-title {
  font-size: 20px;
  font-weight: 700;
  margin: 0 0 15px 0;
  color: #212529;
  line-height: 1.3;
}

.card-info {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.info-row {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 14px;
  color: #6c757d;
  padding: 6px 12px;
  border-radius: 20px;
  background-color: #f8f9fa;
}

.info-row .el-icon {
  color: #409EFF;
  flex-shrink: 0;
}

.info-row span {
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}
</style>
