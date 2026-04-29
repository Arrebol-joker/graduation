<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="用户名" prop="userName">
        <el-input
            v-model="queryParams.userName"
            placeholder="请输入用户名"
            clearable
            @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="IP地址" prop="ipaddr">
        <el-input
            v-model="queryParams.ipaddr"
            placeholder="请输入登录IP"
            clearable
            @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-table ref="table" border v-loading="loading" :data="onlineList">
      <el-table-column label="用户名" align="center" prop="userName" width="120"/>
      <el-table-column label="昵称" align="center" prop="nickName" width="120"/>
      <el-table-column label="登录IP" align="center" prop="ipaddr" width="140"/>
      <el-table-column label="登录地点" align="center" prop="loginLocation" width="150" show-overflow-tooltip/>
      <el-table-column label="浏览器" align="center" prop="browser" width="120"/>
      <el-table-column label="操作系统" align="center" prop="os" width="100"/>
      <el-table-column label="登录时间" align="center" prop="loginTime" width="170"/>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="120">
        <template #default="scope">
          <el-button
              link
              type="danger"
              icon="Delete"
              @click="handleForceLogout(scope.row)"
              v-hasPermi="['system:online:forceLogout']"
          >强退</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
        v-show="total>0"
        :total="total"
        v-model:page="queryParams.pageNum"
        v-model:limit="queryParams.pageSize"
        @pagination="getList"
    />

  </div>
</template>

<script setup name="Online">
import {listOnline, forceLogout} from "@/api/system/online"

const {proxy} = getCurrentInstance()

const onlineList = ref([])
const loading = ref(true)
const showSearch = ref(true)
const total = ref(0)

const data = reactive({
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    userName: null,
    ipaddr: null,
  },
})

const {queryParams} = toRefs(data)

const getList = () => {
  loading.value = true
  listOnline(queryParams.value).then(response => {
    onlineList.value = response.rows
    total.value = response.total
    loading.value = false
  })
}

const handleQuery = () => {
  queryParams.value.pageNum = 1
  getList()
}

const resetQuery = () => {
  proxy.resetForm("queryRef")
  handleQuery()
}

const handleForceLogout = (row) => {
  proxy.$modal.confirm('是否确认强退用户【' + row.userName + '】？').then(function () {
    return forceLogout(row.tokenId)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("强退成功")
  }).catch(() => {})
}

getList()
</script>
