import request from '@/utils/request'

export function listComment(targetId, type) {
  return request({
    url: '/comment/list',
    method: 'get',
    params: { targetId, type }
  })
}

export function addComment(data) {
  return request({
    url: '/comment/add',
    method: 'post',
    data: data
  })
}

export function delComment(id) {
  return request({
    url: '/comment/delete/' + id,
    method: 'delete'
  })
}

export function adminPageComment(query) {
  return request({
    url: '/admin/comment/page',
    method: 'get',
    params: query
  })
}

export function adminGetComment(id) {
  return request({
    url: '/admin/comment/' + id,
    method: 'get'
  })
}

export function adminAddComment(data) {
  return request({
    url: '/admin/comment',
    method: 'post',
    data: data
  })
}

export function adminUpdateComment(data) {
  return request({
    url: '/admin/comment',
    method: 'put',
    data: data
  })
}

export function adminDelComment(ids) {
  return request({
    url: '/admin/comment/' + ids,
    method: 'delete'
  })
}
