import request from '@/utils/request'

export function selectHomeCount() {
  return request({
    url: '/home/page/selectHomeCount',
    method: 'get'
  })
}
