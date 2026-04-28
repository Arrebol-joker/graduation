<template>
  <!-- 页面容器 -->
  <div class="news-page">
    <!-- 内容区域容器 -->
    <div class="section-container">
      <!-- 筛选器容器 -->
      <div class="filter-container">
        <div class="category-filter">
          <!-- 分类按钮 -->
          <el-button @click="setActiveCategory('')"
                     class="category-btn"
                     :class="{ 'active': activeCategory === '' }"
          >
            全部新闻
          </el-button>
          <!-- 动态生成分类按钮 -->
          <el-button
              v-for="category in onlyCategories"
              :key="category"
              class="category-btn"
              @click="setActiveCategory(category)"
              :class="{ 'active': activeCategory === category }"
          >
            {{ category }}
          </el-button>
        </div>
      </div>

      <!-- 新闻列表布局显示 -->
      <div class="news-list">
        <div v-for="item in newsList"
             :key="item.newsId"
             class="news-card"
             @click="goToDetail(item.newsId)"
        >
          <!-- 卡片图片区域 -->
          <div class="card-image">
            <!-- 新闻图片 -->
            <img :src="item.image" :alt="item.title" @error="handleImageError">
            <div class="overlay">
              <div class="overlay-content">
                <span>查看详情</span>
              </div>
            </div>
          </div>
          <!-- 卡片内容区域 -->
          <div class="card-content">
            <h3 class="card-title">{{ item.title }}</h3>
            <p class="card-desc">{{ item.content }}</p>
            <div class="card-meta">
              <!-- 发布时间 -->
              <span class="card-date">
                <el-icon><Calendar/></el-icon>
                {{ item.publishTime }}
              </span>
              <!-- 新闻类别 -->
              <span class="card-category">{{ item.category }}</span>
            </div>
          </div>
        </div>
      </div>

      <!-- 分页组件 -->
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
import {listNews} from "@/api/ich/news.js";
import {Calendar} from "@element-plus/icons-vue";
import {useRouter} from "vue-router";

//当前激活的类别
const activeCategory = ref('')

//查询参数
const query = ref({
  pageNum: 1,
  pageSize: 30,
  category: null,
})

//新闻列表数据
const newsList = ref([])

//数据总数
const total = ref(0)

//计算属性
const onlyCategories = ref(['政策新闻', '活动资讯', '非遗动态'])

//根据类别进行条件查询
const setActiveCategory = (category) => {
  activeCategory.value = category
  if (category === '') {
    query.value = {
      pageNum: 1,
      pageSize: 30,
      category: null,
    }
    getList()
  } else {
    query.value = {
      pageNum: 1,
      pageSize: 30,
      category: category,
    }
    getList()
  }
}

//查询数据
const getList = () => {
  listNews(query.value).then(res => {
    newsList.value = res.rows
    total.value = res.total
  })
}

//路由实例
const router = useRouter()

//查看新闻详细
const goToDetail = (newsId) => {
  router.push('/index/newsDetail/'+ newsId)
}

//图片加载错误处理
const handleImageError = (e) => {
  // 设置默认图片或空图片
  e.target.src = 'data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48cmVjdCB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCIgZmlsbD0iI2Y4ZjlmYSIvPjx0ZXh0IHg9IjUwJSIgeT0iNTAlIiBkb21pbmFudC1iYXNlbGluZT0ibWlkZGxlIiB0ZXh0LWFuY2hvcj0ibWlkZGxlIiBmb250LXNpemU9IjE0IiBmaWxsPSIjNmM3NTdkIj7kvZzogIHkvJHlpLTog4HmlbDkvJHlpLTogLw8vdGV4dD48L3N2Zz4='
}

//组件挂载后执行
onMounted(() => {
  getList()
})

</script>

<style scoped>
/* 页面容器样式 */
.news-page {
  width: 100%;
  background: #f8f9fa;
}

/* 内容区域容器 */
.section-container {
  max-width: 1300px;
  margin: 0 auto;
  padding: 0 20px 40px;
}

/* 筛选器容器样式 */
.filter-container {
  padding: 25px;
  background: #f8f9fa;
  border-bottom: 1px solid #e9ecef;
}

/* 分类筛选器布局 */
.category-filter {
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
  justify-content: center;
}

/* 分类按钮基础样式 */
.category-btn {
  border-radius: 30px !important;
  border: 2px solid #e9ecef !important;
  background: white !important;
  color: #495057 !important;
  padding: 8px 20px !important;
  font-weight: 500 !important;
  transition: all 0.3s ease !important;
}

/* 分类按钮悬停效果 */
.category-btn:hover {
  border-color: #409EFF !important;
  color: #409EFF !important;
  transform: translateY(-2px) !important;
  box-shadow: 0 4px 12px rgba(64, 158, 255, 0.15) !important;
}

/* 激活状态的分类按钮 */
.category-btn.active {
  background: #409EFF !important;
  border-color: #409EFF !important;
  color: white !important;
  box-shadow: 0 4px 15px rgba(64, 158, 255, 0.3) !important;
}

/* 新闻网格布局 */
.news-list {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
  gap: 30px;
  padding: 30px;
  background: #fff;
}

/* 新闻卡片基础样式 */
.news-card {
  border-radius: 15px;
  overflow: hidden;
  box-shadow: 0 6px 15px rgba(0, 0, 0, 0.08);
  transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.1);
  cursor: pointer;
  background: white;
  position: relative;
}

/* 卡片悬停效果 */
.news-card:hover {
  transform: translateY(-10px) scale(1.02);
  box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15);
}

/* 卡片悬停时显示遮罩层 */
.news-card:hover .overlay {
  opacity: 1;
}

/* 卡片悬停时图片放大效果 */
.news-card:hover .card-image img {
  transform: scale(1.1);
}

/* 卡片图片容器 */
.card-image {
  height: 220px;
  overflow: hidden;
  position: relative;
}

/* 卡片图片样式 */
.card-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.5s ease;
}

/* 遮罩层样式 */
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

/* 遮罩层内容样式 */
.overlay-content {
  color: white;
  text-align: center;
  font-size: 18px;
  font-weight: 500;
}

/* 卡片内容区域 */
.card-content {
  padding: 25px;
}

/* 卡片标题样式 */
.card-title {
  font-size: 20px;
  font-weight: 700;
  margin: 0 0 12px 0;
  color: #212529;
  line-height: 1.3;
}

/* 卡片描述样式 */
.card-desc {
  color: #6c757d;
  font-size: 15px;
  line-height: 1.6;
  margin-bottom: 20px;
  display: -webkit-box;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

/* 卡片元信息布局 */
.card-meta {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

/* 日期和分类标签基础样式 */
.card-date, .card-category {
  font-size: 14px;
  padding: 6px 12px;
  border-radius: 20px;
  background-color: #f8f9fa;
  color: #495057;
  display: flex;
  align-items: center;
  gap: 5px;
}

/* 日期图标颜色 */
.card-date i {
  color: #409EFF;
}

/* 分类标签特殊样式 */
.card-category {
  background: #a0cfff;
  color: #495057;
  font-weight: 500;
}
</style>