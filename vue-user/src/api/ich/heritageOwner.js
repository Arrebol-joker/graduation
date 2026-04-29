import request from '@/utils/request'

export function listOwnerHeritage(query) {
  return request({
    url: '/heritage/owner/list',
    method: 'get',
    params: query
  })
}

export function getOwnerHeritage(heritageId) {
  return request({
    url: '/heritage/owner/' + heritageId,
    method: 'get'
  })
}

export function addOwnerHeritage(data) {
  return request({
    url: '/heritage/owner',
    method: 'post',
    data: data
  })
}

export function updateOwnerHeritage(data) {
  return request({
    url: '/heritage/owner',
    method: 'put',
    data: data
  })
}

export function delOwnerHeritage(heritageIds) {
  return request({
    url: '/heritage/owner/' + heritageIds,
    method: 'delete'
  })
}

export function submitOwnerHeritage(heritageId) {
  return request({
    url: '/heritage/owner/submit/' + heritageId,
    method: 'put'
  })
}

export function getOwnerStats() {
  return request({
    url: '/heritage/owner/stats',
    method: 'get'
  })
}
