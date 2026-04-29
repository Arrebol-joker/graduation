import request from '@/utils/request'

export function pageOperLog(query) {
  return request({
    url: '/system/operlog/page',
    method: 'get',
    params: query
  })
}

export function getOperLog(operId) {
  return request({
    url: '/system/operlog/' + operId,
    method: 'get'
  })
}

export function delOperLog(operIds) {
  return request({
    url: '/system/operlog/' + operIds,
    method: 'delete'
  })
}

export function cleanOperLog() {
  return request({
    url: '/system/operlog/clean',
    method: 'delete'
  })
}
