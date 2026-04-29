<template>
  <div class="my-comments">
    <div class="filter-bar">
      <el-select v-model="query.type" placeholder="评论类型" clearable style="width: 160px" @change="handleSearch">
        <el-option label="全部类型" :value="null"/>
        <el-option label="非遗评论" :value="1"/>
        <el-option label="新闻评论" :value="2"/>
      </el-select>
    </div>

    <el-table :data="commentList" style="width: 100%" v-loading="loading">
      <el-table-column label="评论内容" prop="content" min-width="200" show-overflow-tooltip/>
      <el-table-column label="评论类型" width="120" align="center">
        <template #default="scope">
          <el-tag v-if="scope.row.type === 1" type="warning" size="small">非遗评论</el-tag>
          <el-tag v-else-if="scope.row.type === 2" type="primary" size="small">新闻评论</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="关联对象" prop="targetName" min-width="150" show-overflow-tooltip/>
      <el-table-column label="评论时间" prop="createTime" width="180" align="center"/>
      <el-table-column label="操作" width="100" align="center">
        <template #default="scope">
          <el-button type="danger" link size="small" @click="handleDelete(scope.row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
        v-show="total > 0"
        :total="total"
        v-model:page="query.pageNum"
        v-model:limit="query.pageSize"
        @pagination="getList"
        :pageSizes="[10, 20, 30, 50]"
    />
  </div>
</template>

<script setup>
import {ref, onMounted} from 'vue'
import {listMyComments, deleteComment} from '@/api/ich/comment.js'
import {ElMessage, ElMessageBox} from 'element-plus'

const loading = ref(false)
const commentList = ref([])
const total = ref(0)
const query = ref({
  pageNum: 1,
  pageSize: 10,
  type: null,
})

const getList = () => {
  loading.value = true
  listMyComments(query.value).then(res => {
    commentList.value = res.rows
    total.value = res.total
    loading.value = false
  }).catch(() => {
    loading.value = false
  })
}

const handleSearch = () => {
  query.value.pageNum = 1
  getList()
}

const handleDelete = (row) => {
  ElMessageBox.confirm('确定删除该评论吗？删除后不可恢复。', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  }).then(() => {
    deleteComment(row.id).then(() => {
      ElMessage.success('删除成功')
      getList()
    })
  }).catch(() => {})
}

onMounted(() => {
  getList()
})
</script>

<style scoped>
.my-comments {
  padding: 10px 0;
}

.filter-bar {
  margin-bottom: 20px;
  display: flex;
  align-items: center;
  gap: 12px;
}
</style>
