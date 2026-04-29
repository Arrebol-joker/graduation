<template>
  <!-- 新闻详情页面容器 -->
  <div class="news-detail-page" v-loading="loading">
    <div class="detail-container">
      <!-- 返回按钮 -->
      <div class="back-button">
        <el-button @click="router.go(-1)" type="primary" plain>
          <el-icon><ArrowLeft/></el-icon>
          返回新闻列表
        </el-button>
      </div>

      <!-- 新闻头部信息 -->
      <div class="detail-header">
        <h1 class="news-title">{{ news.title }}</h1>
        <div class="news-meta">
          <span>{{ news.createTime }}</span>
          <span>{{ news.author }}</span>
          <span class="news-category">{{ news.category }}</span>
        </div>
      </div>

      <!-- 新闻图片 -->
      <div class="cover-image">
        <img :src="getImageUrl(news.image, baseUrl)" alt="">
      </div>

      <!-- 新闻正文 -->
      <div class="detail-content">
        <div class="news-content" v-html="news.content"/>
      </div>

      <!-- 评论区 -->
      <div class="comment-section">
        <h2>评论区</h2>
        <div class="comment-list">
          <div v-if="comments.length === 0" class="no-comment">暂无评论，快来发表第一条评论吧！</div>
          <div v-for="item in comments" :key="item.id" class="comment-item">
            <div class="comment-header">
              <span class="comment-nickname">{{ item.nickName }}</span>
              <span class="comment-time">{{ item.createTime }}</span>
              <el-button
                v-if="userStore.id && item.userId === userStore.id"
                type="danger"
                link
                size="small"
                @click="handleDelete(item.id)"
              >
                删除
              </el-button>
            </div>
            <div class="comment-content">{{ item.content }}</div>
          </div>
        </div>
        <div class="comment-input">
          <el-input
            v-model="commentContent"
            placeholder="请输入评论内容"
            maxlength="500"
            class="comment-input-field"
          />
          <el-button type="primary" @click="submitComment" :loading="submitting" class="comment-submit-btn">
            发表评论
          </el-button>
        </div>
      </div>

    </div>
  </div>
</template>

<script setup>
import {onMounted, ref} from 'vue'
import {useRoute, useRouter} from "vue-router";
import {ArrowLeft} from "@element-plus/icons-vue";
import {getNews} from "@/api/ich/news.js";
import {addComment, listComment, deleteComment} from "@/api/ich/comment.js";
import {getImageUrl} from "@/utils/validate";
import {ElMessage, ElMessageBox} from "element-plus";
import useUserStore from "@/store/modules/user";

const router = useRouter()
const route = useRoute()
const userStore = useUserStore()

const baseUrl = import.meta.env.VITE_APP_BASE_API

const news = ref({})

//加载状态
const loading = ref(false)

//评论相关
const comments = ref([])
const commentContent = ref('')
const submitting = ref(false)

const COMMENT_TYPE_NEWS = 2

const loadComments = () => {
  const newsId = route.params.id
  listComment(newsId, COMMENT_TYPE_NEWS).then(res => {
    comments.value = res.data || []
  })
}

const submitComment = () => {
  if (!commentContent.value.trim()) {
    ElMessage.warning('请输入评论内容')
    return
  }
  submitting.value = true
  addComment({
    content: commentContent.value.trim(),
    targetId: route.params.id,
    type: COMMENT_TYPE_NEWS
  }).then(() => {
    ElMessage.success('评论成功')
    commentContent.value = ''
    loadComments()
  }).finally(() => {
    submitting.value = false
  })
}

const handleDelete = (id) => {
  ElMessageBox.confirm('确定删除该评论吗？', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  }).then(() => {
    deleteComment(id).then(() => {
      ElMessage.success('删除成功')
      loadComments()
    })
  }).catch(() => {})
}

//组件挂载完成后执行
onMounted(() => {
  loading.value = true
  //调用API获取新闻详情
  getNews(route.params.id).then(res => {
    news.value = res.data
    loading.value = false
  })
  loadComments()
})
</script>

<style scoped>
/* 新闻详情页整体样式 */
.news-detail-page {
  width: 100%;
  background: #f8f9fa;
  padding: 20px 0 40px;
}

/* 主要内容容器 */
.detail-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
}

/* 返回按钮区域 */
.back-button {
  margin-bottom: 20px;
}

/* 新闻头部区域样式 */
.detail-header {
  background: white;
  padding: 30px;
  border-radius: 15px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  margin-bottom: 30px;
}

/* 新闻标题样式 */
.news-title {
  font-size: 32px;
  font-weight: bold;
  margin: 0 0 20px 0;
  color: #212529;
}

/* 新闻元信息容器 */
.news-meta {
  display: flex;
  gap: 20px;
  font-size: 14px;
  color: #6c757d;
}

/* 新闻分类标签样式 */
.news-category {
  background: #e6f7ff;
  color: #3a7bd5;
  padding: 2px 10px;
  border-radius: 4px;
}

/* 封面图片容器 */
.cover-image {
  width: 100%;
  height: 400px;
  border-radius: 15px;
  overflow: hidden;
  margin-bottom: 30px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
}

/* 封面图片样式 */
.cover-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

/* 正文内容区域 */
.detail-content {
  background: white;
  border-radius: 15px;
  overflow: hidden;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  padding: 30px;
  margin-bottom: 40px;
}

/* 新闻正文内容样式 */
.news-content {
  color: #495057;
  line-height: 1.8;
}

/* 段落样式 */
.news-content p {
  margin-bottom: 20px;
  font-size: 16px;
}

/* 加载状态容器 */
.loading-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 30px 20px;
  background: white;
  border-radius: 15px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
}

/* 未找到容器 */
.not-found {
  max-width: 1200px;
  margin: 0 auto;
  padding: 60px 20px;
  background: white;
  border-radius: 15px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  text-align: center;
}

/* 评论区样式 */
.comment-section {
  background: white;
  border-radius: 15px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  padding: 30px;
  margin-bottom: 40px;
}

.comment-section h2 {
  font-size: 24px;
  margin: 0 0 20px 0;
  color: #212529;
  padding-bottom: 15px;
  border-bottom: 2px solid #f0f0f0;
}

.comment-input {
  display: flex;
  gap: 12px;
  margin-top: 20px;
}

.comment-input-field {
  flex: 1;
}

.comment-submit-btn {
  flex-shrink: 0;
}

.comment-list {
}

.no-comment {
  text-align: center;
  color: #999;
  padding: 30px 0;
  font-size: 14px;
}

.comment-item {
  padding: 15px 0;
  border-bottom: 1px solid #f0f0f0;
}

.comment-item:last-child {
  border-bottom: none;
}

.comment-header {
  display: flex;
  align-items: center;
  margin-bottom: 8px;
}

.comment-nickname {
  font-weight: bold;
  color: #333;
  margin-right: 15px;
}

.comment-time {
  color: #999;
  font-size: 13px;
  flex: 1;
}

.comment-content {
  color: #495057;
  line-height: 1.6;
  font-size: 15px;
}
</style>
