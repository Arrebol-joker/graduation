<template>
  <div class="about-page">
    <div class="section-container">
      <!-- 关于我们介绍 -->
      <div class="intro-section">
        <div class="intro-content">
          <h2 class="section-title">非物质文化遗产保护</h2>
          <p class="intro-text">
            {{ about.intro }}
          </p>
        </div>
        <div class="intro-image">
          <img :src="getImageUrl(about.image, baseUrl)" alt="">
        </div>
      </div>

      <!-- 使命愿景 -->
      <div class="mission-section">
        <div class="mission-card">
          <div class="mission-icon">🎯</div>
          <h3 class="mission-title">我们的使命</h3>
          <div class="editable-wrapper">
            <p class="mission-text">
              {{ about.mission }}
            </p>
          </div>
        </div>

        <div class="mission-card">
          <div class="mission-icon">👁️</div>
          <h3 class="mission-title">我们的愿景</h3>
          <div class="editable-wrapper">
            <p class="mission-text">
              {{ about.vision }}
            </p>
          </div>
        </div>

        <div class="mission-card">
          <div class="mission-icon">🤝</div>
          <h3 class="mission-title">我们的价值观</h3>
          <div class="editable-wrapper">
            <p class="mission-text">
              {{ about.value }}
            </p>
          </div>
        </div>
      </div>

      <!-- 联系我们 -->
      <div class="contact-section">
        <h2 class="section-title">联系我们</h2>
        <div class="contact-content">
          <div class="contact-info">
            <!-- 联系电话 -->
            <div class="contact-item">
              <div class="contact-icon">📞</div>
              <div class="contact-details">
                <h3>联系电话</h3>
                <p>{{ about.phone }}</p>
              </div>
            </div>

            <!-- 办公地址 -->
            <div class="contact-item">
              <div class="contact-icon">🏢</div>
              <div class="contact-details">
                <h3>办公地址</h3>
                <p>{{ about.address }}</p>
              </div>
            </div>

            <!-- 电子邮箱 -->
            <div class="contact-item">
              <div class="contact-icon">✉️</div>
              <div class="contact-details">
                <h3>电子邮箱</h3>
                <p>{{ about.email }}</p>
              </div>
            </div>
          </div>

          <!-- 留言反馈 -->
          <div class="contact-form">
            <h3>留言反馈</h3>
            <el-form :model="form" label-position="top">
              <el-form-item label="姓名" prop="name">
                <el-input v-model="form.name"
                          placeholder="请输入姓名"/>
              </el-form-item>

              <el-form-item label="邮箱" prop="email">
                <el-input v-model="form.email"
                          placeholder="请输入邮箱"/>
              </el-form-item>

              <el-form-item label="留言内容" prop="message">
                <el-input v-model="form.message"
                          type="textarea"
                          placeholder="请输入您的留言内容"/>
              </el-form-item>

              <!-- 提交按钮 -->
              <el-form-item>
                <el-button type="primary" @click="submitContact">
                  提交留言
                </el-button>
              </el-form-item>
            </el-form>
          </div>

        </div>
      </div>

    </div>
  </div>
</template>

<script setup>
import {onMounted, ref} from 'vue'
import {selectCurrentAbout} from "@/api/ich/about.js";
import {ElMessage} from "element-plus";
import {addContact} from "@/api/ich/contact.js";
import {getImageUrl} from "@/utils/validate";

const baseUrl = import.meta.env.VITE_APP_BASE_API

//关于我们数据
const about = ref({})

onMounted(() => {
  selectCurrentAbout().then(res => {
    about.value = res.data
  })
})

//提交留言反馈
const submitContact = () => {
  //表单验证
  if (!form.value.name || !form.value.email || !form.value.message) {
    ElMessage.warning('请填写完整信息')
    return
  }

  //调用API提交表单
  addContact(form.value).then(res => {
    ElMessage.success('留言提交成功,我们会尽快回复您!')
    //重置表单
    form.value = {
      name: '',
      email: '',
      message: ''
    }
  })
}

//表单参数
const form = ref({
  name: '',
  email: '',
  message: ''
})

</script>

<style scoped>
/* 页面主容器样式 */
.about-page {
  width: 100%; /* 宽度100% */
}

/* 内容区域容器 */
.section-container {
  max-width: 1200px; /* 最大宽度限制 */
  margin: 0 auto; /* 水平居中 */
  padding: 20px; /* 内边距 */
}

/* 通用标题样式 */
.section-title {
  font-size: 28px; /* 字体大小 */
  font-weight: bold; /* 字体粗细 */
  text-align: center; /* 文本居中 */
  margin-bottom: 40px; /* 底部外边距 */
  color: #333; /* 字体颜色 */
  position: relative; /* 相对定位，用于伪元素定位 */
}

/* 标题下划线伪元素 */
.section-title::after {
  content: ''; /* 必须内容 */
  display: block; /* 块级显示 */
  width: 60px; /* 宽度 */
  height: 4px; /* 高度 */
  background: linear-gradient(90deg, #3a7bd5, #00d2ff); /* 渐变背景 */
  margin: 15px auto 0; /* 外边距：上 左右 下 */
  border-radius: 2px; /* 圆角 */
}

/* 系统介绍区域样式 */
.intro-section {
  display: flex; /* 弹性布局 */
  align-items: center; /* 垂直居中 */
  gap: 40px; /* 子元素间距 */
  margin-bottom: 60px; /* 底部外边距 */
  background: white; /* 背景色 */
  padding: 40px; /* 内边距 */
  border-radius: 15px; /* 圆角 */
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); /* 阴影效果 */
}

/* 介绍内容区域 */
.intro-content {
  flex: 1; /* 弹性比例1，占剩余空间 */
}

/* 介绍文本样式 */
.intro-text {
  font-size: 16px; /* 字体大小 */
  line-height: 1.8; /* 行高 */
  color: #666; /* 字体颜色 */
  margin-bottom: 20px; /* 底部外边距 */
}

/* 最后一个介绍文本去掉底部外边距 */
.intro-text:last-child {
  margin-bottom: 0;
}

/* 介绍图片区域 */
.intro-image {
  flex: 1; /* 弹性比例1，与内容区域等宽 */
  border-radius: 10px; /* 圆角 */
  overflow: hidden; /* 溢出隐藏 */
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15); /* 阴影效果 */
}

/* 介绍图片样式 */
.intro-image img {
  width: 100%; /* 宽度100% */
  height: auto; /* 高度自适应 */
  display: block; /* 块级显示 */
}

/* 使命愿景区域样式 */
.mission-section {
  display: grid; /* 网格布局 */
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); /* 自适应列，最小300px */
  gap: 30px; /* 网格间距 */
  margin-bottom: 60px; /* 底部外边距 */
}

/* 使命卡片样式 */
.mission-card {
  background: white; /* 背景色 */
  padding: 30px; /* 内边距 */
  border-radius: 15px; /* 圆角 */
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); /* 阴影效果 */
  text-align: center; /* 文本居中 */
  transition: all 0.3s ease; /* 过渡效果 */
}

/* 卡片悬停效果 */
.mission-card:hover {
  transform: translateY(-10px); /* 向上移动 */
  box-shadow: 0 12px 30px rgba(0, 0, 0, 0.15); /* 加深阴影 */
}

/* 使命图标样式 */
.mission-icon {
  font-size: 48px; /* 字体大小 */
  margin-bottom: 20px; /* 底部外边距 */
}

/* 使命标题样式 */
.mission-title {
  font-size: 22px; /* 字体大小 */
  font-weight: bold; /* 字体粗细 */
  margin-bottom: 15px; /* 底部外边距 */
  color: #333; /* 字体颜色 */
}

/* 使命文本样式 */
.mission-text {
  font-size: 16px; /* 字体大小 */
  line-height: 1.7; /* 行高 */
  color: #666; /* 字体颜色 */
}

/* 联系我们区域样式 */
.contact-section {
  margin-bottom: 60px; /* 底部外边距 */
}

/* 联系内容布局 */
.contact-content {
  display: grid; /* 网格布局 */
  grid-template-columns: 1fr 1fr; /* 两列等宽 */
  gap: 40px; /* 列间距 */
}

/* 联系项样式 */
.contact-item {
  display: flex; /* 弹性布局 */
  align-items: flex-start; /* 顶部对齐 */
  margin-bottom: 30px; /* 底部外边距 */
}

/* 最后一个联系项去掉底部外边距 */
.contact-item:last-child {
  margin-bottom: 0;
}

/* 联系图标样式 */
.contact-icon {
  font-size: 28px; /* 字体大小 */
  margin-right: 20px; /* 右侧外边距 */
  flex-shrink: 0; /* 禁止收缩 */
}

/* 联系详情标题样式 */
.contact-details h3 {
  font-size: 18px; /* 字体大小 */
  font-weight: bold; /* 字体粗细 */
  margin: 0 0 10px 0; /* 外边距 */
  color: #333; /* 字体颜色 */
}

/* 联系详情文本样式 */
.contact-details p {
  font-size: 16px; /* 字体大小 */
  color: #666; /* 字体颜色 */
  margin: 0; /* 外边距清零 */
}

/* 联系表单样式 */
.contact-form {
  background: white; /* 背景色 */
  padding: 30px; /* 内边距 */
  border-radius: 15px; /* 圆角 */
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); /* 阴影效果 */
}

/* 联系表单标题样式 */
.contact-form h3 {
  font-size: 20px; /* 字体大小 */
  font-weight: bold; /* 字体粗细 */
  margin: 0 0 20px 0; /* 外边距 */
  color: #333; /* 字体颜色 */
}

/* 深度选择器：修改Element Plus表单项样式 */
:deep(.el-form-item) {
  margin-bottom: 20px; /* 底部外边距 */
}

/* 深度选择器：修改Element Plus表单标签样式 */
:deep(.el-form-item__label) {
  font-weight: 500; /* 字体粗细 */
  color: #333; /* 字体颜色 */
}
</style>
