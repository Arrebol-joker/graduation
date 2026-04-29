import request from '@/utils/request'

export function addComment(data) {
  return request({
    url: '/comment/add',
    method: 'post',
    data: data
  })
}

export function listComment(targetId, type) {
  return request({
    url: '/comment/list',
    method: 'get',
    params: { targetId, type }
  })
}

export function listMyComments(query) {
  return request({
    url: '/comment/myComments',
    method: 'get',
    params: query
  })
}

export function deleteComment(id) {
  return request({
    url: '/comment/delete/' + id,
    method: 'delete'
  })
}
