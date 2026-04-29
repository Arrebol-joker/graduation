<template>
  <div class="my-projects">
    <el-table :data="projectList" style="width: 100%" v-loading="loading">
      <el-table-column label="项目名称" prop="name" min-width="180" show-overflow-tooltip/>
      <el-table-column label="类别" prop="categoryName" width="140" align="center"/>
      <el-table-column label="提交时间" prop="createTime" width="180" align="center"/>
      <el-table-column label="审核状态" width="120" align="center">
        <template #default="scope">
          <el-tag v-if="scope.row.status === 0" type="primary" size="small">待审核</el-tag>
          <el-tag v-else-if="scope.row.status === 1" type="success" size="small">已通过</el-tag>
          <el-tag v-else-if="scope.row.status === 2" type="danger" size="small">已驳回</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="100" align="center">
        <template #default="scope">
          <el-button type="primary" link size="small" @click="handleView(scope.row)">查看</el-button>
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
import {listProject} from '@/api/ich/project.js'
import {useRouter} from 'vue-router'
import useUserStore from '@/store/modules/user.js'

const router = useRouter()
const userStore = useUserStore()

const loading = ref(false)
const projectList = ref([])
const total = ref(0)
const query = ref({
  pageNum: 1,
  pageSize: 10,
  userId: userStore.id,
})

const getList = () => {
  loading.value = true
  listProject(query.value).then(res => {
    projectList.value = res.rows
    total.value = res.total
    loading.value = false
  }).catch(() => {
    loading.value = false
  })
}

const handleView = (row) => {
  router.push('/index/heritageDetail/' + row.projectId)
}

onMounted(() => {
  getList()
})
</script>

<style scoped>
.my-projects {
  padding: 10px 0;
}
</style>
