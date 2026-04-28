import request from '@/utils/request'

export function listComment(query) {
  return request({
    url: '/ich/comment/list',
    method: 'get',
    params: query
  })
}

export function getComment(commentId) {
  return request({
    url: '/ich/comment/' + commentId,
    method: 'get'
  })
}

export function getCommentsByTargetId(targetId) {
  return request({
    url: '/ich/comment/target/' + targetId,
    method: 'get'
  })
}

export function addComment(data) {
  return request({
    url: '/ich/comment',
    method: 'post',
    data: data
  })
}

export function updateComment(data) {
  return request({
    url: '/ich/comment',
    method: 'put',
    data: data
  })
}

export function delComment(commentId) {
  return request({
    url: '/ich/comment/' + commentId,
    method: 'delete'
  })
}
