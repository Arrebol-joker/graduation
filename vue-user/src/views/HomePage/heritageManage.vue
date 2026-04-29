<template>
  <div class="heritage-manage-container">
    <el-card class="stats-card">
      <div class="stats-row">
        <div class="stat-item">
          <div class="stat-num warning">{{ stats.draft }}</div>
          <div class="stat-label">待申报</div>
        </div>
        <div class="stat-item">
          <div class="stat-num">{{ stats.pending }}</div>
          <div class="stat-label">待审核</div>
        </div>
        <div class="stat-item">
          <div class="stat-num success">{{ stats.approved }}</div>
          <div class="stat-label">申报成功</div>
        </div>
        <div class="stat-item">
          <div class="stat-num danger">{{ stats.rejected }}</div>
          <div class="stat-label">申报失败</div>
        </div>
      </div>
    </el-card>

    <el-card class="list-card">
      <template #header>
        <div class="card-header">
          <span>我的非遗项目</span>
          <el-button type="primary" @click="handleAdd">新增申报</el-button>
        </div>
      </template>

      <div class="search-bar">
        <el-input v-model="keyword" placeholder="搜索项目名称" clearable style="width: 300px" @keyup.enter="handleSearch"/>
        <el-select v-model="statusFilter" placeholder="按状态筛选" clearable style="width: 150px" @change="handleSearch">
          <el-option label="全部" value=""/>
          <el-option label="待申报" value="0"/>
          <el-option label="待审核" value="1"/>
          <el-option label="申报成功" value="2"/>
          <el-option label="申报失败" value="3"/>
        </el-select>
        <el-button type="primary" icon="Search" @click="handleSearch">搜索</el-button>
        <el-button icon="Refresh" @click="handleReset">重置</el-button>
      </div>

      <el-table :data="list" border stripe v-loading="loading">
        <el-table-column type="index" label="序号" width="60"/>
        <el-table-column prop="title" label="项目名称" min-width="180"/>
        <el-table-column prop="category" label="分类" width="120"/>
        <el-table-column label="申报状态" width="120">
          <template #default="scope">
            <el-tag v-if="scope.row.heritageStatus === '0'" type="warning">待申报</el-tag>
            <el-tag v-else-if="scope.row.heritageStatus === '1'" type="primary">待审核</el-tag>
            <el-tag v-else-if="scope.row.heritageStatus === '2'" type="success">申报成功</el-tag>
            <el-tag v-else-if="scope.row.heritageStatus === '3'" type="danger">申报失败</el-tag>
            <el-tag v-else type="info">未知</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="createTime" label="创建时间" width="180"/>
        <el-table-column label="操作" width="260" fixed="right">
          <template #default="scope">
            <el-button link type="primary" @click="handleView(scope.row)">查看</el-button>
            <el-button link type="primary" :disabled="scope.row.heritageStatus !== '0'" @click="handleEdit(scope.row)">修改</el-button>
            <el-button v-if="scope.row.heritageStatus === '0'" link type="success" icon="Upload" @click="handleSubmit(scope.row)">提交申报</el-button>
            <el-button link type="danger" :disabled="scope.row.heritageStatus !== '0'" @click="handleDelete(scope.row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>

      <pagination v-show="total > 0" :total="total" v-model:page="pageNum" v-model:limit="pageSize" @pagination="getList"/>
    </el-card>

    <el-dialog v-model="dialogOpen" :title="dialogTitle" width="700px">
      <el-form ref="formRef" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="项目名称" prop="title">
          <el-input v-model="form.title" placeholder="请输入项目名称"/>
        </el-form-item>
        <el-form-item label="项目简介" prop="description">
          <el-input v-model="form.description" type="textarea" :rows="3" placeholder="请输入项目简介"/>
        </el-form-item>
        <el-form-item label="详细介绍" prop="detailDescription">
          <el-input v-model="form.detailDescription" type="textarea" :rows="4" placeholder="请输入详细介绍"/>
        </el-form-item>
        <el-form-item label="所在地" prop="location">
          <el-input v-model="form.location" placeholder="请输入所在地"/>
        </el-form-item>
        <el-form-item label="类别" prop="category">
          <el-input v-model="form.category" placeholder="请输入类别"/>
        </el-form-item>
        <el-form-item label="传承状态" prop="status">
          <el-select v-model="form.status" placeholder="请选择传承状态">
            <el-option label="良好" value="良好"/>
            <el-option label="一般" value="一般"/>
            <el-option label="濒危" value="濒危"/>
          </el-select>
        </el-form-item>
        <el-form-item label="图片" prop="image">
          <image-upload v-model="form.image"/>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogOpen = false">取消</el-button>
        <el-button type="primary" @click="submitForm">确 定</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import {reactive, ref, onMounted} from 'vue'
import {ElMessage, ElMessageBox} from 'element-plus'
import {listOwnerHeritage, getOwnerHeritage, addOwnerHeritage, updateOwnerHeritage, delOwnerHeritage, submitOwnerHeritage, getOwnerStats} from "@/api/ich/heritageOwner.js"
import ImageUpload from "@/components/ImageUpload/index.vue";

const list = ref([])
const total = ref(0)
const pageNum = ref(1)
const pageSize = ref(10)
const loading = ref(false)
const keyword = ref('')
const statusFilter = ref('')
const dialogOpen = ref(false)
const dialogTitle = ref('')
const formRef = ref(null)
const stats = reactive({draft: 0, pending: 0, approved: 0, rejected: 0})
const isEdit = ref(false)

const form = reactive({
  heritageId: null,
  title: null,
  description: null,
  detailDescription: null,
  image: null,
  location: null,
  category: null,
  status: null,
})

const rules = reactive({
  title: [{required: true, message: '项目名称不能为空', trigger: 'blur'}],
  description: [{required: true, message: '项目简介不能为空', trigger: 'blur'}],
  location: [{required: true, message: '所在地不能为空', trigger: 'blur'}],
  category: [{required: true, message: '类别不能为空', trigger: 'blur'}],
  status: [{required: true, message: '传承状态不能为空', trigger: 'change'}],
})

const getList = () => {
  loading.value = true
  const params = {
    pageNum: pageNum.value,
    pageSize: pageSize.value,
  }
  if (keyword.value) params.keyword = keyword.value
  if (statusFilter.value) params.heritageStatus = statusFilter.value
  listOwnerHeritage(params).then(res => {
    list.value = res.rows
    total.value = res.total
    loading.value = false
  })
}

const loadStats = () => {
  getOwnerStats().then(res => {
    const data = res.data
    stats.draft = data[0]
    stats.pending = data[1]
    stats.approved = data[2]
    stats.rejected = data[3]
  })
}

const handleSearch = () => {
  pageNum.value = 1
  getList()
}

const handleReset = () => {
  keyword.value = ''
  statusFilter.value = ''
  pageNum.value = 1
  getList()
}

const handleAdd = () => {
  isEdit.value = false
  dialogTitle.value = '新增申报'
  form.heritageId = null
  form.title = null
  form.description = null
  form.detailDescription = null
  form.image = null
  form.location = null
  form.category = null
  form.status = null
  dialogOpen.value = true
}

const handleEdit = (row) => {
  isEdit.value = true
  dialogTitle.value = '修改项目'
  getOwnerHeritage(row.heritageId).then(res => {
    const d = res.data
    form.heritageId = d.heritageId
    form.title = d.title
    form.description = d.description
    form.detailDescription = d.detailDescription
    form.image = d.image
    form.location = d.location
    form.category = d.category
    form.status = d.status
  })
  dialogOpen.value = true
}

const handleView = (row) => {
  window.open('/index/heritageDetail/' + row.heritageId, '_blank')
}

const handleSubmit = (row) => {
  ElMessageBox.confirm('确认提交该非遗项目进行审核吗？', '提示', {type: 'info'}).then(() => {
    submitOwnerHeritage(row.heritageId).then(() => {
      ElMessage.success('提交成功，等待审核')
      getList()
      loadStats()
    })
  }).catch(() => {})
}

const handleDelete = (row) => {
  ElMessageBox.confirm('确认删除该项目吗？', '提示', {type: 'warning'}).then(() => {
    delOwnerHeritage(row.heritageId).then(() => {
      ElMessage.success('删除成功')
      getList()
      loadStats()
    })
  }).catch(() => {})
}

const submitForm = () => {
  formRef.value.validate(valid => {
    if (valid) {
      if (isEdit.value) {
        updateOwnerHeritage(form).then(() => {
          ElMessage.success('修改成功')
          dialogOpen.value = false
          getList()
        })
      } else {
        addOwnerHeritage(form).then(() => {
          ElMessage.success('申报成功，请提交审核')
          dialogOpen.value = false
          getList()
          loadStats()
        })
      }
    }
  })
}

onMounted(() => {
  getList()
  loadStats()
})
</script>

<style scoped>
.heritage-manage-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
}
.stats-card {
  margin-bottom: 20px;
}
.stats-row {
  display: flex;
  justify-content: space-around;
  text-align: center;
}
.stat-item {
  flex: 1;
  padding: 10px;
}
.stat-num {
  font-size: 36px;
  font-weight: bold;
  color: #409EFF;
}
.stat-num.warning {
  color: #E6A23C;
}
.stat-num.success {
  color: #67C23A;
}
.stat-num.danger {
  color: #F56C6C;
}
.stat-label {
  margin-top: 5px;
  color: #666;
  font-size: 14px;
}
.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.search-bar {
  display: flex;
  gap: 10px;
  margin-bottom: 15px;
  align-items: center;
}
</style>
