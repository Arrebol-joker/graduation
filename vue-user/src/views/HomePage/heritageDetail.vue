<template>
  <!-- 非遗详情页面容器 -->
  <div class="heritage-detail-page" v-loading="loading">
    <div class="detail-container">
      <!-- 返回按钮 -->
      <div class="back-button">
        <el-button @click="router.go(-1)" type="primary">
          <el-icon>
            <Back/>
          </el-icon>
          返回列表
        </el-button>
      </div>

      <!-- 标题区域 -->
      <div class="detail-header">
        <div class="heritage-title">{{ heritage.title }}</div>
        <div class="heritage-tags">
          <el-tag size="large"
                  effect="dark"
          >
            {{ heritage.category }}
          </el-tag>
        </div>
      </div>

      <!-- 主要信息区域 -->
      <div class="detail-content">
        <!-- 左侧图片展示区域 -->
        <div class="image-section">
          <div class="main-image">
            <img :src="getImageUrl(heritage.image, baseUrl)" alt="">
          </div>
        </div>

        <!-- 右侧信息区域 -->
        <div class="info-section">
          <div class="basic-info">
            <div class="info-item">
              <label>所在地: </label>
              <span>{{ heritage.location }}</span>
            </div>

            <div class="info-item">
              <label>传承状态: </label>
              <span v-if="heritage.status === '良好'" style="font-weight: bold;">
                                <el-tag effect="light" type="success" color="green"> {{ heritage.status }}</el-tag>
                            </span>
              <span v-if="heritage.status === '一般'" style="font-weight: bold;">
                                 <el-tag effect="light" type="warning" color="blue">{{ heritage.status }}</el-tag>
                            </span>
              <span v-if="heritage.status === '濒危'" style="font-weight: bold;">
                                <el-tag effect="light" type="danger" color="red">{{ heritage.status }}</el-tag>
                            </span>
            </div>
          </div>

          <!-- 项目简介 -->
          <div class="description-section">
            <h3>项目简介</h3>
            <p class="description-text">{{ heritage.description }}</p>
          </div>
        </div>
      </div>

      <!-- 详细介绍区域 -->
      <div class="detail-description">
        <h1>详细介绍</h1>
        <div class="rich-content" v-html="heritage.detailDescription"></div>
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
import {onMounted, ref} from "vue";
import {useRoute, useRouter} from "vue-router";
import {getHeritage} from "@/api/ich/heritage.js";
import {addComment, listComment, deleteComment} from "@/api/ich/comment.js";
import {Back} from "@element-plus/icons-vue";
import {getImageUrl} from "@/utils/validate";
import {ElMessage, ElMessageBox} from "element-plus";
import useUserStore from "@/store/modules/user";

const route = useRoute()
const router = useRouter()
const userStore = useUserStore()

//非遗项目详情数据
const heritage = ref({})

//加载状态
const loading = ref(false)

//基础URL
const baseUrl = import.meta.env.VITE_APP_BASE_API

//评论相关
const comments = ref([])
const commentContent = ref('')
const submitting = ref(false)

const COMMENT_TYPE_HERITAGE = 1

const loadComments = () => {
  const heritageId = route.params.id
  listComment(heritageId, COMMENT_TYPE_HERITAGE).then(res => {
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
    type: COMMENT_TYPE_HERITAGE
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

//组件挂载后执行
onMounted(() => {
  loading.value = true
  const heritageId = route.params.id
  getHeritage(heritageId).then(res => {
    heritage.value = res.data
    loading.value = false
  })
  loadComments()
})
</script>

<style scoped>
/* 页面容器样式 */
.heritage-detail-page {
  width: 100%;
  background: #f8f9fa;
  padding: 20px 0 40px;
}

/* 详情内容容器 */
.detail-container {
  max-width: 1500px;
  margin: 0 auto;
  padding: 0 20px;
}

/* 返回按钮区域 */
.back-button {
  margin-bottom: 20px;
}

/* 头部区域样式 */
.detail-header {
  background: white;
  padding: 30px;
  border-radius: 15px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  margin-bottom: 30px;
}

/* 标题样式 */
.heritage-title {
  font-size: 32px;
  font-weight: bold;
  margin: 0 0 20px 0;
  color: #212529;
}

/* 标签容器样式 */
.heritage-tags {
  display: flex;
  gap: 15px;
}

/* 主要内容区域网格布局 */
.detail-content {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 30px;
  margin-bottom: 40px;
}

/* 图片区域样式 */
.image-section {
  background: white;
  border-radius: 15px;
  overflow: hidden;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  padding: 20px;
}

/* 主图片容器 */
.main-image {
  width: 100%;
  height: 400px;
  border-radius: 10px;
  overflow: hidden;
}

/* 主图片样式 */
.main-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

/* 信息区域样式 */
.info-section {
  background: white;
  border-radius: 15px;
  overflow: hidden;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  padding: 30px;
}

/* 基本信息区域 */
.basic-info {
  margin-bottom: 30px;
}

/* 信息项样式 */
.info-item {
  display: flex;
  margin-bottom: 20px;
  padding-bottom: 20px;
  border-bottom: 1px solid #eee;
}

/* 最后一个信息项移除边框 */
.info-item:last-child {
  margin-bottom: 0;
  padding-bottom: 0;
  border-bottom: none;
}

/* 信息项标签样式 */
.info-item label {
  font-weight: bold;
  color: #495057;
  width: 100px;
  flex-shrink: 0;
}

/* 信息项内容样式 */
.info-item span {
  color: #6c757d;
}

/* 描述区域 */
.description-section {
  margin-bottom: 30px;
}

/* 描述标题样式 */
.description-section h3 {
  font-size: 20px;
  margin: 0 0 15px 0;
  color: #212529;
}

/* 描述文本样式 */
.description-text {
  color: #6c757d;
  line-height: 1.8;
  font-size: 16px;
}

/* 详细介绍区域样式 */
.detail-description {
  background: white;
  border-radius: 15px;
  overflow: hidden;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  padding: 30px;
  margin-bottom: 40px;
}

/* 详细介绍标题样式 */
.detail-description h2 {
  font-size: 24px;
  margin: 0 0 20px 0;
  color: #212529;
  padding-bottom: 15px;
  border-bottom: 2px solid #f0f0f0;
}

/* 富文本内容样式 */
.rich-content {
  color: #495057;
  line-height: 1.8;
}

/* 富文本段落样式 */
.rich-content p {
  margin-bottom: 20px;
  font-size: 16px;
}

/* 加载容器样式 */
.loading-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 30px 20px;
  background: white;
  border-radius: 15px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
}

/* 未找到容器样式 */
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
