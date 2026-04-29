<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="模块名称" prop="title">
        <el-input
            v-model="queryParams.title"
            placeholder="请输入模块名称"
            clearable
            @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="操作人员" prop="operName">
        <el-input
            v-model="queryParams.operName"
            placeholder="请输入操作人员"
            clearable
            @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择" clearable style="width: 200px">
          <el-option label="正常" :value="0"/>
          <el-option label="异常" :value="1"/>
        </el-select>
      </el-form-item>
      <el-form-item label="操作时间">
        <el-date-picker
            v-model="dateRange"
            value-format="YYYY-MM-DD"
            type="daterange"
            range-separator="-"
            start-placeholder="开始日期"
            end-placeholder="结束日期"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
            type="danger"
            plain
            icon="Delete"
            :disabled="multiple"
            @click="handleDelete"
            v-hasPermi="['system:operlog:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
            type="danger"
            plain
            icon="Delete"
            @click="handleClean"
            v-hasPermi="['system:operlog:remove']"
        >清空</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table ref="table" border v-loading="loading" :data="operLogList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center"/>
      <el-table-column label="日志编号" align="center" prop="operId" width="80"/>
      <el-table-column label="模块名称" align="center" prop="title" width="120"/>
      <el-table-column label="业务类型" align="center" prop="businessType" width="100">
        <template #default="scope">
          <span>{{ businessTypeLabels[scope.row.businessType] || '其他' }}</span>
        </template>
      </el-table-column>
      <el-table-column label="请求方式" align="center" prop="requestMethod" width="80"/>
      <el-table-column label="操作人员" align="center" prop="operName" width="100"/>
      <el-table-column label="操作IP" align="center" prop="operIp" width="130"/>
      <el-table-column label="操作地点" align="center" prop="operLocation" width="100" show-overflow-tooltip/>
      <el-table-column label="状态" align="center" prop="status" width="80">
        <template #default="scope">
          <el-tag v-if="scope.row.status === 0" type="success">正常</el-tag>
          <el-tag v-if="scope.row.status === 1" type="danger">异常</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作时间" align="center" prop="operTime" width="170"/>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="100">
        <template #default="scope">
          <el-button link type="primary" icon="View" @click="handleDetail(scope.row)" v-hasPermi="['system:operlog:query']">详情</el-button>
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

    <vxe-modal title="操作日志详情" v-model="detailOpen" width="600px" showFooter resize>
      <el-descriptions :column="1" border>
        <el-descriptions-item label="日志编号">{{ detail.operId }}</el-descriptions-item>
        <el-descriptions-item label="模块名称">{{ detail.title }}</el-descriptions-item>
        <el-descriptions-item label="业务类型">{{ businessTypeLabels[detail.businessType] || '其他' }}</el-descriptions-item>
        <el-descriptions-item label="请求方式">{{ detail.requestMethod }}</el-descriptions-item>
        <el-descriptions-item label="请求方法">{{ detail.method }}</el-descriptions-item>
        <el-descriptions-item label="操作人员">{{ detail.operName }}</el-descriptions-item>
        <el-descriptions-item label="操作IP">{{ detail.operIp }}</el-descriptions-item>
        <el-descriptions-item label="操作地点">{{ detail.operLocation }}</el-descriptions-item>
        <el-descriptions-item label="请求URL">{{ detail.operUrl }}</el-descriptions-item>
        <el-descriptions-item label="请求参数">
          <div style="white-space: pre-wrap; word-break: break-all;">{{ detail.operParam || '无' }}</div>
        </el-descriptions-item>
        <el-descriptions-item label="返回参数">
          <div style="white-space: pre-wrap; word-break: break-all;">{{ detail.jsonResult || '无' }}</div>
        </el-descriptions-item>
        <el-descriptions-item label="状态">
          <el-tag v-if="detail.status === 0" type="success">正常</el-tag>
          <el-tag v-if="detail.status === 1" type="danger">异常</el-tag>
        </el-descriptions-item>
        <el-descriptions-item label="错误消息">
          <span style="color: red;">{{ detail.errorMsg || '无' }}</span>
        </el-descriptions-item>
        <el-descriptions-item label="操作时间">{{ detail.operTime }}</el-descriptions-item>
      </el-descriptions>
      <template #footer>
        <div class="dialog-footer">
          <el-button @click="detailOpen = false">关 闭</el-button>
        </div>
      </template>
    </vxe-modal>

  </div>
</template>

<script setup name="OperLog">
import {pageOperLog, getOperLog, delOperLog, cleanOperLog} from "@/api/system/operlog"

const {proxy} = getCurrentInstance()

const operLogList = ref([])
const open = ref(false)
const loading = ref(true)
const showSearch = ref(true)
const ids = ref([])
const single = ref(true)
const multiple = ref(true)
const total = ref(0)
const title = ref("")
const dateRange = ref([])
const detailOpen = ref(false)
const detail = ref({})

const businessTypeLabels = {
  0: '其他',
  1: '新增',
  2: '修改',
  3: '删除',
  4: '授权',
  5: '导出',
  6: '导入',
  7: '强退',
  8: '生成代码',
  9: '清空',
}

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    title: null,
    operName: null,
    status: null,
  },
})

const {queryParams, form} = toRefs(data)

const getList = () => {
  loading.value = true
  const params = {...queryParams.value}
  if (dateRange.value && dateRange.value.length > 0) {
    params.beginTime = dateRange.value[0]
    params.endTime = dateRange.value[1]
  }
  pageOperLog(params).then(response => {
    operLogList.value = response.rows
    total.value = response.total
    loading.value = false
  })
}

const handleQuery = () => {
  queryParams.value.pageNum = 1
  getList()
}

const resetQuery = () => {
  dateRange.value = []
  proxy.resetForm("queryRef")
  handleQuery()
}

const handleSelectionChange = (selection) => {
  ids.value = selection.map(item => item.operId)
  single.value = selection.length != 1
  multiple.value = !selection.length
}

const handleDelete = (row) => {
  const _ids = row.operId || ids.value
  proxy.$modal.confirm('是否确认删除所选操作日志？').then(function () {
    return delOperLog(_ids)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

const handleClean = () => {
  proxy.$modal.confirm('是否确认清空所有操作日志？').then(function () {
    return cleanOperLog()
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("清空成功")
  }).catch(() => {})
}

const handleDetail = (row) => {
  getOperLog(row.operId).then(response => {
    detail.value = response.data
    detailOpen.value = true
  })
}

getList()
</script>
