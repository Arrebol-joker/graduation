import request from '@/utils/request'

export function listOnline(query) {
  return request({
    url: '/system/online/list',
    method: 'get',
    params: query
  })
}

export function forceLogout(tokenId) {
  return request({
    url: '/system/online/' + tokenId,
    method: 'delete'
  })
}
