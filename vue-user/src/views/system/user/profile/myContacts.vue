<template>
  <div class="my-contacts">
    <el-table :data="contactList" style="width: 100%" v-loading="loading">
      <el-table-column label="姓名" prop="name" width="120"/>
      <el-table-column label="邮箱" prop="email" min-width="180" show-overflow-tooltip/>
      <el-table-column label="留言内容" prop="message" min-width="250" show-overflow-tooltip/>
      <el-table-column label="留言时间" prop="createTime" width="180" align="center"/>
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
import {listContact, delContact} from '@/api/ich/contact.js'
import {ElMessage, ElMessageBox} from 'element-plus'
import useUserStore from '@/store/modules/user.js'

const userStore = useUserStore()

const loading = ref(false)
const contactList = ref([])
const total = ref(0)
const query = ref({
  pageNum: 1,
  pageSize: 10,
  userId: userStore.id,
})

const getList = () => {
  loading.value = true
  listContact(query.value).then(res => {
    contactList.value = res.rows
    total.value = res.total
    loading.value = false
  }).catch(() => {
    loading.value = false
  })
}

const handleDelete = (row) => {
  ElMessageBox.confirm('确定删除该留言吗？删除后不可恢复。', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  }).then(() => {
    delContact(row.contactId).then(() => {
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
.my-contacts {
  padding: 10px 0;
}
</style>
