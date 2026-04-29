<template>
  <div class="home-page">
    <div class="banner-section">
      <el-carousel height="500px" indicator-position="outside">
        <el-carousel-item v-for="banner in bannerList" :key="banner.bannerId">
          <div class="carousel-item" :style="{ backgroundImage: `url(${getImageUrl(banner.image, baseUrl)})` }">
            <div class="carousel-content">
              <h1 class="carousel-title">{{ banner.title }}</h1>
              <p class="carousel-desc">{{ banner.description }}</p>
            </div>
          </div>
        </el-carousel-item>
      </el-carousel>
    </div>

    <div class="featured-section section-container">
      <div class="section-header">
        <h2 class="section-title">非遗项目</h2>
        <el-button category="text" @click="goToAllHeritage">查看全部</el-button>
      </div>

      <div class="featured-grid">
        <div v-for="item in heritageList"
             :key="item.heritageId"
             class="featured-card"
             @click="goToHeritageDetail(item.heritageId)"
        >
          <div class="card-image">
            <img :src="getImageUrl(item.image, baseUrl)" alt="">
          </div>

          <div class="card-content">
            <h3 class="card-title">{{ item.title }}</h3>
            <p class="card-desc">{{ item.description }}</p>
            <div class="card-meta">
              <span class="card-location">
                <el-icon><LocationFilled/></el-icon>
                {{ item.location }}
              </span>
              <span class="card-category">{{ item.category }}</span>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="stats-section section-container">
      <div class="section-header">
        <h2 class="section-title">数据概览</h2>
      </div>
      <div class="stats-grid">
        <div class="stat-card" style="--gradient: linear-gradient(135deg, #667eea, #764ba2)">
          <div class="stat-icon">
            <el-icon :size="40"><Collection/></el-icon>
          </div>
          <div class="stat-info">
            <div class="stat-number">{{ homeCount.heritageCount || 0 }}</div>
            <div class="stat-label">非遗项目总数</div>
          </div>
        </div>
        <div class="stat-card" style="--gradient: linear-gradient(135deg, #f093fb, #f5576c)">
          <div class="stat-icon">
            <el-icon :size="40"><User/></el-icon>
          </div>
          <div class="stat-info">
            <div class="stat-number">{{ homeCount.masterCount || 0 }}</div>
            <div class="stat-label">传承人数量</div>
          </div>
        </div>
        <div class="stat-card" style="--gradient: linear-gradient(135deg, #4facfe, #00f2fe)">
          <div class="stat-icon">
            <el-icon :size="40"><Document/></el-icon>
          </div>
          <div class="stat-info">
            <div class="stat-number">{{ homeCount.newsCount || 0 }}</div>
            <div class="stat-label">新闻总数</div>
          </div>
        </div>
        <div class="stat-card" style="--gradient: linear-gradient(135deg, #43e97b, #38f9d7)">
          <div class="stat-icon">
            <el-icon :size="40"><Calendar/></el-icon>
          </div>
          <div class="stat-info">
            <div class="stat-number">{{ homeCount.eventCount || 0 }}</div>
            <div class="stat-label">活动总数</div>
          </div>
        </div>
      </div>
    </div>

    <div class="news-section section-container">
      <div class="section-header">
        <h2 class="section-title">新闻动态</h2>
        <el-button type="primary" text @click="router.push('/index/news')">查看全部</el-button>
      </div>
      <div class="news-grid">
        <div v-for="item in newsList"
             :key="item.newsId"
             class="news-card"
             @click="router.push('/index/newsDetail/' + item.newsId)"
        >
          <div class="news-image">
            <img :src="getImageUrl(item.image, baseUrl)" :alt="item.title" @error="handleImageError">
          </div>
          <div class="news-content">
            <h3 class="news-title">{{ item.title }}</h3>
            <div class="news-meta">
              <span class="news-date">
                <el-icon><Calendar/></el-icon>
                {{ item.publishTime }}
              </span>
              <span class="news-category">{{ item.category }}</span>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="event-section section-container">
      <div class="section-header">
        <h2 class="section-title">活动预告</h2>
        <el-button type="primary" text @click="router.push('/index/event')">查看全部</el-button>
      </div>
      <div class="event-grid">
        <div v-for="item in eventList"
             :key="item.eventId"
             class="event-card"
             @click="router.push('/index/eventDetail/' + item.eventId)"
        >
          <div class="event-image">
            <img :src="getImageUrl(item.image, baseUrl)" :alt="item.title" @error="handleImageError">
          </div>
          <div class="event-content">
            <h3 class="event-title">{{ item.title }}</h3>
            <div class="event-info">
              <div class="event-info-row">
                <el-icon><Calendar/></el-icon>
                <span>{{ item.date }} {{ item.time }}</span>
              </div>
              <div class="event-info-row">
                <el-icon><Location/></el-icon>
                <span>{{ item.location }}</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="master-section section-container">
      <div class="section-header">
        <h2 class="section-title">传承人推荐</h2>
        <el-button type="primary" text @click="router.push('/index/master')">查看全部</el-button>
      </div>
      <div class="master-grid">
        <div v-for="item in masterList"
             :key="item.masterId"
             class="master-card"
             @click="router.push('/index/masterDetail/' + item.masterId)"
        >
          <div class="master-image">
            <img :src="getImageUrl(item.image, baseUrl)" alt="">
          </div>
          <div class="master-info">
            <h3 class="master-name">{{ item.name }}</h3>
            <p class="master-skills">{{ item.skills }}</p>
            <div class="master-location">
              <el-icon><Location/></el-icon>
              {{ item.location }}
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import {ref, onMounted} from 'vue'
import {listBanner} from "@/api/ich/banner.js";
import {listHeritage} from "@/api/ich/heritage.js";
import {selectHomeCount} from "@/api/ich/homePage.js";
import {listNews} from "@/api/ich/news.js";
import {listEvent} from "@/api/ich/event.js";
import {listMaster} from "@/api/ich/master.js";
import {useRouter} from "vue-router";
import {Calendar, Collection, Document, Location, LocationFilled, User} from "@element-plus/icons-vue";
import {getImageUrl} from "@/utils/validate";

const baseUrl = import.meta.env.VITE_APP_BASE_API

const router = useRouter()

const bannerList = ref([])
const heritageList = ref([])
const homeCount = ref({})
const newsList = ref([])
const eventList = ref([])
const masterList = ref([])

const goToHeritageDetail = (heritageId) => {
  router.push('/index/heritageDetail/' + heritageId)
}

const goToAllHeritage = () => {
  router.push('/index/heritage')
}

const handleImageError = (e) => {
  e.target.src = 'data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48cmVjdCB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCIgZmlsbD0iI2Y4ZjlmYSIvPjx0ZXh0IHg9IjUwJSIgeT0iNTAlIiBkb21pbmFudC1iYXNlbGluZT0ibWlkZGxlIiB0ZXh0LWFuY2hvcj0ibWlkZGxlIiBmb250LXNpemU9IjE0IiBmaWxsPSIjNmM3NTdkIj7mtYHph4Hml6XmnJ/vvIzpgILmlbDmja48L3RleHQ+PC9zdmc+'
}

onMounted(() => {
  listBanner().then(res => {
    bannerList.value = res.rows
  })

  listHeritage({pageNum: 1, pageSize: 6}).then(res => {
    heritageList.value = res.rows
  })

  selectHomeCount().then(res => {
    homeCount.value = res.data
  })

  listNews({pageNum: 1, pageSize: 4}).then(res => {
    newsList.value = res.rows
  })

  listEvent({pageNum: 1, pageSize: 3}).then(res => {
    eventList.value = res.rows
  })

  listMaster({pageNum: 1, pageSize: 4}).then(res => {
    masterList.value = res.rows
  })
})
</script>

<style scoped>
.home-page {
  width: 100%;
}

.home-page .section-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 40px 20px;
}

.home-page .section-title {
  text-align: center;
  font-size: 28px;
  font-weight: bold;
  margin-bottom: 30px;
  color: #333;
  position: relative;
}

.home-page .section-title::after {
  content: '';
  display: block;
  width: 60px;
  height: 3px;
  background: linear-gradient(90deg, #3a7bd5, #00d2ff);
  margin: 10px auto 0;
  border-radius: 3px;
}

.home-page .section-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 30px;
}

.home-page .section-header .section-title {
  margin-bottom: 0;
}

.banner-section {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
}

.banner-section .el-carousel {
  border-radius: 10px;
  overflow: hidden;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.banner-section .el-carousel :deep(.el-carousel__indicator) .el-carousel__button {
  width: 30px;
  height: 3px;
  border-radius: 0;
}

.banner-section .el-carousel :deep(.el-carousel__indicator).is-active .el-carousel__button {
  background-color: #3a7bd5;
}

.banner-section .el-carousel :deep(.el-carousel__container) {
  border-radius: 10px;
}

.banner-section .carousel-item {
  width: 100%;
  height: 100%;
  background-size: cover;
  background-position: center;
  display: flex;
  align-items: center;
  position: relative;
}

.banner-section .carousel-item::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.4);
}

.banner-section .carousel-content {
  position: relative;
  z-index: 1;
  color: white;
  text-align: center;
  width: 100%;
  padding: 0 20px;
}

.banner-section .carousel-content .carousel-title {
  font-size: 42px;
  font-weight: bold;
  margin-bottom: 20px;
  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
}

.banner-section .carousel-content .carousel-desc {
  font-size: 20px;
  margin-bottom: 30px;
  max-width: 800px;
  margin-left: auto;
  margin-right: auto;
  text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);
}

.featured-section .featured-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 30px;
}

.featured-section .featured-card {
  border-radius: 15px;
  overflow: hidden;
  box-shadow: 0 6px 15px rgba(0, 0, 0, 0.08);
  transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.1);
  cursor: pointer;
  background: white;
  position: relative;
}

.featured-section .featured-card:hover {
  transform: translateY(-10px) scale(1.02);
  box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15);
}

.featured-section .featured-card:hover .card-image img {
  transform: scale(1.1);
}

.featured-section .featured-card .card-image {
  height: 200px;
  overflow: hidden;
  position: relative;
}

.featured-section .featured-card .card-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.5s ease;
}

.featured-section .featured-card .card-content {
  padding: 25px;
}

.featured-section .featured-card .card-content .card-title {
  font-size: 20px;
  font-weight: 700;
  margin: 0 0 12px 0;
  color: #212529;
  line-height: 1.3;
}

.featured-section .featured-card .card-content .card-desc {
  color: #6c757d;
  font-size: 15px;
  line-height: 1.6;
  margin-bottom: 20px;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.featured-section .featured-card .card-content .card-meta {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.featured-section .featured-card .card-content .card-meta .card-location,
.featured-section .featured-card .card-content .card-meta .card-category {
  font-size: 14px;
  padding: 6px 12px;
  border-radius: 20px;
  background-color: #f8f9fa;
  color: #495057;
  display: flex;
  align-items: center;
  gap: 5px;
}

.featured-section .featured-card .card-content .card-meta .card-location i {
  color: #8B4513;
}

.featured-section .featured-card .card-content .card-meta .card-category {
  background-color: #D9A37D;
  color: #495057;
  font-weight: 500;
}

.stats-section .stats-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 24px;
}

.stat-card {
  background: var(--gradient);
  border-radius: 15px;
  padding: 30px 25px;
  display: flex;
  align-items: center;
  gap: 20px;
  color: white;
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.12);
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.stat-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 12px 30px rgba(0, 0, 0, 0.2);
}

.stat-icon {
  width: 70px;
  height: 70px;
  background: rgba(255, 255, 255, 0.2);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

.stat-info {
  flex: 1;
}

.stat-number {
  font-size: 36px;
  font-weight: 700;
  line-height: 1.2;
}

.stat-label {
  font-size: 14px;
  opacity: 0.9;
  margin-top: 4px;
}

.news-section .news-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 24px;
}

.news-card {
  border-radius: 15px;
  overflow: hidden;
  box-shadow: 0 6px 15px rgba(0, 0, 0, 0.08);
  transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.1);
  cursor: pointer;
  background: white;
}

.news-card:hover {
  transform: translateY(-8px);
  box-shadow: 0 12px 25px rgba(0, 0, 0, 0.15);
}

.news-card:hover .news-image img {
  transform: scale(1.1);
}

.news-image {
  height: 180px;
  overflow: hidden;
}

.news-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.5s ease;
}

.news-content {
  padding: 20px;
}

.news-title {
  font-size: 16px;
  font-weight: 600;
  color: #212529;
  margin: 0 0 12px 0;
  line-height: 1.4;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.news-meta {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.news-date {
  font-size: 13px;
  color: #6c757d;
  display: flex;
  align-items: center;
  gap: 4px;
}

.news-date .el-icon {
  color: #409EFF;
}

.news-category {
  font-size: 12px;
  padding: 4px 10px;
  border-radius: 20px;
  background: #a0cfff;
  color: #495057;
  font-weight: 500;
}

.event-section .event-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 30px;
}

.event-card {
  border-radius: 15px;
  overflow: hidden;
  box-shadow: 0 6px 15px rgba(0, 0, 0, 0.08);
  transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.1);
  cursor: pointer;
  background: white;
}

.event-card:hover {
  transform: translateY(-8px);
  box-shadow: 0 12px 25px rgba(0, 0, 0, 0.15);
}

.event-card:hover .event-image img {
  transform: scale(1.1);
}

.event-image {
  height: 200px;
  overflow: hidden;
}

.event-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.5s ease;
}

.event-content {
  padding: 20px;
}

.event-title {
  font-size: 18px;
  font-weight: 600;
  color: #212529;
  margin: 0 0 15px 0;
  line-height: 1.4;
  display: -webkit-box;
  -webkit-line-clamp: 1;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.event-info {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.event-info-row {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 14px;
  color: #6c757d;
  padding: 6px 12px;
  border-radius: 20px;
  background-color: #f8f9fa;
}

.event-info-row .el-icon {
  color: #409EFF;
  flex-shrink: 0;
}

.event-info-row span {
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.master-section .master-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 30px;
}

.master-card {
  border-radius: 15px;
  overflow: hidden;
  box-shadow: 0 6px 15px rgba(0, 0, 0, 0.08);
  transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.1);
  cursor: pointer;
  background: white;
  text-align: center;
}

.master-card:hover {
  transform: translateY(-10px) scale(1.02);
  box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15);
}

.master-card:hover .master-image img {
  transform: scale(1.1);
}

.master-image {
  height: 220px;
  overflow: hidden;
}

.master-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.5s ease;
}

.master-info {
  padding: 20px;
}

.master-name {
  font-size: 20px;
  font-weight: 700;
  margin: 0 0 10px 0;
  color: #212529;
  line-height: 1.3;
}

.master-skills {
  color: #6c757d;
  font-size: 14px;
  line-height: 1.5;
  margin-bottom: 10px;
  min-height: 42px;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.master-location {
  display: flex;
  align-items: center;
  justify-content: center;
  color: #6c757d;
  font-size: 14px;
}

.master-location .el-icon {
  margin-right: 5px;
  color: #8B4513;
}

@media (max-width: 1024px) {
  .stats-section .stats-grid {
    grid-template-columns: repeat(2, 1fr);
  }

  .news-section .news-grid {
    grid-template-columns: repeat(2, 1fr);
  }

  .event-section .event-grid {
    grid-template-columns: repeat(2, 1fr);
  }

  .master-section .master-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (max-width: 640px) {
  .stats-section .stats-grid {
    grid-template-columns: 1fr;
  }

  .news-section .news-grid {
    grid-template-columns: 1fr;
  }

  .event-section .event-grid {
    grid-template-columns: 1fr;
  }

  .master-section .master-grid {
    grid-template-columns: 1fr;
  }

  .featured-section .featured-grid {
    grid-template-columns: 1fr;
  }
}
</style>
