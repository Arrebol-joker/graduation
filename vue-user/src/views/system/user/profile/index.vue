<template>
   <div class="app-container">
      <el-row :gutter="20">
         <el-col :span="6" :xs="24">
            <el-card class="box-card">
               <template v-slot:header>
                 <div class="clearfix">
                   <span>个人信息</span>
                 </div>
               </template>
               <div>
                  <div class="text-center">
                     <userAvatar />
                  </div>
                  <ul class="list-group list-group-striped">
                     <li class="list-group-item">
                        <svg-icon icon-class="user" />用户名称
                        <div class="pull-right">{{ state.user.userName }}</div>
                     </li>
                     <li class="list-group-item">
                        <svg-icon icon-class="user" />用户类型
                        <div class="pull-right">
                          <el-tag v-if="state.user.accountType === '1'" type="success" size="small">传承人</el-tag>
                          <el-tag v-else type="info" size="small">普通用户</el-tag>
                        </div>
                     </li>
                     <li class="list-group-item">
                        <svg-icon icon-class="phone" />手机号码
                        <div class="pull-right">{{ state.user.phonenumber }}</div>
                     </li>
                     <li class="list-group-item">
                        <svg-icon icon-class="email" />用户邮箱
                        <div class="pull-right">{{ state.user.email }}</div>
                     </li>
                     <li class="list-group-item">
                        <svg-icon icon-class="date" />创建日期
                        <div class="pull-right">{{ state.user.createTime }}</div>
                     </li>
                  </ul>
               </div>
            </el-card>

            <el-card class="box-card" style="margin-top: 20px">
               <template v-slot:header>
                 <div class="clearfix">
                   <span>功能菜单</span>
                 </div>
               </template>
               <el-menu :default-active="activeMenu" class="profile-menu" @select="handleMenuSelect">
                  <el-menu-item index="userinfo">
                     <el-icon><User/></el-icon>
                     <span>基本资料</span>
                  </el-menu-item>
                  <el-menu-item index="resetPwd">
                     <el-icon><Lock/></el-icon>
                     <span>修改密码</span>
                  </el-menu-item>
                  <el-menu-item index="myComments">
                     <el-icon><ChatDotSquare/></el-icon>
                     <span>我的评论</span>
                  </el-menu-item>
                  <el-menu-item index="myProjects">
                     <el-icon><Folder/></el-icon>
                     <span>申报记录</span>
                  </el-menu-item>
                  <el-menu-item index="myContacts">
                     <el-icon><Message/></el-icon>
                     <span>我的留言</span>
                  </el-menu-item>
               </el-menu>
            </el-card>
         </el-col>
         <el-col :span="18" :xs="24">
            <el-card>
               <template v-slot:header>
                 <div class="clearfix">
                   <span>{{ menuTitle }}</span>
                 </div>
               </template>
               <div v-if="activeMenu === 'userinfo'">
                  <userInfo :user="state.user" />
               </div>
               <div v-else-if="activeMenu === 'resetPwd'">
                  <resetPwd />
               </div>
               <div v-else-if="activeMenu === 'myComments'">
                  <myComments />
               </div>
               <div v-else-if="activeMenu === 'myProjects'">
                  <myProjects />
               </div>
               <div v-else-if="activeMenu === 'myContacts'">
                  <myContacts />
               </div>
            </el-card>
         </el-col>
      </el-row>
   </div>
</template>

<script setup name="Profile">
import userAvatar from "./userAvatar"
import userInfo from "./userInfo"
import resetPwd from "./resetPwd"
import myComments from "./myComments"
import myProjects from "./myProjects"
import myContacts from "./myContacts"
import { getUserProfile } from "@/api/system/user"
import {ChatDotSquare, Folder, Lock, Message, User} from "@element-plus/icons-vue"

const activeMenu = ref("userinfo")

const menuTitle = computed(() => {
  const titles = {
    userinfo: '基本资料',
    resetPwd: '修改密码',
    myComments: '我的评论',
    myProjects: '申报记录',
    myContacts: '我的留言',
  }
  return titles[activeMenu.value] || '基本资料'
})

const state = reactive({
  user: {},
  roleGroup: {},
  postGroup: {}
})

const handleMenuSelect = (index) => {
  activeMenu.value = index
}

function getUser() {
  getUserProfile().then(response => {
    state.user = response.data
    state.roleGroup = response.roleGroup
    state.postGroup = response.postGroup
  })
}

getUser()
</script>

<style scoped>
.profile-menu {
  border-right: none;
}

.profile-menu .el-menu-item {
  border-radius: 8px;
  margin-bottom: 4px;
  height: 44px;
  line-height: 44px;
}

.profile-menu .el-menu-item:hover {
  background-color: #ecf5ff;
}

.profile-menu .el-menu-item.is-active {
  background-color: #409EFF;
  color: #fff;
}
</style>
