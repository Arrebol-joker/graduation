/*
 Navicat Premium Dump SQL

 Source Server         : graduation
 Source Server Type    : MySQL
 Source Server Version : 80408 (8.4.8)
 Source Host           : localhost:3306
 Source Schema         : ich

 Target Server Type    : MySQL
 Target Server Version : 80408 (8.4.8)
 File Encoding         : 65001

 Date: 28/04/2026 18:17:29
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for about
-- ----------------------------
DROP TABLE IF EXISTS `about`;
CREATE TABLE `about`  (
  `about_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '关于我们ID',
  `intro` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '介绍',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '宣传图片',
  `mission` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '我们的使命',
  `vision` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '我们的愿景',
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '我们的价值观',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '联系电话',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '办公地址',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '电子邮箱',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`about_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '关于我们表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of about
-- ----------------------------
INSERT INTO `about` VALUES ('A001', '非遗文化传承平台致力于保护和传承中国丰富的非物质文化遗产资源，推动非遗文化的传播和发展。', '/images/10014.webp', '我们的使命是传承和弘扬中华优秀传统文化，让非物质文化遗产在新时代焕发新的生机与活力。', '我们的愿景是成为全国领先的非遗文化保护平台，让更多人了解、认识和喜爱非物质文化遗产。', '我们的核心价值观是传承、创新、共享、发展。我们相信，只有传承才能延续文化根脉，只有创新才能适应时代发展，只有共享才能让文化惠及大众，只有发展才能让文化生生不息。', '010-12345678', '北京市东城区非遗文化保护中心', 'contact@heritage.com', 'admin', '2025-01-01 00:00:00', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for banner
-- ----------------------------
DROP TABLE IF EXISTS `banner`;
CREATE TABLE `banner`  (
  `banner_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '轮播图ID',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '标题',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '描述',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '图片',
  `sort` bigint NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`banner_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '轮播图表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of banner
-- ----------------------------
INSERT INTO `banner` VALUES ('B001', '非遗文化展演活动', '4月15日市文化中心广场，精彩不容错过！', '/images/10002.jpg', 1, 'admin', '2025-03-20 00:00:00', NULL, NULL, NULL);
INSERT INTO `banner` VALUES ('B002', '传统技艺传承人见面会', '5月20日市图书馆，与传承人面对面交流', '/images/10008.jpg', 2, 'admin', '2025-03-20 00:00:00', NULL, NULL, NULL);
INSERT INTO `banner` VALUES ('B003', '非遗文化进社区', '走进社区，让非遗文化融入生活', '/images/10009.jpg', 3, 'admin', '2025-03-20 00:00:00', NULL, NULL, NULL);
INSERT INTO `banner` VALUES ('B004', '青少年非遗体验营', '暑假特别活动，体验传统文化魅力', '/images/10005.jpg', 4, 'admin', '2025-03-20 00:00:00', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for contact
-- ----------------------------
DROP TABLE IF EXISTS `contact`;
CREATE TABLE `contact`  (
  `contact_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '留言反馈ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '姓名',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '邮箱',
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '留言内容',
  `user_id` bigint NULL DEFAULT NULL COMMENT '留言人用户ID',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`contact_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '留言反馈表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of contact
-- ----------------------------
INSERT INTO `contact` VALUES ('C001', '张三', 'zhangsan@example.com', '请问蜀锦织造技艺的传承人培训班什么时候开始报名？', 1, '2025-03-20 10:30:00', 'admin', NULL, NULL, NULL);
INSERT INTO `contact` VALUES ('C002', '李四', 'lisi@example.com', '我想了解皮影戏表演的预约方式，请问有什么要求？', 1, '2025-03-20 14:20:00', 'admin', NULL, NULL, NULL);
INSERT INTO `contact` VALUES ('C003', '王五', 'wangwu@example.com', '建议增加更多关于传统技艺的展示活动，让更多人了解非遗文化。', 1, '2025-03-21 09:15:00', 'admin', NULL, NULL, NULL);
INSERT INTO `contact` VALUES ('C004', '赵六', 'zhaoliu@example.com', '我想申请成为非遗传承人，请问需要满足什么条件？', 1, '2025-03-21 16:45:00', 'admin', NULL, NULL, NULL);
INSERT INTO `contact` VALUES ('C005', '钱七', 'qianqi@example.com', '非遗文化展馆的开放时间是什么时候？门票价格是多少？', 1, '2025-03-22 11:00:00', 'admin', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for event
-- ----------------------------
DROP TABLE IF EXISTS `event`;
CREATE TABLE `event`  (
  `event_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '活动预告ID',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '活动名称',
  `date` datetime NULL DEFAULT NULL COMMENT '活动日期',
  `time` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '活动时间',
  `location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '活动地点',
  `organizer` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '主办单位',
  `contact` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '联系方式',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '活动详情',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`event_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '活动预告表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of event
-- ----------------------------
INSERT INTO `event` VALUES ('E001', '非遗文化展演活动', '2025-04-15 00:00:00', '09:00-17:00', '市文化中心广场', '市非遗保护中心', '021-12345678', '本次活动将展示蜀锦织造、皮影戏、剪纸等多项非物质文化遗产项目，传承人现场表演技艺，观众可以近距离体验传统手工艺的魅力。活动期间还将举办非遗文化讲座和互动体验环节。', '/images/news_festival_opening.jpg', 'admin', '2025-03-20 00:00:00', NULL, NULL, NULL);
INSERT INTO `event` VALUES ('E002', '传统技艺传承人见面会', '2025-05-20 00:00:00', '14:00-16:00', '市图书馆报告厅', '市文化局', '021-23456789', '本次活动邀请多位国家级非物质文化遗产传承人进行现场交流，分享传承经验和技艺心得。现场观众可以与传承人面对面交流，了解传统技艺的历史和发展。', '/images/heritage_pottery_workshop.jpg', 'admin', '2025-03-20 00:00:00', NULL, NULL, NULL);
INSERT INTO `event` VALUES ('E003', '非遗文化进社区活动', '2025-06-01 00:00:00', '10:00-12:00', '各社区活动中心', '市非遗保护中心', '021-34567890', '为了让更多市民了解和认识非物质文化遗产，我们将在各社区开展非遗文化展示活动。活动内容包括传统技艺展示、民俗表演、非遗知识问答等，欢迎广大市民积极参与。', '/images/news_community_event.jpg', 'admin', '2025-03-20 00:00:00', NULL, NULL, NULL);
INSERT INTO `event` VALUES ('E004', '青少年非遗体验营', '2025-07-10 00:00:00', '09:00-17:00', '市青少年宫', '市教育局、市非遗保护中心', '021-45678901', '本次体验营面向6-15岁青少年，通过非遗知识讲座、传统技艺体验、手工制作等活动，让青少年近距离感受传统文化的魅力。活动为期一天，提供午餐和材料包。', '/images/news_youth_engagement.jpg', 'admin', '2025-03-20 00:00:00', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '代码生成业务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table
-- ----------------------------

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '字典类型',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 57 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '代码生成业务表字段' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------

-- ----------------------------
-- Table structure for heritage
-- ----------------------------
DROP TABLE IF EXISTS `heritage`;
CREATE TABLE `heritage`  (
  `heritage_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '非遗项目ID',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '项目名称',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '项目简介',
  `detail_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '详细介绍',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '图片',
  `location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '所在地',
  `category` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '类别',
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '传承状态',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`heritage_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '非遗项目表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of heritage
-- ----------------------------
INSERT INTO `heritage` VALUES ('59c48f7c95bc44a18e67e41a35e788a7', '2132', '3121', '324141', '/profile/upload/2026/03/29/微信图片_2026-03-29_184609_372_20260329200220A003.jpg', '未知', '传统技艺', '传承中', '2026-03-29 20:02:32', '', '', NULL, NULL);
INSERT INTO `heritage` VALUES ('H001', '蜀锦织造技艺', '蜀锦是中国四大名锦之一，有着两千多年的历史。', '蜀锦织造技艺以蚕丝为原料，经过染丝、并丝、捻丝、整经、织造等多道工序完成。其特点是图案精美、色彩艳丽、质地柔软。2006年被列入第一批国家级非物质文化遗产名录。', '/images/10009.jpg', '四川省成都市', '传统技艺', '国家级', '2025-01-01 00:00:00', 'admin', NULL, NULL, NULL);
INSERT INTO `heritage` VALUES ('H002', '皮影戏', '皮影戏是中国民间古老的传统艺术，有着悠久的历史。', '皮影戏是一种以兽皮或纸板做成的人物剪影以表演故事的民间戏剧。2011年被列入联合国教科文组织\"人类非物质文化遗产代表作名录\"。', '/images/10005.jpg', '全国范围', '传统戏剧', '世界级', '2025-01-01 00:00:00', 'admin', NULL, NULL, NULL);
INSERT INTO `heritage` VALUES ('H003', '中国书法', '书法是中国特有的传统艺术，历史悠久，源远流长。', '书法是中国传统文化的重要组成部分，包括楷书、行书、草书、隶书、篆书等五种字体。2009年被列入联合国教科文组织\"人类非物质文化遗产代表作名录\"。', '/images/10001.jpg', '全国范围', '传统美术', '世界级', '2025-01-01 00:00:00', 'admin', NULL, NULL, NULL);
INSERT INTO `heritage` VALUES ('H004', '剪纸艺术', '剪纸是一种用剪刀或刻刀在纸上剪刻花纹，用于装点生活或配合其他民俗活动的民间艺术。', '中国剪纸在2009年被列入联合国教科文组织\"人类非物质文化遗产代表作名录\"。剪纸艺术具有广泛的群众基础，是中国民间艺术的重要组成部分。', '/images/10002.jpg', '全国范围', '传统美术', '世界级', '2025-01-01 00:00:00', 'admin', NULL, NULL, NULL);
INSERT INTO `heritage` VALUES ('H005', '京剧', '京剧是中国五大戏曲剧种之一，被誉为中国国粹。', '京剧集唱、念、做、打于一体的综合性艺术。2010年被列入联合国教科文组织\"人类非物质文化遗产代表作名录\"。', '/images/10013.webp', '北京市', '传统戏剧', '世界级', '2025-01-01 00:00:00', 'admin', NULL, NULL, NULL);
INSERT INTO `heritage` VALUES ('H006', '端午节', '端午节是中国重要的传统节日之一。', '端午节起源于中国古代，有着悠久的历史和丰富的文化内涵。2009年被列入联合国教科文组织\"人类非物质文化遗产代表作名录\"。', '/images/10014.webp', '全国范围', '民俗活动', '世界级', '2025-01-01 00:00:00', 'admin', NULL, NULL, NULL);
INSERT INTO `heritage` VALUES ('P001', '蜀锦织造技艺申报', '蜀锦是中国四大名锦之一，起源于战国时期，有两千多年的历史。', '蜀锦织造技艺以蚕丝为原料，经过染丝、并丝、捻丝、整经、织造等多道工序完成。其特点是图案精美、色彩艳丽、质地柔软。', '/images/10001.jpg', '未知', '传统技艺', '传承中', '2025-01-15 00:00:00', 'admin', '', NULL, NULL);
INSERT INTO `heritage` VALUES ('P002', '皮影戏表演艺术', '皮影戏是中国民间古老的传统艺术，老北京人都叫它\"驴皮影\"。', '皮影戏是一种以兽皮或纸板做成的人物剪影以表演故事的民间戏剧。表演时，艺人们在白色幕布后面，一边操纵影人，一边用当地流行的曲调讲述故事。', '/images/10002.jpg', '未知', '民俗活动', '传承中', '2025-02-10 00:00:00', 'admin', '', NULL, NULL);
INSERT INTO `heritage` VALUES ('P003', '中国书法艺术', '书法是中国特有的传统艺术，历史悠久，源远流长。', '书法是中国传统文化的重要组成部分，包括楷书、行书、草书、隶书、篆书等五种字体。书法艺术讲究笔法、结构、章法和墨法，是中国文人墨客必备的修养。', '/images/10003.jpg', '未知', '传统美术', '传承中', '2025-03-05 00:00:00', 'admin', '', NULL, NULL);

-- ----------------------------
-- Table structure for master
-- ----------------------------
DROP TABLE IF EXISTS `master`;
CREATE TABLE `master`  (
  `master_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '传承人ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '姓名',
  `skills` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '技艺专长',
  `location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '位置',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '照片',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`master_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '传承人表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of master
-- ----------------------------
INSERT INTO `master` VALUES ('M001', '张华', '蜀锦织造技艺、图案设计', '四川省成都市', '/images/10009.jpg', 'admin', '2025-01-01 00:00:00', NULL, NULL, '蜀锦织造技艺国家级传承人');
INSERT INTO `master` VALUES ('M002', '李明', '皮影戏表演、皮影制作', '陕西省西安市', '/images/10005.jpg', 'admin', '2025-01-01 00:00:00', NULL, NULL, '皮影戏国家级传承人');
INSERT INTO `master` VALUES ('M003', '王芳', '楷书、行书、草书', '江苏省苏州市', '/images/10001.jpg', 'admin', '2025-01-01 00:00:00', NULL, NULL, '书法艺术省级传承人');
INSERT INTO `master` VALUES ('M004', '赵强', '剪纸艺术、民俗表演', '河北省张家口市', '/images/10002.jpg', 'admin', '2025-01-01 00:00:00', NULL, NULL, '剪纸艺术市级传承人');
INSERT INTO `master` VALUES ('M005', '陈秀英', '国家级非物质文化遗产传承人，从事蜀锦织造20年，多次获得国家级奖项。', '江苏省苏州市', '/images/10006.jpg', 'admin', '2026-03-29 18:58:48', '', NULL, NULL);
INSERT INTO `master` VALUES ('M006', '刘德明', '国家级非物质文化遗产传承人，从事陶瓷制作35年，作品被多家博物馆收藏。', '江西省景德镇市', '/images/10007.jpg', 'admin', '2026-03-29 18:58:48', '', NULL, NULL);
INSERT INTO `master` VALUES ('M007', '王建国', '国家级非物质文化遗产传承人，从事东阳木雕40年，作品多次在国际展览中获奖。', '浙江省东阳市', '/images/10010.jpg', 'admin', '2026-03-29 18:58:49', '', NULL, NULL);
INSERT INTO `master` VALUES ('M008', '李玉兰', '国家级非物质文化遗产传承人，从事刺绣艺术50年，培养了100多名徒弟。', '北京市', '/images/10011.jpg', 'admin', '2026-03-29 18:58:49', '', NULL, NULL);
INSERT INTO `master` VALUES ('M009', '张明德', '国家级非物质文化遗产传承人，从事漆器制作30年，作品远销海外。', '山西省平遥县', '/images/10004.jpg', 'admin', '2026-03-29 18:58:49', '', NULL, NULL);

-- ----------------------------
-- Table structure for master_contribution
-- ----------------------------
DROP TABLE IF EXISTS `master_contribution`;
CREATE TABLE `master_contribution`  (
  `contribution_id` bigint NOT NULL AUTO_INCREMENT COMMENT '传承贡献ID',
  `master_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '传承人ID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '贡献内容',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`contribution_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '传承贡献表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of master_contribution
-- ----------------------------
INSERT INTO `master_contribution` VALUES (1, 'M001', '从事蜀锦织造技艺30年，培养徒弟20余人，传承技艺得到有效保护。', 'admin', '2025-01-01 00:00:00', NULL, NULL, NULL);
INSERT INTO `master_contribution` VALUES (2, 'M001', '创新蜀锦图案设计，将传统与现代元素相结合，开发新产品。', 'admin', '2025-01-01 00:00:00', NULL, NULL, NULL);
INSERT INTO `master_contribution` VALUES (3, 'M002', '皮影戏表演艺术得到国内外观众认可，多次赴海外演出。', 'admin', '2025-01-01 00:00:00', NULL, NULL, NULL);
INSERT INTO `master_contribution` VALUES (4, 'M002', '编写皮影戏教材，为培养新一代传承人做出贡献。', 'admin', '2025-01-01 00:00:00', NULL, NULL, NULL);
INSERT INTO `master_contribution` VALUES (5, 'M003', '书法作品多次在全国书法比赛中获奖，艺术成就斐然。', 'admin', '2025-01-01 00:00:00', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news`  (
  `news_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '新闻资讯ID',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '标题',
  `summary` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '摘要',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '内容',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '封面',
  `author` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '发布单位',
  `category` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '类型',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `is_focus` tinyint(1) NULL DEFAULT 0 COMMENT '是否焦点',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`news_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '新闻资讯表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO `news` VALUES ('N001', '非物质文化遗产保护工作取得新进展', '近年来，我国非物质文化遗产保护工作取得了显著成效，一大批濒临失传的传统技艺得到了有效保护和传承。', '为加强非物质文化遗产保护工作，各级政府出台了一系列政策措施，建立了非物质文化遗产名录体系，设立了专项资金支持传承人开展传习活动。截至2025年，我国共有国家级非物质文化遗产代表性项目1557项，代表性传承人3068名。', '/images/10014.webp', '文化部', '政策法规', '2025-01-20 00:00:00', 1, 'admin', NULL, NULL, NULL);
INSERT INTO `news` VALUES ('N002', '传统技艺进校园活动圆满举行', '为弘扬中华优秀传统文化，让青少年近距离感受非物质文化遗产的魅力，某市举办了传统技艺进校园活动。', '活动现场，多位非物质文化遗产传承人展示了蜀锦织造、皮影戏、剪纸等传统技艺，并与学生们进行了互动交流。学生们亲手体验了传统手工艺的制作过程，感受到了传统文化的独特魅力。此次活动共有500多名学生参与，取得了良好的教育效果。', '/images/10002.jpg', '市教育局', '活动报道', '2025-02-15 00:00:00', 0, 'admin', NULL, NULL, NULL);
INSERT INTO `news` VALUES ('N003', '非物质文化遗产传承人培训班开班', '为提升非物质文化遗产传承人的专业素养和传承能力，某省举办了非物质文化遗产传承人培训班。', '本次培训邀请了知名专家学者授课，内容涵盖非遗保护政策、传承技艺、市场营销等方面。共有来自全省各地的50余名传承人参加了培训。通过培训，传承人不仅提高了技艺水平，还开阔了视野，增强了传承信心。', '/images/10008.jpg', '省文化和旅游厅', '培训通知', '2025-03-10 00:00:00', 0, 'admin', NULL, NULL, NULL);
INSERT INTO `news` VALUES ('N004', '非遗文化展馆正式对外开放', '经过两年筹备，某市非物质文化遗产展馆正式对外开放，向社会公众展示该市丰富的非物质文化遗产资源。', '展馆占地面积3000平方米，分为传统技艺、民俗活动、传统美术、传统音乐等多个展区。展馆通过实物展示、图文介绍、多媒体演示等方式，全面展示了该市的非物质文化遗产保护成果。开馆首日，共接待参观群众2000余人次。', '/images/10009.jpg', '市非遗保护中心', '场馆信息', '2025-03-25 00:00:00', 0, 'admin', NULL, NULL, NULL);
INSERT INTO `news` VALUES ('N005', '国际非遗文化交流活动盛大举行', '为促进各国非物质文化遗产的交流互鉴，某市成功举办了国际非遗文化交流活动，来自20多个国家和地区的代表参加了此次活动。', '本次活动展示了包括中国蜀锦、印度刺绣、日本和服制作、韩国陶艺等在内的各国传统技艺。活动期间还举办了非遗保护论坛、技艺展示、文化体验等活动，为各国传承人提供了交流学习的平台。此次活动的成功举办，进一步推动了非遗文化的国际传播与合作。', '/images/10014.webp', '市文旅局', '国际交流', '2025-03-28 00:00:00', 1, 'admin', '', NULL, NULL);
INSERT INTO `news` VALUES ('N006', '全国非遗文化节盛大开幕', '为期一周的全国非物质文化遗产文化节在文化中心盛大开幕，来自全国各地的非遗传承人和爱好者齐聚一堂，共同见证这一文化盛事。', '文化节开幕式上，传统技艺表演精彩纷呈，包括京剧、皮影戏、古琴演奏等。活动现场设置了数百个展位，展示包括蜀锦、陶瓷、刺绣、木雕等在内的数百项非遗项目。此外，还举办了非遗传承人见面会、技艺体验、学术研讨等活动。预计活动期间将吸引超过10万人次参观。', '/images/10013.webp', '文化部', '活动报道', '2025-03-29 00:00:00', 1, 'admin', '', NULL, NULL);
INSERT INTO `news` VALUES ('N007', '传统灯彩技艺传承活动举办', '近日，某地举办了国家级非物质文化遗产——灯彩技艺传承展示活动，多位传承人现场展示了精美的灯彩制作工艺。', '活动现场展示了包括公鸡灯、麒麟灯、仙鹤灯等在内的多件精美灯彩作品。传承人现场演示了纸扎、剪纸、绘画等传统工艺，吸引了众多市民和游客驻足观看。此次活动旨在让更多人了解和喜爱传统灯彩文化，推动非遗技艺的传承和发展。', '/images/10014.webp', '市非遗保护中心', '活动报道', '2026-03-29 19:22:02', 1, 'admin', '', NULL, NULL);

-- ----------------------------
-- Table structure for project
-- ----------------------------
DROP TABLE IF EXISTS `project`;
CREATE TABLE `project`  (
  `project_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '项目申报ID',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '项目名称',
  `category_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '项目申报类别ID',
  `introduction` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '项目简介',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '详细描述',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `inheritance` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '传承谱系',
  `inheritors` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '传承人信息',
  `contact` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '联系方式',
  `image_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '项目图片',
  `status` tinyint NULL DEFAULT 0 COMMENT '审核状态：0-待审核，1-已通过，2-已拒绝',
  `user_id` bigint NULL DEFAULT NULL COMMENT '申报人用户ID',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`project_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '项目申报表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of project
-- ----------------------------
INSERT INTO `project` VALUES ('59c48f7c95bc44a18e67e41a35e788a7', '2132', '1', '3121', '324141', NULL, '32113', '321321', '32121', '/profile/upload/2026/03/29/微信图片_2026-03-29_184609_372_20260329200220A003.jpg', 1, 2, '2026-03-29 20:02:32', '', '', NULL, NULL);
INSERT INTO `project` VALUES ('P001', '蜀锦织造技艺申报', '1', '蜀锦是中国四大名锦之一，起源于战国时期，有两千多年的历史。', '蜀锦织造技艺以蚕丝为原料，经过染丝、并丝、捻丝、整经、织造等多道工序完成。其特点是图案精美、色彩艳丽、质地柔软。', '/images/heritage_embroidery_detail.jpg', '起源于四川成都，最早可追溯到战国时期，经过历代发展形成了独特的技艺体系。', '张三、李四、王五等传承人', '13800138000', NULL, 1, 1, '2025-01-15 00:00:00', 'admin', NULL, NULL, NULL);
INSERT INTO `project` VALUES ('P002', '皮影戏表演艺术', '2', '皮影戏是中国民间古老的传统艺术，老北京人都叫它\"驴皮影\"。', '皮影戏是一种以兽皮或纸板做成的人物剪影以表演故事的民间戏剧。表演时，艺人们在白色幕布后面，一边操纵影人，一边用当地流行的曲调讲述故事。', '/images/heritage_puppetry.jpg', '起源于西汉时期，已有两千多年历史，流行于中国各地。', '赵六、钱七等传承人', '13900139000', NULL, 1, 1, '2025-02-10 00:00:00', 'admin', NULL, NULL, NULL);
INSERT INTO `project` VALUES ('P003', '中国书法艺术', '3', '书法是中国特有的传统艺术，历史悠久，源远流长。', '书法是中国传统文化的重要组成部分，包括楷书、行书、草书、隶书、篆书等五种字体。书法艺术讲究笔法、结构、章法和墨法，是中国文人墨客必备的修养。', '/images/heritage_calligraphy.jpg', '起源于商周时期，经过历代发展形成了独特的艺术体系。', '孙八、周九等传承人', '13700137000', NULL, 1, 1, '2025-03-05 00:00:00', 'admin', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for project_category
-- ----------------------------
DROP TABLE IF EXISTS `project_category`;
CREATE TABLE `project_category`  (
  `pc_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '类别ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '类别名称',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`pc_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '项目申报类别表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of project_category
-- ----------------------------
INSERT INTO `project_category` VALUES ('1', '传统技艺', 'admin', '2025-01-01 00:00:00', NULL, NULL, '传统手工技艺类项目');
INSERT INTO `project_category` VALUES ('2', '民俗活动', 'admin', '2025-01-01 00:00:00', NULL, NULL, '传统民俗节庆活动');
INSERT INTO `project_category` VALUES ('3', '传统美术', 'admin', '2025-01-01 00:00:00', NULL, NULL, '传统美术绘画类项目');
INSERT INTO `project_category` VALUES ('4', '传统音乐', 'admin', '2025-01-01 00:00:00', NULL, NULL, '传统音乐表演类项目');

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 99 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2025-08-30 08:59:54', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-08-30 08:59:54', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-08-30 08:59:54', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2025-08-30 08:59:54', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2025-08-30 08:59:54', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2025-08-30 08:59:54', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2025-08-30 08:59:54', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2025-08-30 08:59:54', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (9, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2025-08-30 08:59:54', '', NULL, '系统默认否');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 99 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '字典类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2025-08-30 08:59:54', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2025-08-30 08:59:54', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2025-08-30 08:59:54', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '系统是否', 'sys_yes_no', '0', 'admin', '2025-08-30 08:59:54', '', NULL, '系统是否列表');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '路由名称',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 1 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2017 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '菜单权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', '系统管理', 'admin', '2025-08-30 08:59:54', 'admin', '2025-09-11 13:30:12', '系统管理目录');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 1, 'C', '0', '0', 'system:user:list', '用户管理', 'admin', '2025-08-30 08:59:54', 'admin', '2025-09-01 11:20:55', '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 1, 'C', '0', '0', 'system:role:list', '角色管理', 'admin', '2025-08-30 08:59:54', 'admin', '2025-09-01 11:26:22', '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 1, 'C', '0', '0', 'system:menu:list', '菜单管理', 'admin', '2025-08-30 08:59:54', 'admin', '2025-09-01 11:26:28', '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 1, 'C', '0', '0', 'system:dict:list', '字典管理', 'admin', '2025-08-30 08:59:54', 'admin', '2025-09-01 11:26:38', '字典管理菜单');
INSERT INTO `sys_menu` VALUES (116, '代码生成', 1, 8, 'gen', 'tool/gen/index', '', '', 1, 1, 'C', '0', '0', 'tool:gen:list', '代码生成', 'admin', '2025-08-30 08:59:54', 'admin', '2025-09-01 11:26:49', '代码生成菜单');
INSERT INTO `sys_menu` VALUES (2000, '非遗管理', 0, 2, 'ich', NULL, NULL, NULL, 1, 0, 'M', '0', '0', NULL, '非遗管理', 'admin', '2026-03-29 20:57:57', '', NULL, '??????');
INSERT INTO `sys_menu` VALUES (2001, '项目申报', 2000, 1, 'project', 'ich/project/index', NULL, NULL, 1, 0, 'C', '0', '0', 'ich:project:list', '项目申报', 'admin', '2026-03-29 20:57:57', '', NULL, '??????');
INSERT INTO `sys_menu` VALUES (2002, '项目申报查询', 2001, 1, '#', '', NULL, NULL, 1, 0, 'F', '0', '0', 'ich:project:query', '#', 'admin', '2026-03-29 20:11:45', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2003, '项目申报新增', 2001, 2, '#', '', NULL, NULL, 1, 0, 'F', '0', '0', 'ich:project:add', '#', 'admin', '2026-03-29 20:11:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2004, '项目申报修改', 2001, 3, '#', '', NULL, NULL, 1, 0, 'F', '0', '0', 'ich:project:edit', '#', 'admin', '2026-03-29 20:12:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2005, '项目申报删除', 2001, 4, '#', '', NULL, NULL, 1, 0, 'F', '0', '0', 'ich:project:remove', '#', 'admin', '2026-03-29 20:12:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2006, '项目申报审核', 2001, 5, '#', '', NULL, NULL, 1, 0, 'F', '0', '0', 'ich:project:approve', '#', 'admin', '2026-03-29 20:12:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2007, '项目申报导出', 2001, 6, '#', '', NULL, NULL, 1, 0, 'F', '0', '0', 'ich:project:export', '#', 'admin', '2026-03-29 20:12:26', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2010, '非遗项目管理', 2000, 2, 'heritage', 'ich/heritage/index', NULL, NULL, 1, 0, 'C', '0', '0', 'ich:heritage:list', '非遗项目管理', 'admin', '2026-03-29 20:58:36', '', NULL, '????????');
INSERT INTO `sys_menu` VALUES (2011, '非遗项目查询', 2010, 1, '#', NULL, NULL, '', 1, 1, 'F', '0', '0', 'ich:heritage:query', '#', 'admin', '2026-03-29 20:40:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2012, '非遗项目新增', 2010, 2, '#', NULL, NULL, '', 1, 1, 'F', '0', '0', 'ich:heritage:add', '#', 'admin', '2026-03-29 20:40:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2013, '非遗项目修改', 2010, 3, '#', NULL, NULL, '', 1, 1, 'F', '0', '0', 'ich:heritage:edit', '#', 'admin', '2026-03-29 20:40:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2014, '非遗项目删除', 2010, 4, '#', NULL, NULL, '', 1, 1, 'F', '0', '0', 'ich:heritage:remove', '#', 'admin', '2026-03-29 20:40:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2015, '非遗项目导出', 2010, 5, '#', NULL, NULL, '', 1, 1, 'F', '0', '0', 'ich:heritage:export', '#', 'admin', '2026-03-29 20:40:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2016, '非遗项目导入', 2010, 6, '#', NULL, NULL, '', 1, 1, 'F', '0', '0', 'ich:heritage:import', '#', 'admin', '2026-03-29 20:40:02', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 99 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '角色信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2025-08-30 08:59:54', '', NULL, '超级管理员');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '角色和菜单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (1, 2002);
INSERT INTO `sys_role_menu` VALUES (1, 2003);
INSERT INTO `sys_role_menu` VALUES (1, 2004);
INSERT INTO `sys_role_menu` VALUES (1, 2005);
INSERT INTO `sys_role_menu` VALUES (1, 2006);
INSERT INTO `sys_role_menu` VALUES (1, 2007);
INSERT INTO `sys_role_menu` VALUES (1, 2010);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 100, 'admin', '系统管理员', '00', 'huacai@163.com', '15888888888', '1', '/profile/avatar/2026/03/29/微信图片_2026-03-29_184609_372_20260329195340A001.jpg', 'admin123', '0', '0', '127.0.0.1', '2026-04-28 18:06:20', 'admin', '2025-08-30 08:59:53', '', '2026-04-28 18:06:20', '管理员');
INSERT INTO `sys_user` VALUES (2, NULL, 'zhangsan', '张三', '00', 'zhangsan@example.com', '13800138001', '0', '/profile/avatar/2026/03/29/微信图片_2026-03-29_184609_372_20260329184717A001.jpg', 'user123', '0', '0', '127.0.0.1', '2026-04-28 18:06:11', 'admin', '2025-03-20 00:00:00', NULL, '2026-04-28 18:06:10', '普通用户');
INSERT INTO `sys_user` VALUES (3, NULL, 'lisi', '李四', '00', 'lisi@example.com', '13800138002', '1', '', 'user123', '0', '0', '', NULL, 'admin', '2025-03-20 00:00:00', NULL, NULL, '普通用户');
INSERT INTO `sys_user` VALUES (4, NULL, 'wangwu', '王五', '00', 'wangwu@example.com', '13800138003', '0', '', 'user123', '0', '0', '', NULL, 'admin', '2025-03-20 00:00:00', NULL, NULL, '普通用户');
INSERT INTO `sys_user` VALUES (5, NULL, 'zhaoliu', '赵六', '00', 'zhaoliu@example.com', '13800138004', '0', '', 'user123', '0', '0', '', NULL, 'admin', '2025-03-20 00:00:00', NULL, NULL, '普通用户');
INSERT INTO `sys_user` VALUES (6, NULL, 'qianqi', '钱七', '00', 'qianqi@example.com', '13800138005', '1', '', 'user123', '0', '0', '', NULL, 'admin', '2025-03-20 00:00:00', NULL, NULL, '普通用户');
INSERT INTO `sys_user` VALUES (7, NULL, 'sunba', '孙八', '00', 'sunba@example.com', '13800138006', '0', '', 'user123', '0', '0', '', NULL, 'admin', '2025-03-20 00:00:00', NULL, NULL, '普通用户');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '用户和角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 1);
INSERT INTO `sys_user_role` VALUES (3, 1);
INSERT INTO `sys_user_role` VALUES (4, 1);
INSERT INTO `sys_user_role` VALUES (5, 1);
INSERT INTO `sys_user_role` VALUES (6, 1);
INSERT INTO `sys_user_role` VALUES (7, 1);

SET FOREIGN_KEY_CHECKS = 1;
