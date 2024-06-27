/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50740
Source Host           : localhost:3306
Source Database       : webman_project

Target Server Type    : MYSQL
Target Server Version : 50740
File Encoding         : 65001

Date: 2024-06-27 11:43:59
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `wp_article`
-- ----------------------------
DROP TABLE IF EXISTS `wp_article`;
CREATE TABLE `wp_article` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL COMMENT '分类id',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '文章标题',
  `author` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '文章作者',
  `image` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '文章图片',
  `describe` varchar(1000) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文章简介',
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文章内容',
  `views` int(11) DEFAULT '0' COMMENT '浏览次数',
  `sort` int(11) DEFAULT '100' COMMENT '排序',
  `status` int(11) DEFAULT '1' COMMENT '状态',
  `is_link` int(11) DEFAULT '2' COMMENT '是否外链',
  `link_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '链接地址',
  `is_hot` int(11) DEFAULT '2' COMMENT '是否热门',
  `created_by` int(11) DEFAULT NULL COMMENT '创建者',
  `updated_by` int(11) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  KEY `idx_category_id` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='文章表';

-- ----------------------------
-- Records of wp_article
-- ----------------------------

-- ----------------------------
-- Table structure for `wp_article_category`
-- ----------------------------
DROP TABLE IF EXISTS `wp_article_category`;
CREATE TABLE `wp_article_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT '父级id',
  `category_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '分类标题',
  `describe` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '分类简介',
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '分类图片',
  `sort` int(11) DEFAULT '100' COMMENT '排序',
  `status` int(11) DEFAULT '1' COMMENT '状态',
  `created_by` int(11) DEFAULT NULL COMMENT '创建者',
  `updated_by` int(11) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  KEY `idx_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='文章分类表';

-- ----------------------------
-- Records of wp_article_category
-- ----------------------------

-- ----------------------------
-- Table structure for `wp_system_config`
-- ----------------------------
DROP TABLE IF EXISTS `wp_system_config`;
CREATE TABLE `wp_system_config` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` int(11) DEFAULT NULL COMMENT '组id',
  `key` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '配置键名',
  `value` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '配置值',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '配置名称',
  `input_type` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '数据输入类型',
  `config_select_data` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '配置选项数据',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `idx_group_id` (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='参数配置信息表';

-- ----------------------------
-- Records of wp_system_config
-- ----------------------------
INSERT INTO `wp_system_config` VALUES ('1', '1', 'site_copyright', 'Copyright © 2024 saithink', '版权信息', 'textarea', null, '96', '');
INSERT INTO `wp_system_config` VALUES ('2', '1', 'site_desc', '基于vue3 + webman 的极速开发框架', '网站描述', 'textarea', null, '97', null);
INSERT INTO `wp_system_config` VALUES ('3', '1', 'site_keywords', '后台管理系统', '网站关键字', 'input', null, '98', null);
INSERT INTO `wp_system_config` VALUES ('4', '1', 'site_name', 'SaiAdmin', '网站名称', 'input', null, '99', null);
INSERT INTO `wp_system_config` VALUES ('5', '1', 'site_record_number', '', '网站备案号', 'input', null, '95', null);
INSERT INTO `wp_system_config` VALUES ('6', '2', 'upload_allow_file', 'txt,doc,docx,xls,xlsx,ppt,pptx,rar,zip,7z,gz,pdf,wps,md', '文件类型', 'input', null, '0', null);
INSERT INTO `wp_system_config` VALUES ('7', '2', 'upload_allow_image', 'jpg,jpeg,png,gif,svg,bmp', '图片类型', 'input', null, '0', null);
INSERT INTO `wp_system_config` VALUES ('8', '2', 'upload_mode', '4', '上传模式', 'select', '[{\"label\":\"本地上传\",\"value\":\"1\"},{\"label\":\"阿里云OSS\",\"value\":\"2\"},{\"label\":\"七牛云\",\"value\":\"3\"},{\"label\":\"腾讯云COS\",\"value\":\"4\"}]', '99', null);
INSERT INTO `wp_system_config` VALUES ('10', '2', 'upload_size', '5242880', '上传大小', 'input', null, '88', '单位Byte,1MB=1024*1024Byte');
INSERT INTO `wp_system_config` VALUES ('11', '2', 'local_root', 'public/storage/', '本地存储路径', 'input', null, '0', '本地存储文件路径');
INSERT INTO `wp_system_config` VALUES ('12', '2', 'local_domain', 'http://webman.soft', '本地存储域名', 'input', null, '0', 'http://127.0.0.1:8787');
INSERT INTO `wp_system_config` VALUES ('13', '2', 'local_uri', '/storage/', '本地访问路径', 'input', null, '0', '访问是通过domain + uri');
INSERT INTO `wp_system_config` VALUES ('14', '2', 'qiniu_accessKey', '', '七牛key', 'input', null, '0', '七牛云存储secretId');
INSERT INTO `wp_system_config` VALUES ('15', '2', 'qiniu_secretKey', '', '七牛secret', 'input', null, '0', '七牛云存储secretKey');
INSERT INTO `wp_system_config` VALUES ('16', '2', 'qiniu_bucket', '', '七牛bucket', 'input', null, '0', '七牛云存储bucket');
INSERT INTO `wp_system_config` VALUES ('17', '2', 'qiniu_dirname', '', '七牛dirname', 'input', null, '0', '七牛云存储dirname');
INSERT INTO `wp_system_config` VALUES ('18', '2', 'qiniu_domain', '', '七牛domain', 'input', null, '0', '七牛云存储domain');
INSERT INTO `wp_system_config` VALUES ('19', '2', 'cos_secretId', '', '腾讯Id', 'input', null, '0', '腾讯云存储secretId');
INSERT INTO `wp_system_config` VALUES ('20', '2', 'cos_secretKey', '', '腾讯key', 'input', null, '0', '腾讯云secretKey');
INSERT INTO `wp_system_config` VALUES ('21', '2', 'cos_bucket', '', '腾讯bucket', 'input', null, '0', '腾讯云存储bucket');
INSERT INTO `wp_system_config` VALUES ('22', '2', 'cos_dirname', '', '腾讯dirname', 'input', null, '0', '腾讯云存储dirname');
INSERT INTO `wp_system_config` VALUES ('23', '2', 'cos_domain', '', '腾讯domain', 'input', null, '0', '腾讯云存储domain');
INSERT INTO `wp_system_config` VALUES ('24', '2', 'cos_region', '', '腾讯region', 'input', null, '0', '腾讯云存储region');
INSERT INTO `wp_system_config` VALUES ('25', '2', 'oss_accessKeyId', '', '阿里Id', 'input', null, '0', '阿里云存储accessKeyId');
INSERT INTO `wp_system_config` VALUES ('26', '2', 'oss_accessKeySecret', '', '阿里Secret', 'input', null, '0', '阿里云存储accessKeySecret');
INSERT INTO `wp_system_config` VALUES ('27', '2', 'oss_bucket', '', '阿里bucket', 'input', null, '0', '阿里云存储bucket');
INSERT INTO `wp_system_config` VALUES ('28', '2', 'oss_dirname', '', '阿里dirname', 'input', null, '0', '阿里云存储dirname');
INSERT INTO `wp_system_config` VALUES ('29', '2', 'oss_domain', '', '阿里domain', 'input', null, '0', '阿里云存储domain');
INSERT INTO `wp_system_config` VALUES ('30', '2', 'oss_endpoint', '', '阿里endpoint', 'input', null, '0', '阿里云存储endpoint');

-- ----------------------------
-- Table structure for `wp_system_config_group`
-- ----------------------------
DROP TABLE IF EXISTS `wp_system_config_group`;
CREATE TABLE `wp_system_config_group` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '字典名称',
  `code` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '字典标示',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `created_by` int(11) DEFAULT NULL COMMENT '创建人',
  `updated_by` int(11) DEFAULT NULL COMMENT '更新人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='参数配置分组表';

-- ----------------------------
-- Records of wp_system_config_group
-- ----------------------------
INSERT INTO `wp_system_config_group` VALUES ('1', '站点配置', 'site_config', null, '1', '1', '2021-11-23 10:49:29', '2021-11-23 10:49:29', null);
INSERT INTO `wp_system_config_group` VALUES ('2', '上传配置', 'upload_config', null, '1', '1', '2021-11-23 10:49:29', '2021-11-23 10:49:29', null);

-- ----------------------------
-- Table structure for `wp_system_crontab`
-- ----------------------------
DROP TABLE IF EXISTS `wp_system_crontab`;
CREATE TABLE `wp_system_crontab` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '任务名称',
  `type` int(11) DEFAULT '1' COMMENT '任务类型',
  `target` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '调用任务字符串',
  `parameter` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '调用任务参数',
  `rule` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '任务执行表达式',
  `singleton` int(11) DEFAULT '1' COMMENT '是否单次执行 (1 是 2 不是)',
  `status` int(11) DEFAULT '1' COMMENT '状态 (1正常 2停用)',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `created_by` int(11) DEFAULT NULL COMMENT '创建者',
  `updated_by` int(11) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='定时任务信息表';

-- ----------------------------
-- Records of wp_system_crontab
-- ----------------------------
INSERT INTO `wp_system_crontab` VALUES ('1', '访问官网', '1', 'https://saithink.top', null, '0 0 8 * * *', '2', '1', null, '1', '1', '2024-01-20 14:21:11', '2024-01-20 15:26:41', null);
INSERT INTO `wp_system_crontab` VALUES ('2', '登录gitee', '2', 'https://gitee.com/check_user_login', '{\"user_login\": \"project\"}', '0 0 10 * * *', '2', '1', null, '1', '1', '2024-01-20 14:31:51', '2024-01-20 15:21:33', null);
INSERT INTO `wp_system_crontab` VALUES ('3', '定时执行任务', '3', '\\app\\common\\process\\Task', '{\"type\":\"1\"}', '0 0 12 * * *', '2', '1', null, '1', '1', '2024-01-20 14:38:03', '2024-01-20 15:21:42', null);

-- ----------------------------
-- Table structure for `wp_system_crontab_log`
-- ----------------------------
DROP TABLE IF EXISTS `wp_system_crontab_log`;
CREATE TABLE `wp_system_crontab_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `crontab_id` int(11) DEFAULT NULL COMMENT '任务ID',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '任务名称',
  `target` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '任务调用目标字符串',
  `parameter` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '任务调用参数',
  `exception_info` varchar(2000) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '异常信息',
  `status` int(11) DEFAULT '1' COMMENT '执行状态 (1成功 2失败)',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='定时任务执行日志表';

-- ----------------------------
-- Records of wp_system_crontab_log
-- ----------------------------

-- ----------------------------
-- Table structure for `wp_system_department`
-- ----------------------------
DROP TABLE IF EXISTS `wp_system_department`;
CREATE TABLE `wp_system_department` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL COMMENT '父ID',
  `level` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '组级集合',
  `name` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '部门名称',
  `leader` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '联系电话',
  `status` int(11) DEFAULT '1' COMMENT '状态 (1正常 2停用)',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `created_by` int(11) DEFAULT NULL COMMENT '创建者',
  `updated_by` int(11) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='部门信息表';

-- ----------------------------
-- Records of wp_system_department
-- ----------------------------
INSERT INTO `wp_system_department` VALUES ('1', '0', '0', '赛弟科技', '赛弟', '18888888888', '1', '1', null, '1', '1', '2023-10-24 12:00:00', '2023-10-24 12:00:00', null);
INSERT INTO `wp_system_department` VALUES ('2', '1', '0,1', '青岛分公司', null, null, '1', '1', null, '1', '1', '2023-10-24 12:00:00', '2023-10-24 12:00:00', null);
INSERT INTO `wp_system_department` VALUES ('3', '1', '0,1', '洛阳总公司', null, null, '1', '1', null, '1', '1', '2023-10-24 12:00:00', '2023-10-24 12:00:00', null);
INSERT INTO `wp_system_department` VALUES ('4', '2', '0,1,2', '市场部门', null, null, '1', '1', null, '1', '1', '2023-10-24 12:00:00', '2023-10-24 12:00:00', null);
INSERT INTO `wp_system_department` VALUES ('5', '2', '0,1,2', '财务部门', null, null, '1', '1', null, '1', '1', '2023-10-24 12:00:00', '2023-10-24 12:00:00', null);
INSERT INTO `wp_system_department` VALUES ('6', '3', '0,1,3', '研发部门', null, null, '1', '1', null, '1', '1', '2023-10-24 12:00:00', '2023-10-24 12:00:00', null);
INSERT INTO `wp_system_department` VALUES ('7', '3', '0,1,3', '市场部门', null, null, '1', '1', null, '1', '1', '2023-10-24 12:00:00', '2023-10-24 12:00:00', null);

-- ----------------------------
-- Table structure for `wp_system_department_leader`
-- ----------------------------
DROP TABLE IF EXISTS `wp_system_department_leader`;
CREATE TABLE `wp_system_department_leader` (
  `department_id` int(11) NOT NULL COMMENT '部门主键',
  `user_id` int(11) NOT NULL COMMENT '角色主键',
  PRIMARY KEY (`department_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='部门领导关联表';

-- ----------------------------
-- Records of wp_system_department_leader
-- ----------------------------

-- ----------------------------
-- Table structure for `wp_system_dict_data`
-- ----------------------------
DROP TABLE IF EXISTS `wp_system_dict_data`;
CREATE TABLE `wp_system_dict_data` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type_id` int(11) DEFAULT NULL COMMENT '字典类型ID',
  `label` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '字典标签',
  `value` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '字典值',
  `code` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '字典标示',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `status` int(11) DEFAULT '1' COMMENT '状态 (1正常 2停用)',
  `remark` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '备注',
  `created_by` int(11) DEFAULT NULL COMMENT '创建者',
  `updated_by` int(11) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  KEY `type_id` (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='字典数据表';

-- ----------------------------
-- Records of wp_system_dict_data
-- ----------------------------
INSERT INTO `wp_system_dict_data` VALUES ('1', '1', 'InnoDB', 'InnoDB', 'table_engine', '1', '1', null, '1', '1', '2021-06-27 00:37:11', '2023-12-06 21:54:25', null);
INSERT INTO `wp_system_dict_data` VALUES ('2', '1', 'MyISAM', 'MyISAM', 'table_engine', '1', '1', null, '1', '1', '2021-06-27 00:37:21', '2023-11-16 11:51:35', null);
INSERT INTO `wp_system_dict_data` VALUES ('3', '2', '本地存储', '1', 'upload_mode', '99', '1', null, '1', '1', '2021-06-27 13:33:43', '2021-06-27 13:33:43', null);
INSERT INTO `wp_system_dict_data` VALUES ('4', '2', '阿里云OSS', '2', 'upload_mode', '98', '1', null, '1', '1', '2021-06-27 13:33:55', '2021-06-27 13:33:55', null);
INSERT INTO `wp_system_dict_data` VALUES ('5', '2', '七牛云', '3', 'upload_mode', '97', '1', null, '1', '1', '2021-06-27 13:34:07', '2023-12-13 16:50:26', null);
INSERT INTO `wp_system_dict_data` VALUES ('6', '2', '腾讯云COS', '4', 'upload_mode', '96', '1', null, '1', '1', '2021-06-27 13:34:19', '2023-12-13 16:47:34', null);
INSERT INTO `wp_system_dict_data` VALUES ('7', '3', '正常', '1', 'data_status', '0', '1', '1为正常', '1', '1', '2021-06-27 13:36:51', '2021-06-27 13:37:01', null);
INSERT INTO `wp_system_dict_data` VALUES ('8', '3', '停用', '2', 'data_status', '0', '1', '2为停用', '1', '1', '2021-06-27 13:37:10', '2021-06-27 13:37:10', null);
INSERT INTO `wp_system_dict_data` VALUES ('9', '4', '统计页面', 'statistics', 'dashboard', '0', '1', '管理员用', '1', '1', '2021-08-09 12:53:53', '2023-11-16 11:39:17', null);
INSERT INTO `wp_system_dict_data` VALUES ('10', '4', '工作台', 'work', 'dashboard', '0', '1', '员工使用', '1', '1', '2021-08-09 12:54:18', '2021-08-09 12:54:18', null);
INSERT INTO `wp_system_dict_data` VALUES ('11', '5', '男', '1', 'sex', '0', '1', null, '1', '1', '2021-08-09 12:55:00', '2021-08-09 12:55:00', null);
INSERT INTO `wp_system_dict_data` VALUES ('12', '5', '女', '2', 'sex', '0', '1', null, '1', '1', '2021-08-09 12:55:08', '2021-08-09 12:55:08', null);
INSERT INTO `wp_system_dict_data` VALUES ('13', '5', '未知', '3', 'sex', '0', '1', null, '1', '1', '2021-08-09 12:55:16', '2021-08-09 12:55:16', null);
INSERT INTO `wp_system_dict_data` VALUES ('22', '7', '通知', '1', 'backend_notice_type', '2', '1', null, '1', '1', '2021-11-11 17:29:27', '2021-11-11 17:30:51', null);
INSERT INTO `wp_system_dict_data` VALUES ('23', '7', '公告', '2', 'backend_notice_type', '1', '1', null, '1', '1', '2021-11-11 17:31:42', '2021-11-11 17:31:42', null);
INSERT INTO `wp_system_dict_data` VALUES ('24', '8', '所有', 'A', 'request_mode', '5', '1', null, '1', '1', '2021-11-14 17:23:25', '2023-12-13 17:21:28', null);
INSERT INTO `wp_system_dict_data` VALUES ('25', '8', 'GET', 'G', 'request_mode', '4', '1', null, '1', '1', '2021-11-14 17:23:45', '2023-12-13 17:21:28', null);
INSERT INTO `wp_system_dict_data` VALUES ('26', '8', 'POST', 'P', 'request_mode', '3', '1', null, '1', '1', '2021-11-14 17:23:38', '2023-12-13 17:21:28', null);
INSERT INTO `wp_system_dict_data` VALUES ('27', '8', 'PUT', 'U', 'request_mode', '2', '1', null, '1', '1', '2021-11-14 17:23:45', '2023-12-13 17:21:28', null);
INSERT INTO `wp_system_dict_data` VALUES ('28', '8', 'DELETE', 'D', 'request_mode', '1', '1', null, '1', '1', '2021-11-14 17:23:45', '2023-12-13 17:21:28', null);
INSERT INTO `wp_system_dict_data` VALUES ('39', '6', '通知', 'notice', 'queue_msg_type', '1', '1', null, '1', '1', '2021-12-25 18:30:31', '2024-01-20 14:42:55', null);
INSERT INTO `wp_system_dict_data` VALUES ('40', '6', '公告', 'announcement', 'queue_msg_type', '2', '1', null, '1', '1', '2021-12-25 18:31:00', '2024-01-20 14:42:57', null);
INSERT INTO `wp_system_dict_data` VALUES ('41', '6', '待办', 'todo', 'queue_msg_type', '3', '1', null, '1', '1', '2021-12-25 18:31:26', '2024-01-20 14:42:59', null);
INSERT INTO `wp_system_dict_data` VALUES ('42', '6', '抄送我的', 'carbon_copy_mine', 'queue_msg_type', '4', '1', null, '1', '1', '2021-12-25 18:31:26', '2024-01-20 14:42:59', null);
INSERT INTO `wp_system_dict_data` VALUES ('43', '6', '私信', 'private_message', 'queue_msg_type', '5', '1', null, '1', '1', '2021-12-25 18:31:26', '2024-01-20 14:42:59', null);
INSERT INTO `wp_system_dict_data` VALUES ('44', '12', '图片', 'image', 'attachment_type', '10', '1', null, '1', '1', '2022-03-17 14:49:59', '2022-03-17 14:49:59', null);
INSERT INTO `wp_system_dict_data` VALUES ('45', '12', '文档', 'text', 'attachment_type', '9', '1', null, '1', '1', '2022-03-17 14:50:20', '2022-03-17 14:50:49', null);
INSERT INTO `wp_system_dict_data` VALUES ('46', '12', '音频', 'audio', 'attachment_type', '8', '1', null, '1', '1', '2022-03-17 14:50:37', '2022-03-17 14:50:52', null);
INSERT INTO `wp_system_dict_data` VALUES ('47', '12', '视频', 'video', 'attachment_type', '7', '1', null, '1', '1', '2022-03-17 14:50:45', '2022-03-17 14:50:57', null);
INSERT INTO `wp_system_dict_data` VALUES ('48', '12', '应用程序', 'application', 'attachment_type', '6', '1', null, '1', '1', '2022-03-17 14:50:52', '2022-03-17 14:50:59', null);

-- ----------------------------
-- Table structure for `wp_system_dict_type`
-- ----------------------------
DROP TABLE IF EXISTS `wp_system_dict_type`;
CREATE TABLE `wp_system_dict_type` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '字典名称',
  `code` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '字典标示',
  `status` int(11) DEFAULT '1' COMMENT '状态 (1正常 2停用)',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `created_by` int(11) DEFAULT NULL COMMENT '创建者',
  `updated_by` int(11) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='字典类型表';

-- ----------------------------
-- Records of wp_system_dict_type
-- ----------------------------
INSERT INTO `wp_system_dict_type` VALUES ('1', '数据表引擎', 'table_engine', '1', '数据表引擎字典', '1', '1', '2024-03-17 14:50:52', '2024-03-17 14:50:52', null);
INSERT INTO `wp_system_dict_type` VALUES ('2', '存储模式', 'upload_mode', '1', '上传文件存储模式', '1', '1', '2024-03-17 14:50:52', '2024-03-17 14:50:52', null);
INSERT INTO `wp_system_dict_type` VALUES ('3', '数据状态', 'data_status', '1', '通用数据状态', '1', '1', '2024-03-17 14:50:52', '2024-03-17 14:50:52', null);
INSERT INTO `wp_system_dict_type` VALUES ('4', '后台首页', 'dashboard', '1', null, '1', '1', '2024-03-17 14:50:52', '2024-03-17 14:50:52', null);
INSERT INTO `wp_system_dict_type` VALUES ('5', '性别', 'sex', '1', null, '1', '1', '2024-03-17 14:50:52', '2024-03-17 14:50:52', null);
INSERT INTO `wp_system_dict_type` VALUES ('6', '消息类型', 'queue_msg_type', '1', null, '1', '1', '2024-03-17 14:50:52', '2024-03-17 14:50:52', null);
INSERT INTO `wp_system_dict_type` VALUES ('7', '后台公告类型', 'backend_notice_type', '1', null, '1', '1', '2024-03-17 14:50:52', '2024-03-17 14:50:52', null);
INSERT INTO `wp_system_dict_type` VALUES ('8', '请求方式', 'request_mode', '1', null, '1', '1', '2024-03-17 14:50:52', '2024-03-17 14:50:52', null);
INSERT INTO `wp_system_dict_type` VALUES ('12', '附件类型', 'attachment_type', '1', null, '1', '1', '2024-03-17 14:50:52', '2024-03-17 14:50:52', null);

-- ----------------------------
-- Table structure for `wp_system_login_log`
-- ----------------------------
DROP TABLE IF EXISTS `wp_system_login_log`;
CREATE TABLE `wp_system_login_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户名',
  `ip` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '登录IP地址',
  `ip_location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'IP所属地',
  `os` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '操作系统',
  `browser` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '浏览器',
  `status` int(11) DEFAULT '1' COMMENT '登录状态 (1成功 2失败)',
  `message` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '提示消息',
  `login_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '登录时间',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  KEY `idx_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='登录日志表';

-- ----------------------------
-- Records of wp_system_login_log
-- ----------------------------
INSERT INTO `wp_system_login_log` VALUES ('1', 'admin', '127.0.0.1', '内网IP', 'Windows', 'Chrome', '1', '登录成功', '2024-06-23 16:31:38', null, '2024-06-23 16:31:38', '2024-06-23 16:31:38', null);
INSERT INTO `wp_system_login_log` VALUES ('2', 'admin', '127.0.0.1', '内网IP', 'unknown', 'unknown', '1', '登录成功', '2024-06-26 17:33:00', null, '2024-06-26 17:33:00', '2024-06-26 17:33:00', null);
INSERT INTO `wp_system_login_log` VALUES ('3', 'admin', '127.0.0.1', '内网IP', 'unknown', 'unknown', '1', '登录成功', '2024-06-26 17:34:25', null, '2024-06-26 17:34:25', '2024-06-26 17:34:25', null);
INSERT INTO `wp_system_login_log` VALUES ('4', 'admin', '127.0.0.1', '内网IP', 'unknown', 'unknown', '1', '登录成功', '2024-06-26 17:34:59', null, '2024-06-26 17:34:59', '2024-06-26 17:34:59', null);
INSERT INTO `wp_system_login_log` VALUES ('5', 'admin', '127.0.0.1', '内网IP', 'unknown', 'unknown', '0', '账号或密码错误', '2024-06-26 17:35:12', null, '2024-06-26 17:35:12', '2024-06-26 17:35:12', null);
INSERT INTO `wp_system_login_log` VALUES ('6', 'admin', '127.0.0.1', '内网IP', 'unknown', 'unknown', '1', '登录成功', '2024-06-26 17:35:22', null, '2024-06-26 17:35:22', '2024-06-26 17:35:22', null);
INSERT INTO `wp_system_login_log` VALUES ('7', 'admin', '127.0.0.1', '内网IP', 'unknown', 'unknown', '1', '登录成功', '2024-06-26 18:05:22', null, '2024-06-26 18:05:22', '2024-06-26 18:05:22', null);
INSERT INTO `wp_system_login_log` VALUES ('8', 'admin', '127.0.0.1', '内网IP', 'unknown', 'unknown', '1', '登录成功', '2024-06-26 18:07:55', null, '2024-06-26 18:07:55', '2024-06-26 18:07:55', null);
INSERT INTO `wp_system_login_log` VALUES ('9', 'admin', '127.0.0.1', '内网IP', 'unknown', 'unknown', '1', '登录成功', '2024-06-26 18:10:06', null, '2024-06-26 18:10:06', '2024-06-26 18:10:06', null);
INSERT INTO `wp_system_login_log` VALUES ('10', 'admin', '127.0.0.1', '内网IP', 'unknown', 'unknown', '1', '登录成功', '2024-06-26 18:10:17', null, '2024-06-26 18:10:17', '2024-06-26 18:10:17', null);
INSERT INTO `wp_system_login_log` VALUES ('11', 'admin', '127.0.0.1', '内网IP', 'unknown', 'unknown', '1', '登录成功', '2024-06-26 18:12:40', null, '2024-06-26 18:12:40', '2024-06-26 18:12:40', null);
INSERT INTO `wp_system_login_log` VALUES ('12', 'admin', '127.0.0.1', '内网IP', 'unknown', 'unknown', '1', '登录成功', '2024-06-26 20:15:08', null, '2024-06-26 20:15:08', '2024-06-26 20:15:08', null);
INSERT INTO `wp_system_login_log` VALUES ('13', 'admin', '127.0.0.1', '内网IP', 'unknown', 'unknown', '1', '登录成功', '2024-06-26 21:14:01', null, '2024-06-26 21:14:01', '2024-06-26 21:14:01', null);
INSERT INTO `wp_system_login_log` VALUES ('14', 'admin', '127.0.0.1', '内网IP', 'unknown', 'unknown', '1', '登录成功', '2024-06-27 11:05:25', null, '2024-06-27 11:05:25', '2024-06-27 11:05:25', null);
INSERT INTO `wp_system_login_log` VALUES ('15', 'test1', '127.0.0.1', '内网IP', 'unknown', 'unknown', '1', '登录成功', '2024-06-27 11:31:52', null, '2024-06-27 11:31:52', '2024-06-27 11:31:52', null);
INSERT INTO `wp_system_login_log` VALUES ('16', 'test1', '127.0.0.1', '内网IP', 'unknown', 'unknown', '1', '登录成功', '2024-06-27 11:34:47', null, '2024-06-27 11:34:47', '2024-06-27 11:34:47', null);

-- ----------------------------
-- Table structure for `wp_system_menu`
-- ----------------------------
DROP TABLE IF EXISTS `wp_system_menu`;
CREATE TABLE `wp_system_menu` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL COMMENT '父ID',
  `level` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '组级集合',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '菜单名称',
  `code` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '菜单标识代码',
  `icon` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '菜单图标',
  `route` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '路由地址',
  `component` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '组件路径',
  `redirect` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '跳转地址',
  `is_hidden` int(11) DEFAULT '1' COMMENT '是否隐藏 (1是 2否)',
  `type` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '菜单类型, (M菜单 B按钮 L链接 I iframe)',
  `generate_id` int(11) DEFAULT '0' COMMENT '生成id',
  `generate_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '生成key',
  `status` int(11) DEFAULT '1' COMMENT '状态 (1正常 2停用)',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `created_by` int(11) DEFAULT NULL COMMENT '创建者',
  `updated_by` int(11) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4528 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='菜单信息表';

-- ----------------------------
-- Records of wp_system_menu
-- ----------------------------
INSERT INTO `wp_system_menu` VALUES ('1000', '0', '0', '权限', 'permission', 'ma-icon-permission', 'permission', '', null, '2', 'M', '0', null, '1', '99', null, '1', '1', '2021-07-25 18:48:47', '2023-11-14 23:13:42', null);
INSERT INTO `wp_system_menu` VALUES ('1100', '1000', '0,1000', '用户管理', '/core/user', 'ma-icon-user', 'user', 'system/user/index', null, '2', 'M', '0', null, '1', '99', null, '1', '1', '2021-07-25 18:50:15', '2021-07-25 18:50:15', null);
INSERT INTO `wp_system_menu` VALUES ('1101', '1100', '0,1000,1100', '用户列表', '/core/user/index', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 18:50:15', '2021-07-25 18:50:15', null);
INSERT INTO `wp_system_menu` VALUES ('1102', '1100', '0,1000,1100', '用户回收站列表', '/core/user/recycle', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 18:50:15', '2021-07-25 18:50:15', null);
INSERT INTO `wp_system_menu` VALUES ('1103', '1100', '0,1000,1100', '用户保存', '/core/user/save', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 18:50:15', '2021-07-25 18:50:15', null);
INSERT INTO `wp_system_menu` VALUES ('1104', '1100', '0,1000,1100', '用户更新', '/core/user/update', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 18:50:15', '2021-07-25 18:50:15', null);
INSERT INTO `wp_system_menu` VALUES ('1105', '1100', '0,1000,1100', '用户删除', '/core/user/destroy', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 18:50:15', '2021-07-25 18:50:15', null);
INSERT INTO `wp_system_menu` VALUES ('1106', '1100', '0,1000,1100', '用户读取', '/core/user/read', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 18:50:15', '2021-07-25 18:50:15', null);
INSERT INTO `wp_system_menu` VALUES ('1107', '1100', '0,1000,1100', '用户恢复', '/core/user/recovery', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 18:50:15', '2021-07-25 18:50:15', null);
INSERT INTO `wp_system_menu` VALUES ('1108', '1100', '0,1000,1100', '用户销毁', '/core/user/realDestroy', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2024-04-30 16:30:00', '2023-04-30 16:30:00', null);
INSERT INTO `wp_system_menu` VALUES ('1111', '1100', '0,1000,1100', '用户状态改变', '/core/user/changeStatus', '', null, '', null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 18:53:02', '2021-07-25 18:53:02', null);
INSERT INTO `wp_system_menu` VALUES ('1112', '1100', '0,1000,1100', '用户初始化密码', '/core/user/initUserPassword', '', null, '', null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 18:55:55', '2021-07-25 18:55:55', null);
INSERT INTO `wp_system_menu` VALUES ('1113', '1100', '0,1000,1100', '更新用户缓存', '/core/user/cache', '', null, '', null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-08-08 18:30:57', '2021-08-08 18:30:57', null);
INSERT INTO `wp_system_menu` VALUES ('1114', '1100', '0,1000,1100', '设置用户首页', '/core/user/setHomePage', '', null, '', null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-08-08 18:34:30', '2021-08-08 18:34:30', null);
INSERT INTO `wp_system_menu` VALUES ('1200', '1000', '0,1000', '菜单管理', '/core/menu', 'icon-menu', 'menu', 'system/menu/index', null, '2', 'M', '0', null, '1', '96', null, '1', '1', '2021-07-25 19:01:47', '2021-07-25 19:01:47', null);
INSERT INTO `wp_system_menu` VALUES ('1201', '1200', '0,1000,1200', '菜单列表', '/core/menu/index', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 19:01:47', '2021-07-25 19:01:47', null);
INSERT INTO `wp_system_menu` VALUES ('1202', '1200', '0,1000,1200', '菜单回收站', '/core/menu/recycle', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 19:01:47', '2021-07-25 19:01:47', null);
INSERT INTO `wp_system_menu` VALUES ('1203', '1200', '0,1000,1200', '菜单保存', '/core/menu/save', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 19:01:47', '2021-07-25 19:01:47', null);
INSERT INTO `wp_system_menu` VALUES ('1204', '1200', '0,1000,1200', '菜单更新', '/core/menu/update', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 19:01:47', '2021-07-25 19:01:47', null);
INSERT INTO `wp_system_menu` VALUES ('1205', '1200', '0,1000,1200', '菜单删除', '/core/menu/destroy', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 19:01:47', '2021-07-25 19:01:47', null);
INSERT INTO `wp_system_menu` VALUES ('1206', '1200', '0,1000,1200', '菜单读取', '/core/menu/read', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 19:01:47', '2021-07-25 19:01:47', null);
INSERT INTO `wp_system_menu` VALUES ('1207', '1200', '0,1000,1200', '菜单恢复', '/core/menu/recovery', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 19:01:47', '2021-07-25 19:01:47', null);
INSERT INTO `wp_system_menu` VALUES ('1208', '1200', '0,1000,1200', '菜单销毁', '/core/menu/realDestroy', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2024-04-30 16:30:00', '2023-04-30 16:30:00', null);
INSERT INTO `wp_system_menu` VALUES ('1300', '1000', '0,1000', '部门管理', '/core/dept', 'ma-icon-dept', 'dept', 'system/dept/index', null, '2', 'M', '0', null, '1', '97', null, '1', '1', '2021-07-25 19:16:33', '2021-07-25 19:16:33', null);
INSERT INTO `wp_system_menu` VALUES ('1301', '1300', '0,1000,1300', '部门列表', '/core/dept/index', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 19:16:33', '2021-07-25 19:16:33', null);
INSERT INTO `wp_system_menu` VALUES ('1302', '1300', '0,1000,1300', '部门回收站', '/core/dept/recycle', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 19:16:33', '2021-07-25 19:16:33', null);
INSERT INTO `wp_system_menu` VALUES ('1303', '1300', '0,1000,1300', '部门保存', '/core/dept/save', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 19:16:33', '2021-07-25 19:16:33', null);
INSERT INTO `wp_system_menu` VALUES ('1304', '1300', '0,1000,1300', '部门更新', '/core/dept/update', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 19:16:33', '2021-07-25 19:16:33', null);
INSERT INTO `wp_system_menu` VALUES ('1305', '1300', '0,1000,1300', '部门删除', '/core/dept/destroy', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 19:16:33', '2021-07-25 19:16:33', null);
INSERT INTO `wp_system_menu` VALUES ('1306', '1300', '0,1000,1300', '部门读取', '/core/dept/read', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 19:16:33', '2021-07-25 19:16:33', null);
INSERT INTO `wp_system_menu` VALUES ('1307', '1300', '0,1000,1300', '部门恢复', '/core/dept/recovery', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 19:16:33', '2021-07-25 19:16:33', null);
INSERT INTO `wp_system_menu` VALUES ('1308', '1300', '0,1000,1300', '部门销毁', '/core/dept/realDestroy', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2024-04-30 16:30:00', '2023-04-30 16:30:00', null);
INSERT INTO `wp_system_menu` VALUES ('1311', '1300', '0,1000,1300', '部门状态改变', '/core/dept/changeStatus', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-11-09 18:26:15', '2021-11-09 18:26:15', null);
INSERT INTO `wp_system_menu` VALUES ('1400', '1000', '0,1000', '角色管理', '/core/role', 'ma-icon-role', 'role', 'system/role/index', null, '2', 'M', '0', null, '1', '98', null, '1', '1', '2021-07-25 19:17:37', '2021-07-25 19:17:37', null);
INSERT INTO `wp_system_menu` VALUES ('1401', '1400', '0,1000,1400', '角色列表', '/core/role/index', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 19:17:37', '2021-07-25 19:17:37', null);
INSERT INTO `wp_system_menu` VALUES ('1402', '1400', '0,1000,1400', '角色回收站', '/core/role/recycle', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 19:17:38', '2021-07-25 19:17:38', null);
INSERT INTO `wp_system_menu` VALUES ('1403', '1400', '0,1000,1400', '角色保存', '/core/role/save', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 19:17:38', '2021-07-25 19:17:38', null);
INSERT INTO `wp_system_menu` VALUES ('1404', '1400', '0,1000,1400', '角色更新', '/core/role/update', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 19:17:38', '2021-07-25 19:17:38', null);
INSERT INTO `wp_system_menu` VALUES ('1405', '1400', '0,1000,1400', '角色删除', '/core/role/destroy', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 19:17:38', '2021-07-25 19:17:38', null);
INSERT INTO `wp_system_menu` VALUES ('1406', '1400', '0,1000,1400', '角色读取', '/core/role/read', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 19:17:38', '2021-07-25 19:17:38', null);
INSERT INTO `wp_system_menu` VALUES ('1407', '1400', '0,1000,1400', '角色恢复', '/core/role/recovery', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 19:17:38', '2021-07-25 19:17:38', null);
INSERT INTO `wp_system_menu` VALUES ('1408', '1400', '0,1000,1400', '角色销毁', '/core/role/realDestroy', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2024-04-30 16:30:00', '2023-04-30 16:30:00', null);
INSERT INTO `wp_system_menu` VALUES ('1411', '1400', '0,1000,1400', '角色状态改变', '/core/role/changeStatus', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-30 11:21:24', '2021-07-30 11:21:24', null);
INSERT INTO `wp_system_menu` VALUES ('1412', '1400', '0,1000,1400', '更新菜单权限', '/core/role/menuPermission', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-08-09 11:52:33', '2021-08-09 11:52:33', null);
INSERT INTO `wp_system_menu` VALUES ('1413', '1400', '0,1000,1400', '更新数据权限', '/core/role/dataPermission', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-08-09 11:52:52', '2021-08-09 11:52:52', null);
INSERT INTO `wp_system_menu` VALUES ('1500', '1000', '0,1000', '岗位管理', '/core/post', 'ma-icon-post', 'post', 'system/post/index', null, '2', 'M', '0', null, '1', '0', null, '1', '1', '2021-07-25 20:46:38', '2021-07-25 20:46:38', null);
INSERT INTO `wp_system_menu` VALUES ('1501', '1500', '0,1000,1500', '岗位列表', '/core/post/index', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 20:46:38', '2021-07-25 20:46:38', null);
INSERT INTO `wp_system_menu` VALUES ('1502', '1500', '0,1000,1500', '岗位回收站', '/core/post/recycle', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 20:46:38', '2021-07-25 20:46:38', null);
INSERT INTO `wp_system_menu` VALUES ('1503', '1500', '0,1000,1500', '岗位保存', '/core/post/save', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 20:46:38', '2021-07-25 20:46:38', null);
INSERT INTO `wp_system_menu` VALUES ('1504', '1500', '0,1000,1500', '岗位更新', '/core/post/update', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 20:46:38', '2021-07-25 20:46:38', null);
INSERT INTO `wp_system_menu` VALUES ('1505', '1500', '0,1000,1500', '岗位删除', '/core/post/destroy', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 20:46:38', '2021-07-25 20:46:38', null);
INSERT INTO `wp_system_menu` VALUES ('1506', '1500', '0,1000,1500', '岗位读取', '/core/post/read', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 20:46:38', '2021-07-25 20:46:38', null);
INSERT INTO `wp_system_menu` VALUES ('1507', '1500', '0,1000,1500', '岗位恢复', '/core/post/recovery', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 20:46:38', '2021-07-25 20:46:38', null);
INSERT INTO `wp_system_menu` VALUES ('1508', '1500', '0,1000,1500', '岗位销毁', '/core/post/realDestroy', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2024-04-30 16:30:00', '2023-04-30 16:30:00', null);
INSERT INTO `wp_system_menu` VALUES ('1511', '1500', '0,1000,1500', '岗位状态改变', '/core/post/changeStatus', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-11-09 18:26:15', '2021-11-09 18:26:15', null);
INSERT INTO `wp_system_menu` VALUES ('1512', '1500', '0,1000,1500', '岗位导入', '/core/post/import', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 17:17:03', '2021-07-31 17:17:03', null);
INSERT INTO `wp_system_menu` VALUES ('1513', '1500', '0,1000,1500', '岗位导出', '/core/post/export', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 17:17:03', '2021-07-31 17:17:03', null);
INSERT INTO `wp_system_menu` VALUES ('2000', '0', '0', '数据', 'dataCenter', 'icon-storage', 'dataCenter', null, null, '2', 'M', '0', null, '1', '98', null, '1', '1', '2021-07-31 17:17:03', '2021-07-31 17:17:03', null);
INSERT INTO `wp_system_menu` VALUES ('2100', '2000', '0,2000', '数据字典', '/core/dictType', 'ma-icon-dict', 'dict', 'system/dict/index', null, '2', 'M', '0', null, '1', '99', null, '1', '1', '2021-07-31 18:33:45', '2021-07-31 18:33:45', null);
INSERT INTO `wp_system_menu` VALUES ('2101', '2100', '0,2000,2100', '数据字典列表', '/core/dictType/index', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 18:33:45', '2021-07-31 18:33:45', null);
INSERT INTO `wp_system_menu` VALUES ('2102', '2100', '0,2000,2100', '数据字典回收站', '/core/dictType/recycle', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 18:33:45', '2021-07-31 18:33:45', null);
INSERT INTO `wp_system_menu` VALUES ('2103', '2100', '0,2000,2100', '数据字典保存', '/core/dictType/save', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 18:33:45', '2021-07-31 18:33:45', null);
INSERT INTO `wp_system_menu` VALUES ('2104', '2100', '0,2000,2100', '数据字典更新', '/core/dictType/update', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 18:33:45', '2021-07-31 18:33:45', null);
INSERT INTO `wp_system_menu` VALUES ('2105', '2100', '0,2000,2100', '数据字典删除', '/core/dictType/destroy', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 18:33:45', '2021-07-31 18:33:45', null);
INSERT INTO `wp_system_menu` VALUES ('2106', '2100', '0,2000,2100', '数据字典读取', '/core/dictType/read', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 18:33:46', '2021-07-31 18:33:46', null);
INSERT INTO `wp_system_menu` VALUES ('2107', '2100', '0,2000,2100', '数据字典恢复', '/core/dictType/recovery', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 18:33:46', '2021-07-31 18:33:46', null);
INSERT INTO `wp_system_menu` VALUES ('2108', '2100', '0,2000,2100', '数据字典销毁', '/core/dictType/realDestroy', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2024-04-30 16:30:00', '2023-04-30 16:30:00', null);
INSERT INTO `wp_system_menu` VALUES ('2112', '2100', '0,2000,2100', '字典状态改变', '/core/dictType/changeStatus', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-11-09 18:26:15', '2021-11-09 18:26:15', null);
INSERT INTO `wp_system_menu` VALUES ('2200', '2000', '0,2000', '附件管理', '/core/attachment', 'ma-icon-attach', 'attachment', 'system/attachment/index', null, '2', 'M', '0', null, '1', '98', null, '1', '1', '2021-07-31 18:36:34', '2021-07-31 18:36:34', null);
INSERT INTO `wp_system_menu` VALUES ('2201', '2200', '0,2000,2200', '附件删除', '/core/attachment/destroy', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 18:37:20', '2021-07-31 18:37:20', null);
INSERT INTO `wp_system_menu` VALUES ('2202', '2200', '0,2000,2200', '附件列表', '/core/attachment/index', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 18:38:05', '2021-07-31 18:38:05', null);
INSERT INTO `wp_system_menu` VALUES ('2203', '2200', '0,2000,2200', '附件回收站', '/core/attachment/recycle', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 18:38:57', '2021-07-31 18:38:57', null);
INSERT INTO `wp_system_menu` VALUES ('2204', '2200', '0,2000,2200', '附件恢复', '/core/attachment/recovery', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 18:40:44', '2021-07-31 18:40:44', null);
INSERT INTO `wp_system_menu` VALUES ('2205', '2200', '0,2000,2200', '附件销毁', '/core/attachment/realDestroy', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2024-04-30 16:30:00', '2023-04-30 16:30:00', null);
INSERT INTO `wp_system_menu` VALUES ('2300', '2000', '0,2000', '数据表维护', '/core/dataMaintain', 'ma-icon-db', 'dataMaintain', 'system/dataMaintain/index', null, '2', 'M', '0', null, '1', '95', null, '1', '1', '2021-07-31 18:43:20', '2021-07-31 18:43:20', null);
INSERT INTO `wp_system_menu` VALUES ('2301', '2300', '0,2000,2300', '数据表列表', '/core/dataMaintain/index', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 18:44:03', '2021-07-31 18:44:03', null);
INSERT INTO `wp_system_menu` VALUES ('2302', '2300', '0,2000,2300', '数据表详细', '/core/dataMaintain/detailed', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 18:45:17', '2021-07-31 18:45:17', null);
INSERT INTO `wp_system_menu` VALUES ('2303', '2300', '0,2000,2300', '数据表清理碎片', '/core/dataMaintain/fragment', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 18:46:04', '2021-07-31 18:46:04', null);
INSERT INTO `wp_system_menu` VALUES ('2304', '2300', '0,2000,2300', '数据表优化', '/core/dataMaintain/optimize', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 18:46:31', '2021-07-31 18:46:31', null);
INSERT INTO `wp_system_menu` VALUES ('2700', '2000', '0,2000', '系统公告', '/core/notice', 'icon-bulb', 'notice', 'system/notice/index', null, '2', 'M', '0', null, '1', '94', null, '1', '1', '2021-12-25 18:10:20', '2021-12-25 18:10:20', null);
INSERT INTO `wp_system_menu` VALUES ('2701', '2700', '0,2000,2700', '系统公告列表', '/core/notice/index', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-12-25 18:10:20', '2021-12-25 18:10:20', null);
INSERT INTO `wp_system_menu` VALUES ('2702', '2700', '0,2000,2700', '系统公告回收站', '/core/notice/recycle', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-12-25 18:10:20', '2021-12-25 18:10:20', null);
INSERT INTO `wp_system_menu` VALUES ('2703', '2700', '0,2000,2700', '系统公告保存', '/core/notice/save', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-12-25 18:10:20', '2021-12-25 18:10:20', null);
INSERT INTO `wp_system_menu` VALUES ('2704', '2700', '0,2000,2700', '系统公告更新', '/core/notice/update', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-12-25 18:10:20', '2021-12-25 18:10:20', null);
INSERT INTO `wp_system_menu` VALUES ('2705', '2700', '0,2000,2700', '系统公告删除', '/core/notice/destroy', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-12-25 18:10:20', '2021-12-25 18:10:20', null);
INSERT INTO `wp_system_menu` VALUES ('2706', '2700', '0,2000,2700', '系统公告读取', '/core/notice/read', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-12-25 18:10:20', '2021-12-25 18:10:20', null);
INSERT INTO `wp_system_menu` VALUES ('2707', '2700', '0,2000,2700', '系统公告恢复', '/core/notice/recovery', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-12-25 18:10:20', '2021-12-25 18:10:20', null);
INSERT INTO `wp_system_menu` VALUES ('2708', '2700', '0,2000,2700', '系统公告销毁', '/core/notice/realDestroy', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2024-04-30 16:30:00', '2023-04-30 16:30:00', null);
INSERT INTO `wp_system_menu` VALUES ('3000', '0', '0', '监控', 'monitor', 'icon-desktop', 'monitor', null, null, '2', 'M', '0', null, '1', '97', null, '1', '1', '2021-07-31 18:49:24', '2021-07-31 18:49:24', null);
INSERT INTO `wp_system_menu` VALUES ('3200', '3000', '0,3000', '服务监控', '/core/system/monitor', 'icon-thunderbolt', 'server', 'system/monitor/server/index', null, '2', 'M', '0', null, '1', '99', null, '1', '1', '2021-07-31 18:52:46', '2021-07-31 18:52:46', null);
INSERT INTO `wp_system_menu` VALUES ('3300', '3000', '0,3000', '日志监控', 'logs', 'icon-book', 'logs', null, null, '2', 'M', '0', null, '1', '95', null, '1', '1', '2021-07-31 18:54:01', '2021-07-31 18:54:01', null);
INSERT INTO `wp_system_menu` VALUES ('3400', '3300', '0,3000,3200', '登录日志', '/core/logs/deleteLoginLog', 'icon-idcard', 'loginLog', 'system/logs/loginLog', null, '2', 'M', '0', null, '1', '0', null, '1', '1', '2021-07-31 18:54:55', '2021-07-31 18:54:55', null);
INSERT INTO `wp_system_menu` VALUES ('3401', '3400', '0,3000,3200,3300', '登录日志删除', '/core/logs/deleteOperLog', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 18:56:43', '2021-07-31 18:56:43', null);
INSERT INTO `wp_system_menu` VALUES ('3500', '3300', '0,3000,3200', '操作日志', '/core/logs/getOperLogPageList', 'icon-robot', 'operLog', 'system/logs/operLog', null, '2', 'M', '0', null, '1', '0', null, '1', '1', '2021-07-31 18:55:40', '2021-07-31 18:55:40', null);
INSERT INTO `wp_system_menu` VALUES ('3501', '3500', '0,3000,3200,3400', '操作日志删除', '/core/logs/deleteOperLog', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 18:56:19', '2021-07-31 18:56:19', null);
INSERT INTO `wp_system_menu` VALUES ('4000', '0', '0', '工具', 'devTools', 'ma-icon-tool', 'devTools', null, null, '2', 'M', '0', null, '1', '95', null, '1', '1', '2021-07-31 19:03:32', '2021-07-31 19:03:32', null);
INSERT INTO `wp_system_menu` VALUES ('4200', '4000', '0,4000', '代码生成器', '/tool/code', 'ma-icon-code', 'code', 'setting/code/index', null, '2', 'M', '0', null, '1', '98', null, '1', '1', '2021-07-31 19:36:17', '2021-07-31 19:36:17', null);
INSERT INTO `wp_system_menu` VALUES ('4400', '4000', '0,4000', '定时任务', '/core/crontab', 'icon-schedule', 'crontab', 'setting/crontab/index', null, '2', 'M', '0', null, '1', '0', null, '1', '1', '2021-07-31 19:47:49', '2021-07-31 19:47:49', null);
INSERT INTO `wp_system_menu` VALUES ('4401', '4400', '0,4000,4400', '定时任务列表', '/core/crontab/index', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 19:47:49', '2021-07-31 19:47:49', null);
INSERT INTO `wp_system_menu` VALUES ('4402', '4400', '0,4000,4400', '定时任务保存', '/core/crontab/save', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 19:47:49', '2021-07-31 19:47:49', null);
INSERT INTO `wp_system_menu` VALUES ('4403', '4400', '0,4000,4400', '定时任务更新', '/core/crontab/update', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 19:47:49', '2021-07-31 19:47:49', null);
INSERT INTO `wp_system_menu` VALUES ('4404', '4400', '0,4000,4400', '定时任务删除', '/core/crontab/destroy', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 19:47:49', '2021-07-31 19:47:49', null);
INSERT INTO `wp_system_menu` VALUES ('4405', '4400', '0,4000,4400', '定时任务读取', '/core/crontab/read', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 19:47:49', '2021-07-31 19:47:49', null);
INSERT INTO `wp_system_menu` VALUES ('4408', '4400', '0,4000,4400', '定时任务执行', '/core/crontab/run', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-08-07 23:44:06', '2021-08-07 23:44:06', null);
INSERT INTO `wp_system_menu` VALUES ('4409', '4400', '0,4000,4400', '定时任务日志删除', '/core/crontab/deleteLog', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-12-06 22:06:12', '2021-12-06 22:06:12', null);
INSERT INTO `wp_system_menu` VALUES ('4500', '0', '0', '系统设置', '/core/config', 'icon-settings', 'system', 'setting/config/index', null, '2', 'M', '0', null, '1', '0', null, '1', '1', '2021-07-31 19:58:57', '2023-12-13 14:49:47', null);
INSERT INTO `wp_system_menu` VALUES ('4502', '4500', '0,4500', '配置列表', '/core/config/index', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-08-10 13:09:18', '2021-08-10 13:09:18', null);
INSERT INTO `wp_system_menu` VALUES ('4504', '4500', '0,4500', '新增配置 ', '/core/config/save', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-08-10 13:11:56', '2021-08-10 13:11:56', null);
INSERT INTO `wp_system_menu` VALUES ('4505', '4500', '0,4500', '更新配置', '/core/config/update', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-08-10 13:12:25', '2021-08-10 13:12:25', null);
INSERT INTO `wp_system_menu` VALUES ('4506', '4500', '0,4500', '删除配置', '/core/config/destroy', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-08-10 13:13:33', '2021-08-10 13:13:33', null);
INSERT INTO `wp_system_menu` VALUES ('4507', '4500', '0,4500', '清除配置缓存', '/core/config/clearCache', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-08-10 13:13:59', '2021-08-10 13:13:59', null);
INSERT INTO `wp_system_menu` VALUES ('4508', '4000', '0,4000', '文章管理', 'cms/news/article', 'icon-home', 'cms/news/article', 'cms/news/article/index', null, '2', 'M', '3', null, '1', '0', null, '1', '1', '2024-06-23 16:35:45', '2024-06-23 16:35:45', null);
INSERT INTO `wp_system_menu` VALUES ('4509', '4508', '4000,4508', '文章管理列表', '/cms/news/Article/index', null, null, null, null, '1', 'B', '0', 'index', '1', '0', null, '1', '1', '2024-06-23 16:35:45', '2024-06-23 16:35:45', null);
INSERT INTO `wp_system_menu` VALUES ('4510', '4508', '4000,4508', '文章管理保存', '/cms/news/Article/save', null, null, null, null, '1', 'B', '0', 'save', '1', '0', null, '1', '1', '2024-06-23 16:35:45', '2024-06-23 16:35:45', null);
INSERT INTO `wp_system_menu` VALUES ('4511', '4508', '4000,4508', '文章管理更新', '/cms/news/Article/update', null, null, null, null, '1', 'B', '0', 'update', '1', '0', null, '1', '1', '2024-06-23 16:35:45', '2024-06-23 16:35:45', null);
INSERT INTO `wp_system_menu` VALUES ('4512', '4508', '4000,4508', '文章管理读取', '/cms/news/Article/read', null, null, null, null, '1', 'B', '0', 'read', '1', '0', null, '1', '1', '2024-06-23 16:35:45', '2024-06-23 16:35:45', null);
INSERT INTO `wp_system_menu` VALUES ('4513', '4508', '4000,4508', '文章管理修改状态', '/cms/news/Article/changeStatus', null, null, null, null, '1', 'B', '0', 'changeStatus', '1', '0', null, '1', '1', '2024-06-23 16:35:45', '2024-06-23 16:35:45', null);
INSERT INTO `wp_system_menu` VALUES ('4514', '4508', '4000,4508', '文章管理删除', '/cms/news/Article/destroy', null, null, null, null, '1', 'B', '0', 'destroy', '1', '0', null, '1', '1', '2024-06-23 16:35:45', '2024-06-23 16:35:45', null);
INSERT INTO `wp_system_menu` VALUES ('4515', '4508', '4000,4508', '文章管理回收', '/cms/news/Article/recycle', null, null, null, null, '1', 'B', '0', 'recycle', '1', '0', null, '1', '1', '2024-06-23 16:35:45', '2024-06-23 16:35:45', null);
INSERT INTO `wp_system_menu` VALUES ('4516', '4508', '4000,4508', '文章管理恢复', '/cms/news/Article/recovery', null, null, null, null, '1', 'B', '0', 'recovery', '1', '0', null, '1', '1', '2024-06-23 16:35:45', '2024-06-23 16:35:45', null);
INSERT INTO `wp_system_menu` VALUES ('4517', '4508', '4000,4508', '文章管理销毁', '/cms/news/Article/realDestroy', null, null, null, null, '1', 'B', '0', 'realDestroy', '1', '0', null, '1', '1', '2024-06-23 16:35:45', '2024-06-23 16:35:45', null);
INSERT INTO `wp_system_menu` VALUES ('4518', '4000', '0,4000', '文章分类', 'cms/news/category', 'icon-home', 'cms/news/category', 'cms/news/category/index', null, '2', 'M', '4', null, '1', '0', null, '1', '1', '2024-06-23 16:35:49', '2024-06-23 16:35:49', null);
INSERT INTO `wp_system_menu` VALUES ('4519', '4518', '4000,4518', '文章分类列表', '/cms/news/ArticleCategory/index', null, null, null, null, '1', 'B', '0', 'index', '1', '0', null, '1', '1', '2024-06-23 16:35:49', '2024-06-23 16:35:49', null);
INSERT INTO `wp_system_menu` VALUES ('4520', '4518', '4000,4518', '文章分类保存', '/cms/news/ArticleCategory/save', null, null, null, null, '1', 'B', '0', 'save', '1', '0', null, '1', '1', '2024-06-23 16:35:49', '2024-06-23 16:35:49', null);
INSERT INTO `wp_system_menu` VALUES ('4521', '4518', '4000,4518', '文章分类更新', '/cms/news/ArticleCategory/update', null, null, null, null, '1', 'B', '0', 'update', '1', '0', null, '1', '1', '2024-06-23 16:35:49', '2024-06-23 16:35:49', null);
INSERT INTO `wp_system_menu` VALUES ('4522', '4518', '4000,4518', '文章分类读取', '/cms/news/ArticleCategory/read', null, null, null, null, '1', 'B', '0', 'read', '1', '0', null, '1', '1', '2024-06-23 16:35:49', '2024-06-23 16:35:49', null);
INSERT INTO `wp_system_menu` VALUES ('4523', '4518', '4000,4518', '文章分类修改状态', '/cms/news/ArticleCategory/changeStatus', null, null, null, null, '1', 'B', '0', 'changeStatus', '1', '0', null, '1', '1', '2024-06-23 16:35:49', '2024-06-23 16:35:49', null);
INSERT INTO `wp_system_menu` VALUES ('4524', '4518', '4000,4518', '文章分类删除', '/cms/news/ArticleCategory/destroy', null, null, null, null, '1', 'B', '0', 'destroy', '1', '0', null, '1', '1', '2024-06-23 16:35:49', '2024-06-23 16:35:49', null);
INSERT INTO `wp_system_menu` VALUES ('4525', '4518', '4000,4518', '文章分类回收', '/cms/news/ArticleCategory/recycle', null, null, null, null, '1', 'B', '0', 'recycle', '1', '0', null, '1', '1', '2024-06-23 16:35:49', '2024-06-23 16:35:49', null);
INSERT INTO `wp_system_menu` VALUES ('4526', '4518', '4000,4518', '文章分类恢复', '/cms/news/ArticleCategory/recovery', null, null, null, null, '1', 'B', '0', 'recovery', '1', '0', null, '1', '1', '2024-06-23 16:35:49', '2024-06-23 16:35:49', null);
INSERT INTO `wp_system_menu` VALUES ('4527', '4518', '4000,4518', '文章分类销毁', '/cms/news/ArticleCategory/realDestroy', null, null, null, null, '1', 'B', '0', 'realDestroy', '1', '0', null, '1', '1', '2024-06-23 16:35:49', '2024-06-23 16:35:49', null);

-- ----------------------------
-- Table structure for `wp_system_notice`
-- ----------------------------
DROP TABLE IF EXISTS `wp_system_notice`;
CREATE TABLE `wp_system_notice` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `message_id` int(11) DEFAULT NULL COMMENT '消息ID',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  `type` int(11) DEFAULT NULL COMMENT '公告类型(1通知 2公告)',
  `content` text COLLATE utf8mb4_unicode_ci COMMENT '公告内容',
  `click_num` int(11) DEFAULT '0' COMMENT '浏览次数',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `created_by` int(11) DEFAULT NULL COMMENT '创建人',
  `updated_by` int(11) DEFAULT NULL COMMENT '更新人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  KEY `message_id` (`message_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统公告表';

-- ----------------------------
-- Records of wp_system_notice
-- ----------------------------
INSERT INTO `wp_system_notice` VALUES ('1', null, '欢迎使用SaiAdmin', '1', '<p>saiadmin是一款基于vue3 + webman 的极速开发框架，前端开发采用JavaScript，后端采用PHP</p>', '0', null, '1', '1', '2024-01-20 15:55:36', '2024-01-20 15:55:36', null);

-- ----------------------------
-- Table structure for `wp_system_operation_log`
-- ----------------------------
DROP TABLE IF EXISTS `wp_system_operation_log`;
CREATE TABLE `wp_system_operation_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户名',
  `app` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '应用名称',
  `method` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '请求方式',
  `router` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '请求路由',
  `service_name` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '业务名称',
  `ip` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '请求IP地址',
  `ip_location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'IP所属地',
  `request_data` text COLLATE utf8mb4_unicode_ci COMMENT '请求数据',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `created_by` int(11) DEFAULT NULL COMMENT '创建者',
  `updated_by` int(11) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  KEY `username_index` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='操作日志表';

-- ----------------------------
-- Records of wp_system_operation_log
-- ----------------------------
INSERT INTO `wp_system_operation_log` VALUES ('1', '', 'backend', 'POST', '/backend/login/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"uuid\":\"abcd\",\"captcha\":\"abcd\",\"client\":\"WEB\"}', null, null, null, '2024-06-26 18:10:06', '2024-06-26 18:10:06', null);
INSERT INTO `wp_system_operation_log` VALUES ('2', '', 'backend', 'POST', '/backend/login/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"uuid\":\"abcd\",\"captcha\":\"abcd\",\"client\":\"WEB\"}', null, null, null, '2024-06-26 18:10:17', '2024-06-26 18:10:17', null);
INSERT INTO `wp_system_operation_log` VALUES ('3', 'admin', 'backend', 'POST', '/backend/system/test', '未知', '127.0.0.1', '内网IP', '[]', null, null, null, '2024-06-26 21:13:31', '2024-06-26 21:13:31', null);
INSERT INTO `wp_system_operation_log` VALUES ('4', 'admin', 'backend', 'POST', '/backend/system/test', '未知', '127.0.0.1', '内网IP', '[]', null, null, null, '2024-06-27 11:05:42', '2024-06-27 11:05:42', null);
INSERT INTO `wp_system_operation_log` VALUES ('5', '', 'backend', 'POST', '/backend/system/test', '未知', '127.0.0.1', '内网IP', '[]', null, null, null, '2024-06-27 11:06:46', '2024-06-27 11:06:46', null);
INSERT INTO `wp_system_operation_log` VALUES ('6', 'admin', 'backend', 'POST', '/backend/system/test', '未知', '127.0.0.1', '内网IP', '[]', null, null, null, '2024-06-27 11:06:54', '2024-06-27 11:06:54', null);

-- ----------------------------
-- Table structure for `wp_system_post`
-- ----------------------------
DROP TABLE IF EXISTS `wp_system_post`;
CREATE TABLE `wp_system_post` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '岗位名称',
  `code` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '岗位代码',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `status` int(11) DEFAULT '1' COMMENT '状态 (1正常 2停用)',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `created_by` int(11) DEFAULT NULL COMMENT '创建者',
  `updated_by` int(11) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='岗位信息表';

-- ----------------------------
-- Records of wp_system_post
-- ----------------------------
INSERT INTO `wp_system_post` VALUES ('1', '总经理', 'zongjingli', '1', '1', null, '1', '1', '2023-10-24 12:00:00', '2023-12-04 18:02:32', null);
INSERT INTO `wp_system_post` VALUES ('2', '技术经理', 'jishujingli', '10', '1', null, '1', '1', '2023-10-24 12:00:00', '2023-11-15 10:29:47', null);
INSERT INTO `wp_system_post` VALUES ('3', '销售经理', 'xiaoshoujingli', '5', '1', null, '1', '1', '2023-10-24 12:00:00', '2023-11-15 11:54:50', null);
INSERT INTO `wp_system_post` VALUES ('4', '员工', 'yuangong', '1', '1', null, '1', '1', '2023-10-24 12:00:00', '2023-11-15 09:51:12', null);
INSERT INTO `wp_system_post` VALUES ('5', '测试岗位', 'test', '15', '1', null, '1', '1', '2023-11-15 09:42:08', '2023-12-06 21:40:46', null);
INSERT INTO `wp_system_post` VALUES ('6', '技术部', 'jishu', '100', '1', null, '1', '1', '2023-12-12 16:19:33', '2023-12-12 16:28:24', null);

-- ----------------------------
-- Table structure for `wp_system_role`
-- ----------------------------
DROP TABLE IF EXISTS `wp_system_role`;
CREATE TABLE `wp_system_role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '角色名称',
  `code` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '角色代码',
  `data_scope` int(11) DEFAULT '1' COMMENT '数据范围(1:全部数据权限 2:自定义数据权限 3:本部门数据权限 4:本部门及以下数据权限 5:本人数据权限)',
  `status` int(11) DEFAULT '1' COMMENT '状态 (1正常 2停用)',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `created_by` int(11) DEFAULT NULL COMMENT '创建者',
  `updated_by` int(11) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色信息表';

-- ----------------------------
-- Records of wp_system_role
-- ----------------------------
INSERT INTO `wp_system_role` VALUES ('1', '超级管理员（创始人）', 'superAdmin', '1', '1', '100', '系统内置角色，不可删除', '1', '1', '2023-10-24 12:00:00', '2023-10-24 12:00:00', null);
INSERT INTO `wp_system_role` VALUES ('2', '总管理员', 'maxAdmin', '5', '1', '1', null, '1', '1', '2023-10-24 12:00:00', '2023-11-22 23:06:36', null);
INSERT INTO `wp_system_role` VALUES ('3', '区域管理员', 'areaAdmin', '2', '1', '1', '', '1', '1', '2023-10-24 12:00:00', '2023-10-24 12:00:00', null);
INSERT INTO `wp_system_role` VALUES ('4', '部门领导', 'deptLeader', '3', '1', '1', null, '1', '1', '2023-10-24 12:00:00', '2023-10-24 12:00:00', null);
INSERT INTO `wp_system_role` VALUES ('5', '机构管理员', 'companyAdmin', '4', '1', '1', null, '1', '1', '2023-10-24 12:00:00', '2023-10-24 12:00:00', null);
INSERT INTO `wp_system_role` VALUES ('6', '员工', 'staff', '5', '1', '1', null, '1', '1', '2023-10-24 12:00:00', '2023-12-12 16:11:12', null);

-- ----------------------------
-- Table structure for `wp_system_role_department`
-- ----------------------------
DROP TABLE IF EXISTS `wp_system_role_department`;
CREATE TABLE `wp_system_role_department` (
  `role_id` int(11) unsigned NOT NULL COMMENT '用户主键',
  `department_id` int(11) unsigned NOT NULL COMMENT '角色主键',
  PRIMARY KEY (`role_id`,`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色与部门关联表';

-- ----------------------------
-- Records of wp_system_role_department
-- ----------------------------
INSERT INTO `wp_system_role_department` VALUES ('2', '2');
INSERT INTO `wp_system_role_department` VALUES ('2', '4');
INSERT INTO `wp_system_role_department` VALUES ('2', '5');

-- ----------------------------
-- Table structure for `wp_system_role_menu`
-- ----------------------------
DROP TABLE IF EXISTS `wp_system_role_menu`;
CREATE TABLE `wp_system_role_menu` (
  `role_id` int(11) unsigned NOT NULL COMMENT '角色主键',
  `menu_id` int(11) unsigned NOT NULL COMMENT '菜单主键',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色与菜单关联表';

-- ----------------------------
-- Records of wp_system_role_menu
-- ----------------------------

-- ----------------------------
-- Table structure for `wp_system_upload`
-- ----------------------------
DROP TABLE IF EXISTS `wp_system_upload`;
CREATE TABLE `wp_system_upload` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `storage_mode` int(11) DEFAULT '1' COMMENT '存储模式 (1 本地 2 阿里云 3 七牛云 4 腾讯云)',
  `origin_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '原文件名',
  `object_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '新文件名',
  `hash` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '文件hash',
  `mime_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '资源类型',
  `storage_path` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '存储目录',
  `suffix` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '文件后缀',
  `size_byte` bigint(20) DEFAULT NULL COMMENT '字节数',
  `size_info` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '文件大小',
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'url地址',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `created_by` int(11) DEFAULT NULL COMMENT '创建者',
  `updated_by` int(11) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `hash` (`hash`),
  KEY `storage_path` (`storage_path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='上传文件信息表';

-- ----------------------------
-- Records of wp_system_upload
-- ----------------------------

-- ----------------------------
-- Table structure for `wp_system_user`
-- ----------------------------
DROP TABLE IF EXISTS `wp_system_user`;
CREATE TABLE `wp_system_user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `password` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `user_type` varchar(3) COLLATE utf8mb4_unicode_ci DEFAULT '100' COMMENT '用户类型:(100系统用户)',
  `nickname` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户昵称',
  `phone` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '手机',
  `email` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户邮箱',
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户头像',
  `signed` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '个人签名',
  `dashboard` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '后台首页类型',
  `dept_id` int(11) DEFAULT NULL COMMENT '部门ID',
  `status` int(11) DEFAULT '1' COMMENT '状态 (1正常 2停用)',
  `login_ip` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '最后登陆IP',
  `login_time` datetime DEFAULT NULL COMMENT '最后登陆时间',
  `backend_setting` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '后台设置数据',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `created_by` int(11) DEFAULT NULL COMMENT '创建者',
  `updated_by` int(11) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unx_dept_id` (`username`),
  KEY `idx_dept_id` (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户信息表';

-- ----------------------------
-- Records of wp_system_user
-- ----------------------------
INSERT INTO `wp_system_user` VALUES ('1', 'admin', '$2y$10$Q70WC9RBqMSS72DmppsbIuQtyAydXSmeD.Ae6W8YhmE/w15uLLpiy', '100', '祭道之上', '13888888888', 'admin@admin.com', 'http://127.0.0.1:8787/storage/20240623/98fc9d262014cbed0ea1580e2f3d9da71ad29853.png', 'Today is very good！', 'statistics', null, '1', '127.0.0.1', '2024-06-27 11:05:25', '{\"mode\":\"light\",\"tag\":true,\"menuCollapse\":false,\"menuWidth\":230,\"layout\":\"classic\",\"skin\":\"mine\",\"i18n\":true,\"language\":\"zh_CN\",\"animation\":\"ma-slide-down\",\"color\":\"#165DFF\"}', null, '1', '1', '2024-01-20 16:02:23', '2024-06-27 11:05:25', null);
INSERT INTO `wp_system_user` VALUES ('2', 'test1', '$2y$10$Q70WC9RBqMSS72DmppsbIuQtyAydXSmeD.Ae6W8YhmE/w15uLLpiy', '100', '小小测试员', '15822222222', 'test@saadmin.com', 'http://127.0.0.1:8787/storage/20240623/c5a22be92d325a2b8e0b3d609394dd86d1977fb5.png', null, 'work', '5', '1', '127.0.0.1', '2024-06-27 11:34:47', 'null', null, '1', '1', '2023-11-15 14:30:14', '2024-06-27 11:34:47', null);
INSERT INTO `wp_system_user` VALUES ('3', 'test2', '', '100', '酱油党', '13977777777', 'zhang@saadmin.com', 'http://localhost:8787/upload/image/20231222/65854211f2a6.jpg', null, 'statistics', '2', '1', '127.0.0.1', '2023-11-22 22:47:26', 'null', '5566', '1', '1', '2023-11-15 16:27:27', '2024-06-23 16:32:39', null);

-- ----------------------------
-- Table structure for `wp_system_user_post`
-- ----------------------------
DROP TABLE IF EXISTS `wp_system_user_post`;
CREATE TABLE `wp_system_user_post` (
  `user_id` int(11) unsigned NOT NULL COMMENT '用户主键',
  `post_id` int(11) unsigned NOT NULL COMMENT '岗位主键',
  PRIMARY KEY (`user_id`,`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户与岗位关联表';

-- ----------------------------
-- Records of wp_system_user_post
-- ----------------------------
INSERT INTO `wp_system_user_post` VALUES ('2', '3');
INSERT INTO `wp_system_user_post` VALUES ('3', '3');

-- ----------------------------
-- Table structure for `wp_system_user_role`
-- ----------------------------
DROP TABLE IF EXISTS `wp_system_user_role`;
CREATE TABLE `wp_system_user_role` (
  `user_id` int(11) unsigned NOT NULL COMMENT '用户主键',
  `role_id` int(11) unsigned NOT NULL COMMENT '角色主键',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户与角色关联表';

-- ----------------------------
-- Records of wp_system_user_role
-- ----------------------------
INSERT INTO `wp_system_user_role` VALUES ('1', '1');
INSERT INTO `wp_system_user_role` VALUES ('2', '2');
INSERT INTO `wp_system_user_role` VALUES ('3', '2');

-- ----------------------------
-- Table structure for `wp_tool_generate_columns`
-- ----------------------------
DROP TABLE IF EXISTS `wp_tool_generate_columns`;
CREATE TABLE `wp_tool_generate_columns` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `table_id` int(11) DEFAULT NULL COMMENT '所属表ID',
  `column_name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '字段名称',
  `column_comment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '字段注释',
  `column_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '字段类型',
  `default_value` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '默认值',
  `is_pk` int(11) DEFAULT '1' COMMENT '1 非主键 2 主键',
  `is_required` int(11) DEFAULT '1' COMMENT '1 非必填 2 必填',
  `is_insert` int(11) DEFAULT '1' COMMENT '1 非插入字段 2 插入字段',
  `is_edit` int(11) DEFAULT '1' COMMENT '1 非编辑字段 2 编辑字段',
  `is_list` int(11) DEFAULT '1' COMMENT '1 非列表显示字段 2 列表显示字段',
  `is_query` int(11) DEFAULT '1' COMMENT '1 非查询字段 2 查询字段',
  `query_type` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT 'eq' COMMENT '查询方式 eq 等于, neq 不等于, gt 大于, lt 小于, like 范围',
  `view_type` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT 'text' COMMENT '页面控件,text, textarea, password, select, checkbox, radio, date, upload, ma-upload(封装的上传控件)',
  `dict_type` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '字典类型',
  `allow_roles` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '允许查看该字段的角色',
  `options` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '字段其他设置',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `created_by` int(11) DEFAULT NULL COMMENT '创建者',
  `updated_by` int(11) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  KEY `idx_table_id` (`table_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='代码生成业务字段表';

-- ----------------------------
-- Records of wp_tool_generate_columns
-- ----------------------------

-- ----------------------------
-- Table structure for `wp_tool_generate_tables`
-- ----------------------------
DROP TABLE IF EXISTS `wp_tool_generate_tables`;
CREATE TABLE `wp_tool_generate_tables` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `table_name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '表名称',
  `table_comment` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '表注释',
  `stub` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'stub类型',
  `template` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '模板名称',
  `namespace` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '命名空间',
  `package_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '控制器包名',
  `business_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '业务名称',
  `class_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '类名称',
  `menu_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '生成菜单名',
  `belong_menu_id` int(11) DEFAULT NULL COMMENT '所属菜单',
  `tpl_category` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '生成类型,single 单表CRUD,tree 树表CRUD,parent_sub父子表CRUD',
  `generate_type` int(11) DEFAULT '1' COMMENT '1 压缩包下载 2 生成到模块',
  `generate_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'saiadmin-vue' COMMENT '前端根目录',
  `generate_menus` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '生成菜单列表',
  `build_menu` int(11) DEFAULT '1' COMMENT '是否构建菜单',
  `component_type` int(11) DEFAULT '1' COMMENT '组件显示方式',
  `options` varchar(1500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '其他业务选项',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `source` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '数据源',
  `created_by` int(11) DEFAULT NULL COMMENT '创建者',
  `updated_by` int(11) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  KEY `idx_table_name` (`table_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='代码生成业务表';

-- ----------------------------
-- Records of wp_tool_generate_tables
-- ----------------------------
