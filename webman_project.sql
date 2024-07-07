/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50740
Source Host           : localhost:3306
Source Database       : webman_project

Target Server Type    : MYSQL
Target Server Version : 50740
File Encoding         : 65001

Date: 2024-07-07 18:39:51
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
INSERT INTO `wp_system_config` VALUES ('1', '1', 'site_copyright', 'Copyright © 2024 JiaoshiAdmin', '版权信息', 'textarea', null, '96', '');
INSERT INTO `wp_system_config` VALUES ('2', '1', 'site_desc', '基于vue3 + webman 的极速开发框架', '网站描述', 'textarea', null, '97', null);
INSERT INTO `wp_system_config` VALUES ('3', '1', 'site_keywords', '后台管理系统', '网站关键字', 'input', null, '98', null);
INSERT INTO `wp_system_config` VALUES ('4', '1', 'site_name', 'JiaoshiAdmin', '网站名称', 'input', null, '99', null);
INSERT INTO `wp_system_config` VALUES ('5', '1', 'site_record_number', '', '网站备案号', 'input', null, '95', null);
INSERT INTO `wp_system_config` VALUES ('6', '2', 'upload_allow_file', 'txt,doc,docx,xls,xlsx,ppt,pptx,rar,zip,7z,gz,pdf,wps,md', '文件类型', 'input', null, '0', null);
INSERT INTO `wp_system_config` VALUES ('7', '2', 'upload_allow_image', 'jpg,jpeg,png,gif,svg,bmp', '图片类型', 'input', null, '0', null);
INSERT INTO `wp_system_config` VALUES ('8', '2', 'upload_mode', '4', '上传模式', 'select', '[{\"label\":\"本地上传\",\"value\":\"1\"},{\"label\":\"阿里云OSS\",\"value\":\"2\"},{\"label\":\"七牛云\",\"value\":\"3\"},{\"label\":\"腾讯云COS\",\"value\":\"4\"}]', '99', null);
INSERT INTO `wp_system_config` VALUES ('10', '2', 'upload_size', '5242880', '上传大小', 'input', null, '88', '单位Byte,1MB=1024*1024Byte');
INSERT INTO `wp_system_config` VALUES ('11', '2', 'local_root', 'public/storage/', '本地存储路径', 'input', null, '0', '本地存储文件路径');
INSERT INTO `wp_system_config` VALUES ('12', '2', 'local_domain', 'http://127.0.0.1:8787', '本地存储域名', 'input', null, '0', 'http://127.0.0.1:8787');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='定时任务执行日志表';

-- ----------------------------
-- Records of wp_system_crontab_log
-- ----------------------------
INSERT INTO `wp_system_crontab_log` VALUES ('1', '2', '登录gitee', 'https://gitee.com/check_user_login', '{\"user_login\": \"project\"}', '{\"result\":1,\"failed_count\":10}', '1', '2024-07-07 10:00:01', '2024-07-07 10:00:01', null);

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
-- Table structure for `wp_system_dictionary`
-- ----------------------------
DROP TABLE IF EXISTS `wp_system_dictionary`;
CREATE TABLE `wp_system_dictionary` (
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
-- Records of wp_system_dictionary
-- ----------------------------
INSERT INTO `wp_system_dictionary` VALUES ('1', '1', 'InnoDB', 'InnoDB', 'table_engine', '1', '1', null, '1', '1', '2021-06-27 00:37:11', '2023-12-06 21:54:25', null);
INSERT INTO `wp_system_dictionary` VALUES ('2', '1', 'MyISAM', 'MyISAM', 'table_engine', '1', '1', null, '1', '1', '2021-06-27 00:37:21', '2023-11-16 11:51:35', null);
INSERT INTO `wp_system_dictionary` VALUES ('3', '2', '本地存储', '1', 'upload_mode', '99', '1', null, '1', '1', '2021-06-27 13:33:43', '2021-06-27 13:33:43', null);
INSERT INTO `wp_system_dictionary` VALUES ('4', '2', '阿里云OSS', '2', 'upload_mode', '98', '1', null, '1', '1', '2021-06-27 13:33:55', '2021-06-27 13:33:55', null);
INSERT INTO `wp_system_dictionary` VALUES ('5', '2', '七牛云', '3', 'upload_mode', '97', '1', null, '1', '1', '2021-06-27 13:34:07', '2023-12-13 16:50:26', null);
INSERT INTO `wp_system_dictionary` VALUES ('6', '2', '腾讯云COS', '4', 'upload_mode', '96', '1', null, '1', '1', '2021-06-27 13:34:19', '2023-12-13 16:47:34', null);
INSERT INTO `wp_system_dictionary` VALUES ('7', '3', '正常', '1', 'data_status', '0', '1', '1为正常', '1', '1', '2021-06-27 13:36:51', '2021-06-27 13:37:01', null);
INSERT INTO `wp_system_dictionary` VALUES ('8', '3', '停用', '2', 'data_status', '0', '1', '2为停用', '1', '1', '2021-06-27 13:37:10', '2021-06-27 13:37:10', null);
INSERT INTO `wp_system_dictionary` VALUES ('9', '4', '统计页面', 'statistics', 'dashboard', '0', '1', '管理员用', '1', '1', '2021-08-09 12:53:53', '2023-11-16 11:39:17', null);
INSERT INTO `wp_system_dictionary` VALUES ('10', '4', '工作台', 'work', 'dashboard', '0', '1', '员工使用', '1', '1', '2021-08-09 12:54:18', '2021-08-09 12:54:18', null);
INSERT INTO `wp_system_dictionary` VALUES ('11', '5', '男', '1', 'sex', '0', '1', null, '1', '1', '2021-08-09 12:55:00', '2021-08-09 12:55:00', null);
INSERT INTO `wp_system_dictionary` VALUES ('12', '5', '女', '2', 'sex', '0', '1', null, '1', '1', '2021-08-09 12:55:08', '2021-08-09 12:55:08', null);
INSERT INTO `wp_system_dictionary` VALUES ('13', '5', '未知', '3', 'sex', '0', '1', null, '1', '1', '2021-08-09 12:55:16', '2021-08-09 12:55:16', null);
INSERT INTO `wp_system_dictionary` VALUES ('22', '7', '通知', '1', 'backend_notice_type', '2', '1', null, '1', '1', '2021-11-11 17:29:27', '2021-11-11 17:30:51', null);
INSERT INTO `wp_system_dictionary` VALUES ('23', '7', '公告', '2', 'backend_notice_type', '1', '1', null, '1', '1', '2021-11-11 17:31:42', '2021-11-11 17:31:42', null);
INSERT INTO `wp_system_dictionary` VALUES ('24', '8', '所有', 'A', 'request_mode', '5', '1', null, '1', '1', '2021-11-14 17:23:25', '2023-12-13 17:21:28', null);
INSERT INTO `wp_system_dictionary` VALUES ('25', '8', 'GET', 'G', 'request_mode', '4', '1', null, '1', '1', '2021-11-14 17:23:45', '2023-12-13 17:21:28', null);
INSERT INTO `wp_system_dictionary` VALUES ('26', '8', 'POST', 'P', 'request_mode', '3', '1', null, '1', '1', '2021-11-14 17:23:38', '2023-12-13 17:21:28', null);
INSERT INTO `wp_system_dictionary` VALUES ('27', '8', 'PUT', 'U', 'request_mode', '2', '1', null, '1', '1', '2021-11-14 17:23:45', '2023-12-13 17:21:28', null);
INSERT INTO `wp_system_dictionary` VALUES ('28', '8', 'DELETE', 'D', 'request_mode', '1', '1', null, '1', '1', '2021-11-14 17:23:45', '2023-12-13 17:21:28', null);
INSERT INTO `wp_system_dictionary` VALUES ('39', '6', '通知', 'notice', 'queue_msg_type', '1', '1', null, '1', '1', '2021-12-25 18:30:31', '2024-01-20 14:42:55', null);
INSERT INTO `wp_system_dictionary` VALUES ('40', '6', '公告', 'announcement', 'queue_msg_type', '2', '1', null, '1', '1', '2021-12-25 18:31:00', '2024-01-20 14:42:57', null);
INSERT INTO `wp_system_dictionary` VALUES ('41', '6', '待办', 'todo', 'queue_msg_type', '3', '1', null, '1', '1', '2021-12-25 18:31:26', '2024-01-20 14:42:59', null);
INSERT INTO `wp_system_dictionary` VALUES ('42', '6', '抄送我的', 'carbon_copy_mine', 'queue_msg_type', '4', '1', null, '1', '1', '2021-12-25 18:31:26', '2024-01-20 14:42:59', null);
INSERT INTO `wp_system_dictionary` VALUES ('43', '6', '私信', 'private_message', 'queue_msg_type', '5', '1', null, '1', '1', '2021-12-25 18:31:26', '2024-01-20 14:42:59', null);
INSERT INTO `wp_system_dictionary` VALUES ('44', '12', '图片', 'image', 'attachment_type', '10', '1', null, '1', '1', '2022-03-17 14:49:59', '2022-03-17 14:49:59', null);
INSERT INTO `wp_system_dictionary` VALUES ('45', '12', '文档', 'text', 'attachment_type', '9', '1', null, '1', '1', '2022-03-17 14:50:20', '2022-03-17 14:50:49', null);
INSERT INTO `wp_system_dictionary` VALUES ('46', '12', '音频', 'audio', 'attachment_type', '8', '1', null, '1', '1', '2022-03-17 14:50:37', '2022-03-17 14:50:52', null);
INSERT INTO `wp_system_dictionary` VALUES ('47', '12', '视频', 'video', 'attachment_type', '7', '1', null, '1', '1', '2022-03-17 14:50:45', '2022-03-17 14:50:57', null);
INSERT INTO `wp_system_dictionary` VALUES ('48', '12', '应用程序', 'application', 'attachment_type', '6', '1', null, '1', '1', '2022-03-17 14:50:52', '2022-03-17 14:50:59', null);

-- ----------------------------
-- Table structure for `wp_system_dictionary_type`
-- ----------------------------
DROP TABLE IF EXISTS `wp_system_dictionary_type`;
CREATE TABLE `wp_system_dictionary_type` (
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
-- Records of wp_system_dictionary_type
-- ----------------------------
INSERT INTO `wp_system_dictionary_type` VALUES ('1', '数据表引擎', 'table_engine', '1', '数据表引擎字典', '1', '1', '2024-03-17 14:50:52', '2024-03-17 14:50:52', null);
INSERT INTO `wp_system_dictionary_type` VALUES ('2', '存储模式', 'upload_mode', '1', '上传文件存储模式', '1', '1', '2024-03-17 14:50:52', '2024-03-17 14:50:52', null);
INSERT INTO `wp_system_dictionary_type` VALUES ('3', '数据状态', 'data_status', '1', '通用数据状态', '1', '1', '2024-03-17 14:50:52', '2024-03-17 14:50:52', null);
INSERT INTO `wp_system_dictionary_type` VALUES ('4', '后台首页', 'dashboard', '1', null, '1', '1', '2024-03-17 14:50:52', '2024-03-17 14:50:52', null);
INSERT INTO `wp_system_dictionary_type` VALUES ('5', '性别', 'sex', '1', null, '1', '1', '2024-03-17 14:50:52', '2024-03-17 14:50:52', null);
INSERT INTO `wp_system_dictionary_type` VALUES ('6', '消息类型', 'queue_msg_type', '1', null, '1', '1', '2024-03-17 14:50:52', '2024-03-17 14:50:52', null);
INSERT INTO `wp_system_dictionary_type` VALUES ('7', '后台公告类型', 'backend_notice_type', '1', null, '1', '1', '2024-03-17 14:50:52', '2024-03-17 14:50:52', null);
INSERT INTO `wp_system_dictionary_type` VALUES ('8', '请求方式', 'request_mode', '1', null, '1', '1', '2024-03-17 14:50:52', '2024-03-17 14:50:52', null);
INSERT INTO `wp_system_dictionary_type` VALUES ('12', '附件类型', 'attachment_type', '1', null, '1', '1', '2024-03-17 14:50:52', '2024-03-17 14:50:52', null);

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
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='登录日志表';

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
INSERT INTO `wp_system_login_log` VALUES ('17', 'test1', '127.0.0.1', '内网IP', 'unknown', 'unknown', '1', '登录成功', '2024-06-27 14:52:07', null, '2024-06-27 14:52:07', '2024-06-27 14:52:07', null);
INSERT INTO `wp_system_login_log` VALUES ('18', 'admin', '127.0.0.1', '内网IP', 'unknown', 'unknown', '1', '登录成功', '2024-06-27 14:52:11', null, '2024-06-27 14:52:11', '2024-06-27 14:52:11', null);
INSERT INTO `wp_system_login_log` VALUES ('19', 'test1', '127.0.0.1', '内网IP', 'unknown', 'unknown', '1', '登录成功', '2024-06-27 14:52:58', null, '2024-06-27 14:52:58', '2024-06-27 14:52:58', null);
INSERT INTO `wp_system_login_log` VALUES ('20', 'admin', '127.0.0.1', '内网IP', 'unknown', 'unknown', '1', '登录成功', '2024-06-29 20:10:39', null, '2024-06-29 20:10:39', '2024-06-29 20:10:39', null);
INSERT INTO `wp_system_login_log` VALUES ('21', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-06-29 20:34:01', null, '2024-06-29 20:34:01', '2024-06-29 20:34:01', null);
INSERT INTO `wp_system_login_log` VALUES ('22', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-06-29 20:49:27', null, '2024-06-29 20:49:27', '2024-06-29 20:49:27', null);
INSERT INTO `wp_system_login_log` VALUES ('23', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-06-29 20:53:52', null, '2024-06-29 20:53:52', '2024-06-29 20:53:52', null);
INSERT INTO `wp_system_login_log` VALUES ('24', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-06-29 20:55:36', null, '2024-06-29 20:55:36', '2024-06-29 20:55:36', null);
INSERT INTO `wp_system_login_log` VALUES ('25', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-06-29 20:58:05', null, '2024-06-29 20:58:05', '2024-06-29 20:58:05', null);
INSERT INTO `wp_system_login_log` VALUES ('26', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-06-29 21:00:17', null, '2024-06-29 21:00:17', '2024-06-29 21:00:17', null);
INSERT INTO `wp_system_login_log` VALUES ('27', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-06-29 21:02:20', null, '2024-06-29 21:02:20', '2024-06-29 21:02:20', null);
INSERT INTO `wp_system_login_log` VALUES ('28', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-06-29 21:02:29', null, '2024-06-29 21:02:29', '2024-06-29 21:02:29', null);
INSERT INTO `wp_system_login_log` VALUES ('29', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-06-29 21:06:55', null, '2024-06-29 21:06:55', '2024-06-29 21:06:55', null);
INSERT INTO `wp_system_login_log` VALUES ('30', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-06-29 21:09:12', null, '2024-06-29 21:09:12', '2024-06-29 21:09:12', null);
INSERT INTO `wp_system_login_log` VALUES ('31', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-06-29 21:12:03', null, '2024-06-29 21:12:03', '2024-06-29 21:12:03', null);
INSERT INTO `wp_system_login_log` VALUES ('32', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-06-29 21:15:00', null, '2024-06-29 21:15:00', '2024-06-29 21:15:00', null);
INSERT INTO `wp_system_login_log` VALUES ('33', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-06-29 21:15:25', null, '2024-06-29 21:15:25', '2024-06-29 21:15:25', null);
INSERT INTO `wp_system_login_log` VALUES ('34', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-06-29 21:16:24', null, '2024-06-29 21:16:24', '2024-06-29 21:16:24', null);
INSERT INTO `wp_system_login_log` VALUES ('35', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-06-29 21:16:38', null, '2024-06-29 21:16:38', '2024-06-29 21:16:38', null);
INSERT INTO `wp_system_login_log` VALUES ('36', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-06-29 21:17:28', null, '2024-06-29 21:17:28', '2024-06-29 21:17:28', null);
INSERT INTO `wp_system_login_log` VALUES ('37', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-06-29 21:17:45', null, '2024-06-29 21:17:45', '2024-06-29 21:17:45', null);
INSERT INTO `wp_system_login_log` VALUES ('38', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-06-29 21:19:42', null, '2024-06-29 21:19:42', '2024-06-29 21:19:42', null);
INSERT INTO `wp_system_login_log` VALUES ('39', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-06-29 21:22:28', null, '2024-06-29 21:22:28', '2024-06-29 21:22:28', null);
INSERT INTO `wp_system_login_log` VALUES ('40', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-06-29 21:29:28', null, '2024-06-29 21:29:28', '2024-06-29 21:29:28', null);
INSERT INTO `wp_system_login_log` VALUES ('41', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-06-29 21:32:45', null, '2024-06-29 21:32:45', '2024-06-29 21:32:45', null);
INSERT INTO `wp_system_login_log` VALUES ('42', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-06-29 21:34:01', null, '2024-06-29 21:34:01', '2024-06-29 21:34:01', null);
INSERT INTO `wp_system_login_log` VALUES ('43', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-06-29 21:36:16', null, '2024-06-29 21:36:16', '2024-06-29 21:36:16', null);
INSERT INTO `wp_system_login_log` VALUES ('44', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-06-29 21:36:56', null, '2024-06-29 21:36:56', '2024-06-29 21:36:56', null);
INSERT INTO `wp_system_login_log` VALUES ('45', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-06-29 21:37:25', null, '2024-06-29 21:37:25', '2024-06-29 21:37:25', null);
INSERT INTO `wp_system_login_log` VALUES ('46', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-06-29 21:38:12', null, '2024-06-29 21:38:12', '2024-06-29 21:38:12', null);
INSERT INTO `wp_system_login_log` VALUES ('47', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-06-29 21:38:31', null, '2024-06-29 21:38:31', '2024-06-29 21:38:31', null);
INSERT INTO `wp_system_login_log` VALUES ('48', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-06-29 21:38:49', null, '2024-06-29 21:38:49', '2024-06-29 21:38:49', null);
INSERT INTO `wp_system_login_log` VALUES ('49', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-06-29 21:39:12', null, '2024-06-29 21:39:12', '2024-06-29 21:39:12', null);
INSERT INTO `wp_system_login_log` VALUES ('50', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-06-29 21:40:31', null, '2024-06-29 21:40:31', '2024-06-29 21:40:31', null);
INSERT INTO `wp_system_login_log` VALUES ('51', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-06-29 21:41:07', null, '2024-06-29 21:41:07', '2024-06-29 21:41:07', null);
INSERT INTO `wp_system_login_log` VALUES ('52', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-06-29 21:49:58', null, '2024-06-29 21:49:58', '2024-06-29 21:49:58', null);
INSERT INTO `wp_system_login_log` VALUES ('53', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-07-01 10:14:47', null, '2024-07-01 10:14:47', '2024-07-01 10:14:47', null);
INSERT INTO `wp_system_login_log` VALUES ('54', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-07-01 10:15:00', null, '2024-07-01 10:15:00', '2024-07-01 10:15:00', null);
INSERT INTO `wp_system_login_log` VALUES ('55', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-07-01 10:15:28', null, '2024-07-01 10:15:28', '2024-07-01 10:15:28', null);
INSERT INTO `wp_system_login_log` VALUES ('56', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-07-01 10:19:51', null, '2024-07-01 10:19:51', '2024-07-01 10:19:51', null);
INSERT INTO `wp_system_login_log` VALUES ('57', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-07-01 10:26:23', null, '2024-07-01 10:26:23', '2024-07-01 10:26:23', null);
INSERT INTO `wp_system_login_log` VALUES ('58', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-07-03 16:12:20', null, '2024-07-03 16:12:20', '2024-07-03 16:12:20', null);
INSERT INTO `wp_system_login_log` VALUES ('59', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-07-03 17:14:30', null, '2024-07-03 17:14:30', '2024-07-03 17:14:30', null);
INSERT INTO `wp_system_login_log` VALUES ('60', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-07-03 17:14:38', null, '2024-07-03 17:14:38', '2024-07-03 17:14:38', null);
INSERT INTO `wp_system_login_log` VALUES ('61', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-07-03 17:56:02', null, '2024-07-03 17:56:02', '2024-07-03 17:56:02', null);
INSERT INTO `wp_system_login_log` VALUES ('62', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-07-05 11:09:17', null, '2024-07-05 11:09:17', '2024-07-05 11:09:17', null);
INSERT INTO `wp_system_login_log` VALUES ('63', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-07-05 11:51:03', null, '2024-07-05 11:51:03', '2024-07-05 11:51:03', null);
INSERT INTO `wp_system_login_log` VALUES ('64', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-07-05 14:13:47', null, '2024-07-05 14:13:47', '2024-07-05 14:13:47', null);
INSERT INTO `wp_system_login_log` VALUES ('65', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-07-05 18:20:56', null, '2024-07-05 18:20:56', '2024-07-05 18:20:56', null);
INSERT INTO `wp_system_login_log` VALUES ('66', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-07-05 19:30:52', null, '2024-07-05 19:30:52', '2024-07-05 19:30:52', null);
INSERT INTO `wp_system_login_log` VALUES ('67', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-07-06 11:23:22', null, '2024-07-06 11:23:22', '2024-07-06 11:23:22', null);
INSERT INTO `wp_system_login_log` VALUES ('68', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-07-06 14:42:19', null, '2024-07-06 14:42:19', '2024-07-06 14:42:19', null);
INSERT INTO `wp_system_login_log` VALUES ('69', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-07-06 18:20:23', null, '2024-07-06 18:20:23', '2024-07-06 18:20:23', null);
INSERT INTO `wp_system_login_log` VALUES ('70', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-07-07 08:15:49', null, '2024-07-07 08:15:49', '2024-07-07 08:15:49', null);
INSERT INTO `wp_system_login_log` VALUES ('71', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-07-07 11:11:30', null, '2024-07-07 11:11:30', '2024-07-07 11:11:30', null);
INSERT INTO `wp_system_login_log` VALUES ('72', 'admin', '127.0.0.1', '内网IP', 'Windows 10', 'Chrome', '1', '登录成功', '2024-07-07 17:32:31', null, '2024-07-07 17:32:31', '2024-07-07 17:32:31', null);

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
INSERT INTO `wp_system_menu` VALUES ('1100', '1000', '0,1000', '用户管理', '/backend/admin', 'ma-icon-user', 'admin', 'system/user/index', null, '2', 'M', '0', null, '1', '99', null, '1', '1', '2021-07-25 18:50:15', '2021-07-25 18:50:15', null);
INSERT INTO `wp_system_menu` VALUES ('1101', '1100', '0,1000,1100', '用户列表', '/backend/admin/index', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 18:50:15', '2021-07-25 18:50:15', null);
INSERT INTO `wp_system_menu` VALUES ('1102', '1100', '0,1000,1100', '用户回收站列表', '/backend/admin/recycle', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 18:50:15', '2021-07-25 18:50:15', null);
INSERT INTO `wp_system_menu` VALUES ('1103', '1100', '0,1000,1100', '用户保存', '/backend/admin/save', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 18:50:15', '2021-07-25 18:50:15', null);
INSERT INTO `wp_system_menu` VALUES ('1104', '1100', '0,1000,1100', '用户更新', '/backend/admin/update', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 18:50:15', '2021-07-25 18:50:15', null);
INSERT INTO `wp_system_menu` VALUES ('1105', '1100', '0,1000,1100', '用户删除', '/backend/admin/destroy', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 18:50:15', '2021-07-25 18:50:15', null);
INSERT INTO `wp_system_menu` VALUES ('1106', '1100', '0,1000,1100', '用户读取', '/backend/admin/read', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 18:50:15', '2021-07-25 18:50:15', null);
INSERT INTO `wp_system_menu` VALUES ('1107', '1100', '0,1000,1100', '用户恢复', '/backend/admin/recovery', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 18:50:15', '2021-07-25 18:50:15', null);
INSERT INTO `wp_system_menu` VALUES ('1108', '1100', '0,1000,1100', '用户销毁', '/backend/admin/realDestroy', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2024-04-30 16:30:00', '2023-04-30 16:30:00', null);
INSERT INTO `wp_system_menu` VALUES ('1111', '1100', '0,1000,1100', '用户状态改变', '/backend/admin/changeStatus', '', null, '', null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 18:53:02', '2021-07-25 18:53:02', null);
INSERT INTO `wp_system_menu` VALUES ('1112', '1100', '0,1000,1100', '用户初始化密码', '/backend/admin/initPassword', '', null, '', null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 18:55:55', '2021-07-25 18:55:55', null);
INSERT INTO `wp_system_menu` VALUES ('1113', '1100', '0,1000,1100', '更新用户缓存', '/backend/admin/cache', '', null, '', null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-08-08 18:30:57', '2021-08-08 18:30:57', null);
INSERT INTO `wp_system_menu` VALUES ('1114', '1100', '0,1000,1100', '设置用户首页', '/backend/admin/setHomePage', '', null, '', null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-08-08 18:34:30', '2021-08-08 18:34:30', null);
INSERT INTO `wp_system_menu` VALUES ('1200', '1000', '0,1000', '菜单管理', '/backend/menu', 'icon-menu', 'menu', 'system/menu/index', null, '2', 'M', '0', null, '1', '96', null, '1', '1', '2021-07-25 19:01:47', '2021-07-25 19:01:47', null);
INSERT INTO `wp_system_menu` VALUES ('1201', '1200', '0,1000,1200', '菜单列表', '/backend/menu/index', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 19:01:47', '2021-07-25 19:01:47', null);
INSERT INTO `wp_system_menu` VALUES ('1202', '1200', '0,1000,1200', '菜单回收站', '/backend/menu/recycle', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 19:01:47', '2021-07-25 19:01:47', null);
INSERT INTO `wp_system_menu` VALUES ('1203', '1200', '0,1000,1200', '菜单保存', '/backend/menu/save', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 19:01:47', '2021-07-25 19:01:47', null);
INSERT INTO `wp_system_menu` VALUES ('1204', '1200', '0,1000,1200', '菜单更新', '/backend/menu/update', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 19:01:47', '2021-07-25 19:01:47', null);
INSERT INTO `wp_system_menu` VALUES ('1205', '1200', '0,1000,1200', '菜单删除', '/backend/menu/destroy', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 19:01:47', '2021-07-25 19:01:47', null);
INSERT INTO `wp_system_menu` VALUES ('1206', '1200', '0,1000,1200', '菜单读取', '/backend/menu/read', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 19:01:47', '2021-07-25 19:01:47', null);
INSERT INTO `wp_system_menu` VALUES ('1207', '1200', '0,1000,1200', '菜单恢复', '/backend/menu/recovery', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 19:01:47', '2021-07-25 19:01:47', null);
INSERT INTO `wp_system_menu` VALUES ('1208', '1200', '0,1000,1200', '菜单销毁', '/backend/menu/realDestroy', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2024-04-30 16:30:00', '2023-04-30 16:30:00', null);
INSERT INTO `wp_system_menu` VALUES ('1300', '1000', '0,1000', '部门管理', '/backend/department', 'ma-icon-dept', 'department', 'system/department/index', null, '2', 'M', '0', null, '1', '97', null, '1', '1', '2021-07-25 19:16:33', '2021-07-25 19:16:33', null);
INSERT INTO `wp_system_menu` VALUES ('1301', '1300', '0,1000,1300', '部门列表', '/backend/department/index', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 19:16:33', '2021-07-25 19:16:33', null);
INSERT INTO `wp_system_menu` VALUES ('1302', '1300', '0,1000,1300', '部门回收站', '/backend/department/recycle', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 19:16:33', '2021-07-25 19:16:33', null);
INSERT INTO `wp_system_menu` VALUES ('1303', '1300', '0,1000,1300', '部门保存', '/backend/department/save', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 19:16:33', '2021-07-25 19:16:33', null);
INSERT INTO `wp_system_menu` VALUES ('1304', '1300', '0,1000,1300', '部门更新', '/backend/department/update', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 19:16:33', '2021-07-25 19:16:33', null);
INSERT INTO `wp_system_menu` VALUES ('1305', '1300', '0,1000,1300', '部门删除', '/backend/department/destroy', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 19:16:33', '2021-07-25 19:16:33', null);
INSERT INTO `wp_system_menu` VALUES ('1306', '1300', '0,1000,1300', '部门读取', '/backend/department/read', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 19:16:33', '2021-07-25 19:16:33', null);
INSERT INTO `wp_system_menu` VALUES ('1307', '1300', '0,1000,1300', '部门恢复', '/backend/department/recovery', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 19:16:33', '2021-07-25 19:16:33', null);
INSERT INTO `wp_system_menu` VALUES ('1308', '1300', '0,1000,1300', '部门销毁', '/backend/department/realDestroy', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2024-04-30 16:30:00', '2023-04-30 16:30:00', null);
INSERT INTO `wp_system_menu` VALUES ('1311', '1300', '0,1000,1300', '部门状态改变', '/backend/department/changeStatus', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-11-09 18:26:15', '2021-11-09 18:26:15', null);
INSERT INTO `wp_system_menu` VALUES ('1400', '1000', '0,1000', '角色管理', '/backend/role', 'ma-icon-role', 'role', 'system/role/index', null, '2', 'M', '0', null, '1', '98', null, '1', '1', '2021-07-25 19:17:37', '2021-07-25 19:17:37', null);
INSERT INTO `wp_system_menu` VALUES ('1401', '1400', '0,1000,1400', '角色列表', '/backend/role/index', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 19:17:37', '2021-07-25 19:17:37', null);
INSERT INTO `wp_system_menu` VALUES ('1402', '1400', '0,1000,1400', '角色回收站', '/backend/role/recycle', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 19:17:38', '2021-07-25 19:17:38', null);
INSERT INTO `wp_system_menu` VALUES ('1403', '1400', '0,1000,1400', '角色保存', '/backend/role/save', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 19:17:38', '2021-07-25 19:17:38', null);
INSERT INTO `wp_system_menu` VALUES ('1404', '1400', '0,1000,1400', '角色更新', '/backend/role/update', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 19:17:38', '2021-07-25 19:17:38', null);
INSERT INTO `wp_system_menu` VALUES ('1405', '1400', '0,1000,1400', '角色删除', '/backend/role/destroy', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 19:17:38', '2021-07-25 19:17:38', null);
INSERT INTO `wp_system_menu` VALUES ('1406', '1400', '0,1000,1400', '角色读取', '/backend/role/read', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 19:17:38', '2021-07-25 19:17:38', null);
INSERT INTO `wp_system_menu` VALUES ('1407', '1400', '0,1000,1400', '角色恢复', '/backend/role/recovery', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 19:17:38', '2021-07-25 19:17:38', null);
INSERT INTO `wp_system_menu` VALUES ('1408', '1400', '0,1000,1400', '角色销毁', '/backend/role/realDestroy', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2024-04-30 16:30:00', '2023-04-30 16:30:00', null);
INSERT INTO `wp_system_menu` VALUES ('1411', '1400', '0,1000,1400', '角色状态改变', '/backend/role/changeStatus', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-30 11:21:24', '2021-07-30 11:21:24', null);
INSERT INTO `wp_system_menu` VALUES ('1412', '1400', '0,1000,1400', '更新菜单权限', '/backend/role/menuPermission', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-08-09 11:52:33', '2021-08-09 11:52:33', null);
INSERT INTO `wp_system_menu` VALUES ('1413', '1400', '0,1000,1400', '更新数据权限', '/backend/role/dataPermission', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-08-09 11:52:52', '2021-08-09 11:52:52', null);
INSERT INTO `wp_system_menu` VALUES ('1500', '1000', '0,1000', '岗位管理', '/backend/post', 'ma-icon-post', 'post', 'system/post/index', null, '2', 'M', '0', null, '1', '0', null, '1', '1', '2021-07-25 20:46:38', '2021-07-25 20:46:38', null);
INSERT INTO `wp_system_menu` VALUES ('1501', '1500', '0,1000,1500', '岗位列表', '/backend/post/index', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 20:46:38', '2021-07-25 20:46:38', null);
INSERT INTO `wp_system_menu` VALUES ('1502', '1500', '0,1000,1500', '岗位回收站', '/backend/post/recycle', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 20:46:38', '2021-07-25 20:46:38', null);
INSERT INTO `wp_system_menu` VALUES ('1503', '1500', '0,1000,1500', '岗位保存', '/backend/post/save', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 20:46:38', '2021-07-25 20:46:38', null);
INSERT INTO `wp_system_menu` VALUES ('1504', '1500', '0,1000,1500', '岗位更新', '/backend/post/update', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 20:46:38', '2021-07-25 20:46:38', null);
INSERT INTO `wp_system_menu` VALUES ('1505', '1500', '0,1000,1500', '岗位删除', '/backend/post/destroy', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 20:46:38', '2021-07-25 20:46:38', null);
INSERT INTO `wp_system_menu` VALUES ('1506', '1500', '0,1000,1500', '岗位读取', '/backend/post/read', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 20:46:38', '2021-07-25 20:46:38', null);
INSERT INTO `wp_system_menu` VALUES ('1507', '1500', '0,1000,1500', '岗位恢复', '/backend/post/recovery', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-25 20:46:38', '2021-07-25 20:46:38', null);
INSERT INTO `wp_system_menu` VALUES ('1508', '1500', '0,1000,1500', '岗位销毁', '/backend/post/realDestroy', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2024-04-30 16:30:00', '2023-04-30 16:30:00', null);
INSERT INTO `wp_system_menu` VALUES ('1511', '1500', '0,1000,1500', '岗位状态改变', '/backend/post/changeStatus', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-11-09 18:26:15', '2021-11-09 18:26:15', null);
INSERT INTO `wp_system_menu` VALUES ('1512', '1500', '0,1000,1500', '岗位导入', '/backend/post/import', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 17:17:03', '2021-07-31 17:17:03', null);
INSERT INTO `wp_system_menu` VALUES ('1513', '1500', '0,1000,1500', '岗位导出', '/backend/post/export', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 17:17:03', '2021-07-31 17:17:03', null);
INSERT INTO `wp_system_menu` VALUES ('2000', '0', '0', '数据', 'dataCenter', 'icon-storage', 'dataCenter', null, null, '2', 'M', '0', null, '1', '98', null, '1', '1', '2021-07-31 17:17:03', '2021-07-31 17:17:03', null);
INSERT INTO `wp_system_menu` VALUES ('2100', '2000', '0,2000', '数据字典', '/backend/dictionary', 'ma-icon-dict', 'dictionary', 'system/dictionary/index', null, '2', 'M', '0', null, '1', '99', null, '1', '1', '2021-07-31 18:33:45', '2021-07-31 18:33:45', null);
INSERT INTO `wp_system_menu` VALUES ('2101', '2100', '0,2000,2100', '数据字典列表', '/backend/dictionary/index', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 18:33:45', '2021-07-31 18:33:45', null);
INSERT INTO `wp_system_menu` VALUES ('2102', '2100', '0,2000,2100', '数据字典回收站', '/backend/dictionary/recycle', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 18:33:45', '2021-07-31 18:33:45', null);
INSERT INTO `wp_system_menu` VALUES ('2103', '2100', '0,2000,2100', '数据字典保存', '/backend/dictionary/save', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 18:33:45', '2021-07-31 18:33:45', null);
INSERT INTO `wp_system_menu` VALUES ('2104', '2100', '0,2000,2100', '数据字典更新', '/backend/dictionary/update', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 18:33:45', '2021-07-31 18:33:45', null);
INSERT INTO `wp_system_menu` VALUES ('2105', '2100', '0,2000,2100', '数据字典删除', '/backend/dictionary/destroy', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 18:33:45', '2021-07-31 18:33:45', null);
INSERT INTO `wp_system_menu` VALUES ('2106', '2100', '0,2000,2100', '数据字典读取', '/backend/dictionary/read', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 18:33:46', '2021-07-31 18:33:46', null);
INSERT INTO `wp_system_menu` VALUES ('2107', '2100', '0,2000,2100', '数据字典恢复', '/backend/dictionary/recovery', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 18:33:46', '2021-07-31 18:33:46', null);
INSERT INTO `wp_system_menu` VALUES ('2108', '2100', '0,2000,2100', '数据字典销毁', '/backend/dictionary/realDestroy', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2024-04-30 16:30:00', '2023-04-30 16:30:00', null);
INSERT INTO `wp_system_menu` VALUES ('2112', '2100', '0,2000,2100', '字典状态改变', '/backend/dictionary/changeStatus', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-11-09 18:26:15', '2021-11-09 18:26:15', null);
INSERT INTO `wp_system_menu` VALUES ('2200', '2000', '0,2000', '附件管理', '/backend/upload', 'ma-icon-attach', 'upload', 'system/upload/index', null, '2', 'M', '0', null, '1', '98', null, '1', '1', '2021-07-31 18:36:34', '2021-07-31 18:36:34', null);
INSERT INTO `wp_system_menu` VALUES ('2201', '2200', '0,2000,2200', '附件删除', '/backend/upload/destroy', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 18:37:20', '2021-07-31 18:37:20', null);
INSERT INTO `wp_system_menu` VALUES ('2202', '2200', '0,2000,2200', '附件列表', '/backend/upload/index', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 18:38:05', '2021-07-31 18:38:05', null);
INSERT INTO `wp_system_menu` VALUES ('2203', '2200', '0,2000,2200', '附件回收站', '/backend/upload/recycle', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 18:38:57', '2021-07-31 18:38:57', null);
INSERT INTO `wp_system_menu` VALUES ('2204', '2200', '0,2000,2200', '附件恢复', '/backend/upload/recovery', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 18:40:44', '2021-07-31 18:40:44', null);
INSERT INTO `wp_system_menu` VALUES ('2205', '2200', '0,2000,2200', '附件销毁', '/backend/upload/realDestroy', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2024-04-30 16:30:00', '2023-04-30 16:30:00', null);
INSERT INTO `wp_system_menu` VALUES ('2300', '2000', '0,2000', '数据表维护', '/backend/dataMaintain', 'ma-icon-db', 'dataMaintain', 'system/dataMaintain/index', null, '2', 'M', '0', null, '1', '95', null, '1', '1', '2021-07-31 18:43:20', '2021-07-31 18:43:20', null);
INSERT INTO `wp_system_menu` VALUES ('2301', '2300', '0,2000,2300', '数据表列表', '/backend/dataMaintain/index', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 18:44:03', '2021-07-31 18:44:03', null);
INSERT INTO `wp_system_menu` VALUES ('2302', '2300', '0,2000,2300', '数据表详细', '/backend/dataMaintain/detail', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 18:45:17', '2021-07-31 18:45:17', null);
INSERT INTO `wp_system_menu` VALUES ('2303', '2300', '0,2000,2300', '数据表清理碎片', '/backend/dataMaintain/fragment', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 18:46:04', '2021-07-31 18:46:04', null);
INSERT INTO `wp_system_menu` VALUES ('2304', '2300', '0,2000,2300', '数据表优化', '/backend/dataMaintain/optimize', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 18:46:31', '2021-07-31 18:46:31', null);
INSERT INTO `wp_system_menu` VALUES ('2700', '2000', '0,2000', '系统公告', '/backend/notice', 'icon-bulb', 'notice', 'system/notice/index', null, '2', 'M', '0', null, '1', '94', null, '1', '1', '2021-12-25 18:10:20', '2021-12-25 18:10:20', null);
INSERT INTO `wp_system_menu` VALUES ('2701', '2700', '0,2000,2700', '系统公告列表', '/backend/notice/index', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-12-25 18:10:20', '2021-12-25 18:10:20', null);
INSERT INTO `wp_system_menu` VALUES ('2702', '2700', '0,2000,2700', '系统公告回收站', '/backend/notice/recycle', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-12-25 18:10:20', '2021-12-25 18:10:20', null);
INSERT INTO `wp_system_menu` VALUES ('2703', '2700', '0,2000,2700', '系统公告保存', '/backend/notice/save', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-12-25 18:10:20', '2021-12-25 18:10:20', null);
INSERT INTO `wp_system_menu` VALUES ('2704', '2700', '0,2000,2700', '系统公告更新', '/backend/notice/update', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-12-25 18:10:20', '2021-12-25 18:10:20', null);
INSERT INTO `wp_system_menu` VALUES ('2705', '2700', '0,2000,2700', '系统公告删除', '/backend/notice/destroy', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-12-25 18:10:20', '2021-12-25 18:10:20', null);
INSERT INTO `wp_system_menu` VALUES ('2706', '2700', '0,2000,2700', '系统公告读取', '/backend/notice/read', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-12-25 18:10:20', '2021-12-25 18:10:20', null);
INSERT INTO `wp_system_menu` VALUES ('2707', '2700', '0,2000,2700', '系统公告恢复', '/backend/notice/recovery', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-12-25 18:10:20', '2021-12-25 18:10:20', null);
INSERT INTO `wp_system_menu` VALUES ('2708', '2700', '0,2000,2700', '系统公告销毁', '/backend/notice/realDestroy', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2024-04-30 16:30:00', '2023-04-30 16:30:00', null);
INSERT INTO `wp_system_menu` VALUES ('3000', '0', '0', '监控', 'monitor', 'icon-desktop', 'monitor', null, null, '2', 'M', '0', null, '1', '97', null, '1', '1', '2021-07-31 18:49:24', '2021-07-31 18:49:24', null);
INSERT INTO `wp_system_menu` VALUES ('3200', '3000', '0,3000', '服务监控', '/backend/system/monitor', 'icon-thunderbolt', 'server', 'system/monitor/server/index', null, '2', 'M', '0', null, '1', '99', null, '1', '1', '2021-07-31 18:52:46', '2021-07-31 18:52:46', null);
INSERT INTO `wp_system_menu` VALUES ('3300', '3000', '0,3000', '日志监控', 'logs', 'icon-book', 'logs', null, null, '2', 'M', '0', null, '1', '95', null, '1', '1', '2021-07-31 18:54:01', '2021-07-31 18:54:01', null);
INSERT INTO `wp_system_menu` VALUES ('3400', '3300', '0,3000,3200', '登录日志', '/backend/loginLog/index', 'icon-idcard', 'loginLog', 'system/loginLog/index', null, '2', 'M', '0', null, '1', '0', null, '1', '1', '2021-07-31 18:54:55', '2021-07-31 18:54:55', null);
INSERT INTO `wp_system_menu` VALUES ('3401', '3400', '0,3000,3200,3300', '登录日志删除', '/backend/loginLog/destroy', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 18:56:43', '2021-07-31 18:56:43', null);
INSERT INTO `wp_system_menu` VALUES ('3500', '3300', '0,3000,3200', '操作日志', '/backend/operationLog/index', 'icon-robot', 'operationLog', 'system/operationLog/index', null, '2', 'M', '0', null, '1', '0', null, '1', '1', '2021-07-31 18:55:40', '2021-07-31 18:55:40', null);
INSERT INTO `wp_system_menu` VALUES ('3501', '3500', '0,3000,3200,3400', '操作日志删除', '/backend/operationLog/destroy', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 18:56:19', '2021-07-31 18:56:19', null);
INSERT INTO `wp_system_menu` VALUES ('4000', '0', '0', '工具', 'tools', 'ma-icon-tool', 'tools', null, null, '2', 'M', '0', null, '1', '95', null, '1', '1', '2021-07-31 19:03:32', '2021-07-31 19:03:32', null);
INSERT INTO `wp_system_menu` VALUES ('4200', '4000', '0,4000', '代码生成器', '/tool/code', 'ma-icon-code', 'code', 'setting/code/index', null, '2', 'M', '0', null, '1', '98', null, '1', '1', '2021-07-31 19:36:17', '2021-07-31 19:36:17', null);
INSERT INTO `wp_system_menu` VALUES ('4400', '4000', '0,4000', '定时任务', '/backend/crontab', 'icon-schedule', 'crontab', 'setting/crontab/index', null, '2', 'M', '0', null, '1', '0', null, '1', '1', '2021-07-31 19:47:49', '2021-07-31 19:47:49', null);
INSERT INTO `wp_system_menu` VALUES ('4401', '4400', '0,4000,4400', '定时任务列表', '/backend/crontab/index', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 19:47:49', '2021-07-31 19:47:49', null);
INSERT INTO `wp_system_menu` VALUES ('4402', '4400', '0,4000,4400', '定时任务保存', '/backend/crontab/save', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 19:47:49', '2021-07-31 19:47:49', null);
INSERT INTO `wp_system_menu` VALUES ('4403', '4400', '0,4000,4400', '定时任务更新', '/backend/crontab/update', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 19:47:49', '2021-07-31 19:47:49', null);
INSERT INTO `wp_system_menu` VALUES ('4404', '4400', '0,4000,4400', '定时任务删除', '/backend/crontab/destroy', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 19:47:49', '2021-07-31 19:47:49', null);
INSERT INTO `wp_system_menu` VALUES ('4405', '4400', '0,4000,4400', '定时任务读取', '/backend/crontab/read', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-07-31 19:47:49', '2021-07-31 19:47:49', null);
INSERT INTO `wp_system_menu` VALUES ('4408', '4400', '0,4000,4400', '定时任务执行', '/backend/crontab/run', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-08-07 23:44:06', '2021-08-07 23:44:06', null);
INSERT INTO `wp_system_menu` VALUES ('4409', '4400', '0,4000,4400', '定时任务日志删除', '/backend/crontabLog/destroy', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-12-06 22:06:12', '2021-12-06 22:06:12', null);
INSERT INTO `wp_system_menu` VALUES ('4500', '0', '0', '系统设置', '/backend/config', 'icon-settings', 'system', 'setting/config/index', null, '2', 'M', '0', null, '1', '0', null, '1', '1', '2021-07-31 19:58:57', '2023-12-13 14:49:47', null);
INSERT INTO `wp_system_menu` VALUES ('4502', '4500', '0,4500', '配置列表', '/backend/config/index', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-08-10 13:09:18', '2021-08-10 13:09:18', null);
INSERT INTO `wp_system_menu` VALUES ('4504', '4500', '0,4500', '新增配置 ', '/backend/config/save', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-08-10 13:11:56', '2021-08-10 13:11:56', null);
INSERT INTO `wp_system_menu` VALUES ('4505', '4500', '0,4500', '更新配置', '/backend/config/update', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-08-10 13:12:25', '2021-08-10 13:12:25', null);
INSERT INTO `wp_system_menu` VALUES ('4506', '4500', '0,4500', '删除配置', '/backend/config/destroy', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-08-10 13:13:33', '2021-08-10 13:13:33', null);
INSERT INTO `wp_system_menu` VALUES ('4507', '4500', '0,4500', '清除配置缓存', '/backend/config/clearCache', null, null, null, null, '2', 'B', '0', null, '1', '0', null, '1', '1', '2021-08-10 13:13:59', '2021-08-10 13:13:59', null);
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
) ENGINE=InnoDB AUTO_INCREMENT=247 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='操作日志表';

-- ----------------------------
-- Records of wp_system_operation_log
-- ----------------------------
INSERT INTO `wp_system_operation_log` VALUES ('1', '', 'backend', 'POST', '/backend/login/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"uuid\":\"abcd\",\"captcha\":\"abcd\",\"client\":\"WEB\"}', null, null, null, '2024-06-26 18:10:06', '2024-06-26 18:10:06', null);
INSERT INTO `wp_system_operation_log` VALUES ('2', '', 'backend', 'POST', '/backend/login/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"uuid\":\"abcd\",\"captcha\":\"abcd\",\"client\":\"WEB\"}', null, null, null, '2024-06-26 18:10:17', '2024-06-26 18:10:17', null);
INSERT INTO `wp_system_operation_log` VALUES ('3', 'admin', 'backend', 'POST', '/backend/system/test', '未知', '127.0.0.1', '内网IP', '[]', null, null, null, '2024-06-26 21:13:31', '2024-06-26 21:13:31', null);
INSERT INTO `wp_system_operation_log` VALUES ('4', 'admin', 'backend', 'POST', '/backend/system/test', '未知', '127.0.0.1', '内网IP', '[]', null, null, null, '2024-06-27 11:05:42', '2024-06-27 11:05:42', null);
INSERT INTO `wp_system_operation_log` VALUES ('5', '', 'backend', 'POST', '/backend/system/test', '未知', '127.0.0.1', '内网IP', '[]', null, null, null, '2024-06-27 11:06:46', '2024-06-27 11:06:46', null);
INSERT INTO `wp_system_operation_log` VALUES ('6', 'admin', 'backend', 'POST', '/backend/system/test', '未知', '127.0.0.1', '内网IP', '[]', null, null, null, '2024-06-27 11:06:54', '2024-06-27 11:06:54', null);
INSERT INTO `wp_system_operation_log` VALUES ('7', 'admin', 'backend', 'POST', '/backend/system/test', '未知', '127.0.0.1', '内网IP', '[]', null, null, null, '2024-06-27 14:00:12', '2024-06-27 14:00:12', null);
INSERT INTO `wp_system_operation_log` VALUES ('8', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"code\":\"hfxy\",\"uuid\":\"24a59f6a-ebc9-443e-89e8-fb8ea5b66294\"}', null, null, null, '2024-06-29 20:02:22', '2024-06-29 20:02:22', null);
INSERT INTO `wp_system_operation_log` VALUES ('9', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"code\":\"2sfh\",\"uuid\":\"ab0d184a-3afe-4325-b8b1-f95782a2ddc1\"}', null, null, null, '2024-06-29 20:02:38', '2024-06-29 20:02:38', null);
INSERT INTO `wp_system_operation_log` VALUES ('10', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"uuid\":\"abcd\",\"captcha\":\"abcd\",\"client\":\"web\"}', null, null, null, '2024-06-29 20:10:39', '2024-06-29 20:10:39', null);
INSERT INTO `wp_system_operation_log` VALUES ('11', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"captcha\":\"\",\"code\":\"n8vp\",\"uuid\":\"57ff9d0d-2c9a-41e0-bbd4-7b95bcf72f6f\"}', null, null, null, '2024-06-29 20:29:20', '2024-06-29 20:29:20', null);
INSERT INTO `wp_system_operation_log` VALUES ('12', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"captcha\":\"\",\"code\":\"AEVP\",\"uuid\":\"cc040698-f923-447b-825a-41a12c438d63\",\"client\":\"WEB\"}', null, null, null, '2024-06-29 20:31:53', '2024-06-29 20:31:53', null);
INSERT INTO `wp_system_operation_log` VALUES ('13', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"captcha\":\"2N5E\",\"uuid\":\"400a7f14-9fd0-4e1c-9698-59e143c6fa4b\",\"client\":\"WEB\"}', null, null, null, '2024-06-29 20:34:01', '2024-06-29 20:34:01', null);
INSERT INTO `wp_system_operation_log` VALUES ('14', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"captcha\":\"wuyt\",\"uuid\":\"a18c7440-dc11-4197-9054-abe13283fb82\",\"client\":\"WEB\"}', null, null, null, '2024-06-29 20:49:27', '2024-06-29 20:49:27', null);
INSERT INTO `wp_system_operation_log` VALUES ('15', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"captcha\":\"r6wz\",\"uuid\":\"ab2427c4-608f-4459-a910-847c18af6992\",\"client\":\"WEB\"}', null, null, null, '2024-06-29 20:53:52', '2024-06-29 20:53:52', null);
INSERT INTO `wp_system_operation_log` VALUES ('16', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"captcha\":\"8ngt\",\"uuid\":\"b3be1728-7cf4-42c2-917c-96712f799bca\",\"client\":\"WEB\"}', null, null, null, '2024-06-29 20:55:36', '2024-06-29 20:55:36', null);
INSERT INTO `wp_system_operation_log` VALUES ('17', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"captcha\":\"uc36\",\"uuid\":\"7fc2a806-f3c3-411c-b563-6cd9031a2ae9\",\"client\":\"WEB\"}', null, null, null, '2024-06-29 20:58:05', '2024-06-29 20:58:05', null);
INSERT INTO `wp_system_operation_log` VALUES ('18', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"captcha\":\"adwe\",\"uuid\":\"aafa282d-7240-457f-8a03-4c6fb78a170f\",\"client\":\"WEB\"}', null, null, null, '2024-06-29 21:00:17', '2024-06-29 21:00:17', null);
INSERT INTO `wp_system_operation_log` VALUES ('19', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"captcha\":\"57ga\",\"uuid\":\"3af455d2-3bc6-41dc-afdd-98cb43ff40e8\",\"client\":\"WEB\"}', null, null, null, '2024-06-29 21:02:20', '2024-06-29 21:02:20', null);
INSERT INTO `wp_system_operation_log` VALUES ('20', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"captcha\":\"aamm\",\"uuid\":\"137a0756-c828-42f7-a705-e6a1d4e9ac77\",\"client\":\"WEB\"}', null, null, null, '2024-06-29 21:02:29', '2024-06-29 21:02:29', null);
INSERT INTO `wp_system_operation_log` VALUES ('21', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"captcha\":\"a9t5\",\"uuid\":\"63756f25-8a4c-4efc-bcfe-69490cffb3df\",\"client\":\"WEB\"}', null, null, null, '2024-06-29 21:06:55', '2024-06-29 21:06:55', null);
INSERT INTO `wp_system_operation_log` VALUES ('22', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"captcha\":\"xpp8\",\"uuid\":\"611e1c9b-e39b-424d-8623-d7e94695caa5\",\"client\":\"WEB\"}', null, null, null, '2024-06-29 21:09:12', '2024-06-29 21:09:12', null);
INSERT INTO `wp_system_operation_log` VALUES ('23', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"captcha\":\"9c7v\",\"uuid\":\"250d6ab1-cd54-4905-9be1-48914afd7a0f\",\"client\":\"WEB\"}', null, null, null, '2024-06-29 21:12:03', '2024-06-29 21:12:03', null);
INSERT INTO `wp_system_operation_log` VALUES ('24', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"captcha\":\"rcxp\",\"uuid\":\"d938c628-a03c-4fd4-b793-9f9830dc7792\",\"client\":\"WEB\"}', null, null, null, '2024-06-29 21:15:00', '2024-06-29 21:15:00', null);
INSERT INTO `wp_system_operation_log` VALUES ('25', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"captcha\":\"m5dt\",\"uuid\":\"4bdce1e5-ccc6-47cb-b0ee-3a6b3620f8cc\",\"client\":\"WEB\"}', null, null, null, '2024-06-29 21:15:25', '2024-06-29 21:15:25', null);
INSERT INTO `wp_system_operation_log` VALUES ('26', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"captcha\":\"twtb\",\"uuid\":\"7de88d96-bf12-4673-9c88-12c2671bc6fb\",\"client\":\"WEB\"}', null, null, null, '2024-06-29 21:16:24', '2024-06-29 21:16:24', null);
INSERT INTO `wp_system_operation_log` VALUES ('27', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"captcha\":\"4rcn\",\"uuid\":\"27dd637b-ad95-4411-b9f9-74056396eb3b\",\"client\":\"WEB\"}', null, null, null, '2024-06-29 21:16:38', '2024-06-29 21:16:38', null);
INSERT INTO `wp_system_operation_log` VALUES ('28', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"captcha\":\"wxxd\",\"uuid\":\"734e5e9f-28df-41d3-8cc1-a8017f803172\",\"client\":\"WEB\"}', null, null, null, '2024-06-29 21:17:28', '2024-06-29 21:17:28', null);
INSERT INTO `wp_system_operation_log` VALUES ('29', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"captcha\":\"tfpe\",\"uuid\":\"4776b841-dfc5-4c14-9f6d-1c57f16798cc\",\"client\":\"WEB\"}', null, null, null, '2024-06-29 21:17:45', '2024-06-29 21:17:45', null);
INSERT INTO `wp_system_operation_log` VALUES ('30', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"captcha\":\"87ef\",\"uuid\":\"ce850da7-ea15-4e82-93f8-fb6eac0ae89c\",\"client\":\"WEB\"}', null, null, null, '2024-06-29 21:19:42', '2024-06-29 21:19:42', null);
INSERT INTO `wp_system_operation_log` VALUES ('31', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"captcha\":\"swzz\",\"uuid\":\"b6625c79-a6ab-4911-9295-55b83b9b6805\",\"client\":\"WEB\"}', null, null, null, '2024-06-29 21:22:23', '2024-06-29 21:22:23', null);
INSERT INTO `wp_system_operation_log` VALUES ('32', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"captcha\":\"67us\",\"uuid\":\"4d371c8e-2b25-45a4-a737-dc7b4ee9d902\",\"client\":\"WEB\"}', null, null, null, '2024-06-29 21:22:28', '2024-06-29 21:22:28', null);
INSERT INTO `wp_system_operation_log` VALUES ('33', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"captcha\":\"\",\"code\":\"mykt\",\"uuid\":\"0aca8613-7bd7-48a0-a131-2e3ea2163d37\",\"client\":\"WEB\"}', null, null, null, '2024-06-29 21:28:29', '2024-06-29 21:28:29', null);
INSERT INTO `wp_system_operation_log` VALUES ('34', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"captcha\":\"7ayz\",\"code\":\"\",\"uuid\":\"f9bc5346-f52a-45ce-a733-0ae0a2af0717\",\"client\":\"WEB\"}', null, null, null, '2024-06-29 21:29:28', '2024-06-29 21:29:28', null);
INSERT INTO `wp_system_operation_log` VALUES ('35', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"captcha\":\"4axy\",\"uuid\":\"b7e391b6-291c-4668-9246-a380aac82451\",\"client\":\"WEB\"}', null, null, null, '2024-06-29 21:32:44', '2024-06-29 21:32:44', null);
INSERT INTO `wp_system_operation_log` VALUES ('36', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"captcha\":\"xy7p\",\"uuid\":\"31ee4219-5823-4f26-a574-84ad29244ac5\",\"client\":\"WEB\"}', null, null, null, '2024-06-29 21:34:01', '2024-06-29 21:34:01', null);
INSERT INTO `wp_system_operation_log` VALUES ('37', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"captcha\":\"u3ee\",\"uuid\":\"e258977b-b8d9-4a67-ac3c-af895a3e268f\",\"client\":\"WEB\"}', null, null, null, '2024-06-29 21:36:07', '2024-06-29 21:36:07', null);
INSERT INTO `wp_system_operation_log` VALUES ('38', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"captcha\":\"9744\",\"uuid\":\"75cf9dab-500c-4af7-a331-a328b275c021\",\"client\":\"WEB\"}', null, null, null, '2024-06-29 21:36:16', '2024-06-29 21:36:16', null);
INSERT INTO `wp_system_operation_log` VALUES ('39', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"captcha\":\"kcd8\",\"uuid\":\"ce85e7b8-5271-4e47-890e-133f5ed02705\",\"client\":\"WEB\"}', null, null, null, '2024-06-29 21:36:56', '2024-06-29 21:36:56', null);
INSERT INTO `wp_system_operation_log` VALUES ('40', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"captcha\":\"by2y\",\"uuid\":\"fc27f835-9113-47cd-813e-3ce09b799954\",\"client\":\"WEB\"}', null, null, null, '2024-06-29 21:37:25', '2024-06-29 21:37:25', null);
INSERT INTO `wp_system_operation_log` VALUES ('41', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"captcha\":\"3az4\",\"uuid\":\"438dd124-913a-4184-b173-350c477428c8\",\"client\":\"WEB\"}', null, null, null, '2024-06-29 21:38:12', '2024-06-29 21:38:12', null);
INSERT INTO `wp_system_operation_log` VALUES ('42', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"captcha\":\"h8rc\",\"uuid\":\"c120428f-a21d-4292-b202-1cb1690801bd\",\"client\":\"WEB\"}', null, null, null, '2024-06-29 21:38:31', '2024-06-29 21:38:31', null);
INSERT INTO `wp_system_operation_log` VALUES ('43', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"captcha\":\"6xxb\",\"uuid\":\"14c93890-df18-4ccb-a31a-82f1196681bd\",\"client\":\"WEB\"}', null, null, null, '2024-06-29 21:38:49', '2024-06-29 21:38:49', null);
INSERT INTO `wp_system_operation_log` VALUES ('44', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"captcha\":\"ngp9\",\"uuid\":\"2a2f5911-eea1-411a-82c7-e193312bcd86\",\"client\":\"WEB\"}', null, null, null, '2024-06-29 21:39:12', '2024-06-29 21:39:12', null);
INSERT INTO `wp_system_operation_log` VALUES ('45', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"captcha\":\"ngp9\",\"uuid\":\"2a2f5911-eea1-411a-82c7-e193312bcd86\",\"client\":\"WEB\"}', null, null, null, '2024-06-29 21:39:14', '2024-06-29 21:39:14', null);
INSERT INTO `wp_system_operation_log` VALUES ('46', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"captcha\":\"axme\",\"uuid\":\"caeda9a4-5187-43a6-87c5-c7f4c8b2da2d\",\"client\":\"WEB\"}', null, null, null, '2024-06-29 21:40:30', '2024-06-29 21:40:30', null);
INSERT INTO `wp_system_operation_log` VALUES ('47', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"captcha\":\"yxbv\",\"uuid\":\"298291d1-6743-4458-8ebb-0cb89d7d9b2e\",\"client\":\"WEB\"}', null, null, null, '2024-06-29 21:41:07', '2024-06-29 21:41:07', null);
INSERT INTO `wp_system_operation_log` VALUES ('48', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"captcha\":\"ggh7\",\"uuid\":\"f0423932-4d39-42d4-956c-8dfbb5bca9e9\",\"client\":\"WEB\"}', null, null, null, '2024-06-29 21:49:58', '2024-06-29 21:49:58', null);
INSERT INTO `wp_system_operation_log` VALUES ('49', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"code\":\"zgha\",\"uuid\":\"84e2630c-f855-4a00-861a-84b7a1a25671\"}', null, null, null, '2024-07-05 11:09:17', '2024-07-05 11:09:17', null);
INSERT INTO `wp_system_operation_log` VALUES ('50', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"code\":\"acbu\",\"uuid\":\"df9bb4d1-9c18-4287-b497-5a9fbdf0e007\"}', null, null, null, '2024-07-05 11:51:03', '2024-07-05 11:51:03', null);
INSERT INTO `wp_system_operation_log` VALUES ('51', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"21431f261ce852478074a9a724270e65\"}', null, null, null, '2024-07-05 16:25:24', '2024-07-05 16:25:24', null);
INSERT INTO `wp_system_operation_log` VALUES ('52', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 16:28:24', '2024-07-05 16:28:24', null);
INSERT INTO `wp_system_operation_log` VALUES ('53', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 16:34:09', '2024-07-05 16:34:09', null);
INSERT INTO `wp_system_operation_log` VALUES ('54', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 16:35:36', '2024-07-05 16:35:36', null);
INSERT INTO `wp_system_operation_log` VALUES ('55', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 16:37:10', '2024-07-05 16:37:10', null);
INSERT INTO `wp_system_operation_log` VALUES ('56', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 16:38:17', '2024-07-05 16:38:17', null);
INSERT INTO `wp_system_operation_log` VALUES ('57', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 16:39:18', '2024-07-05 16:39:18', null);
INSERT INTO `wp_system_operation_log` VALUES ('58', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 16:44:11', '2024-07-05 16:44:11', null);
INSERT INTO `wp_system_operation_log` VALUES ('59', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 16:44:29', '2024-07-05 16:44:29', null);
INSERT INTO `wp_system_operation_log` VALUES ('60', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 16:48:01', '2024-07-05 16:48:01', null);
INSERT INTO `wp_system_operation_log` VALUES ('61', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 16:50:06', '2024-07-05 16:50:06', null);
INSERT INTO `wp_system_operation_log` VALUES ('62', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 16:51:31', '2024-07-05 16:51:31', null);
INSERT INTO `wp_system_operation_log` VALUES ('63', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 16:52:07', '2024-07-05 16:52:07', null);
INSERT INTO `wp_system_operation_log` VALUES ('64', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 16:53:31', '2024-07-05 16:53:31', null);
INSERT INTO `wp_system_operation_log` VALUES ('65', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 16:55:32', '2024-07-05 16:55:32', null);
INSERT INTO `wp_system_operation_log` VALUES ('66', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"21431f261ce852478074a9a724270e65\"}', null, null, null, '2024-07-05 16:59:40', '2024-07-05 16:59:40', null);
INSERT INTO `wp_system_operation_log` VALUES ('67', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 17:06:07', '2024-07-05 17:06:07', null);
INSERT INTO `wp_system_operation_log` VALUES ('68', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 17:07:37', '2024-07-05 17:07:37', null);
INSERT INTO `wp_system_operation_log` VALUES ('69', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 17:12:28', '2024-07-05 17:12:28', null);
INSERT INTO `wp_system_operation_log` VALUES ('70', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 17:15:32', '2024-07-05 17:15:32', null);
INSERT INTO `wp_system_operation_log` VALUES ('71', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 17:17:49', '2024-07-05 17:17:49', null);
INSERT INTO `wp_system_operation_log` VALUES ('72', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 17:18:39', '2024-07-05 17:18:39', null);
INSERT INTO `wp_system_operation_log` VALUES ('73', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 17:19:07', '2024-07-05 17:19:07', null);
INSERT INTO `wp_system_operation_log` VALUES ('74', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 17:20:03', '2024-07-05 17:20:03', null);
INSERT INTO `wp_system_operation_log` VALUES ('75', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 17:22:39', '2024-07-05 17:22:39', null);
INSERT INTO `wp_system_operation_log` VALUES ('76', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 17:24:52', '2024-07-05 17:24:52', null);
INSERT INTO `wp_system_operation_log` VALUES ('77', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 17:26:09', '2024-07-05 17:26:09', null);
INSERT INTO `wp_system_operation_log` VALUES ('78', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 17:30:18', '2024-07-05 17:30:18', null);
INSERT INTO `wp_system_operation_log` VALUES ('79', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 17:32:16', '2024-07-05 17:32:16', null);
INSERT INTO `wp_system_operation_log` VALUES ('80', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 17:59:19', '2024-07-05 17:59:19', null);
INSERT INTO `wp_system_operation_log` VALUES ('81', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 18:01:20', '2024-07-05 18:01:20', null);
INSERT INTO `wp_system_operation_log` VALUES ('82', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 18:03:58', '2024-07-05 18:03:58', null);
INSERT INTO `wp_system_operation_log` VALUES ('83', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 18:12:40', '2024-07-05 18:12:40', null);
INSERT INTO `wp_system_operation_log` VALUES ('84', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"code\":\"ywds\",\"uuid\":\"20839e75-1b3d-468f-81b2-38fa528c2dee\"}', null, null, null, '2024-07-05 18:20:56', '2024-07-05 18:20:56', null);
INSERT INTO `wp_system_operation_log` VALUES ('85', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 18:21:07', '2024-07-05 18:21:07', null);
INSERT INTO `wp_system_operation_log` VALUES ('86', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"493ca797cef6b64e2c5fe27f83ce39fc\"}', null, null, null, '2024-07-05 18:26:29', '2024-07-05 18:26:29', null);
INSERT INTO `wp_system_operation_log` VALUES ('87', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"493ca797cef6b64e2c5fe27f83ce39fc\"}', null, null, null, '2024-07-05 18:33:45', '2024-07-05 18:33:45', null);
INSERT INTO `wp_system_operation_log` VALUES ('88', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 18:42:55', '2024-07-05 18:42:55', null);
INSERT INTO `wp_system_operation_log` VALUES ('89', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 18:49:59', '2024-07-05 18:49:59', null);
INSERT INTO `wp_system_operation_log` VALUES ('90', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"493ca797cef6b64e2c5fe27f83ce39fc\"}', null, null, null, '2024-07-05 18:57:57', '2024-07-05 18:57:57', null);
INSERT INTO `wp_system_operation_log` VALUES ('91', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"493ca797cef6b64e2c5fe27f83ce39fc\"}', null, null, null, '2024-07-05 19:03:33', '2024-07-05 19:03:33', null);
INSERT INTO `wp_system_operation_log` VALUES ('92', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 19:05:00', '2024-07-05 19:05:00', null);
INSERT INTO `wp_system_operation_log` VALUES ('93', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"8cbfab6878bd113a9e2d118f25dc90d2\"}', null, null, null, '2024-07-05 19:11:11', '2024-07-05 19:11:11', null);
INSERT INTO `wp_system_operation_log` VALUES ('94', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 19:11:19', '2024-07-05 19:11:19', null);
INSERT INTO `wp_system_operation_log` VALUES ('95', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"21431f261ce852478074a9a724270e65\"}', null, null, null, '2024-07-05 19:12:24', '2024-07-05 19:12:24', null);
INSERT INTO `wp_system_operation_log` VALUES ('96', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"code\":\"t3bg\",\"uuid\":\"6eb06e05-d374-4003-9175-33760e117334\"}', null, null, null, '2024-07-05 19:30:52', '2024-07-05 19:30:52', null);
INSERT INTO `wp_system_operation_log` VALUES ('97', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"493ca797cef6b64e2c5fe27f83ce39fc\"}', null, null, null, '2024-07-05 19:30:59', '2024-07-05 19:30:59', null);
INSERT INTO `wp_system_operation_log` VALUES ('98', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 19:31:07', '2024-07-05 19:31:07', null);
INSERT INTO `wp_system_operation_log` VALUES ('99', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"409d94dd4dc9f69fd317cc3919c7eac7\"}', null, null, null, '2024-07-05 19:33:25', '2024-07-05 19:33:25', null);
INSERT INTO `wp_system_operation_log` VALUES ('100', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 20:02:07', '2024-07-05 20:02:07', null);
INSERT INTO `wp_system_operation_log` VALUES ('101', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"493ca797cef6b64e2c5fe27f83ce39fc\"}', null, null, null, '2024-07-05 20:02:16', '2024-07-05 20:02:16', null);
INSERT INTO `wp_system_operation_log` VALUES ('102', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"409d94dd4dc9f69fd317cc3919c7eac7\"}', null, null, null, '2024-07-05 20:04:36', '2024-07-05 20:04:36', null);
INSERT INTO `wp_system_operation_log` VALUES ('103', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"409d94dd4dc9f69fd317cc3919c7eac7\"}', null, null, null, '2024-07-05 20:25:51', '2024-07-05 20:25:51', null);
INSERT INTO `wp_system_operation_log` VALUES ('104', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"493ca797cef6b64e2c5fe27f83ce39fc\"}', null, null, null, '2024-07-05 20:31:53', '2024-07-05 20:31:53', null);
INSERT INTO `wp_system_operation_log` VALUES ('105', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 20:33:08', '2024-07-05 20:33:08', null);
INSERT INTO `wp_system_operation_log` VALUES ('106', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 20:34:53', '2024-07-05 20:34:53', null);
INSERT INTO `wp_system_operation_log` VALUES ('107', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 20:43:48', '2024-07-05 20:43:48', null);
INSERT INTO `wp_system_operation_log` VALUES ('108', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 20:59:59', '2024-07-05 20:59:59', null);
INSERT INTO `wp_system_operation_log` VALUES ('109', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 21:00:19', '2024-07-05 21:00:19', null);
INSERT INTO `wp_system_operation_log` VALUES ('110', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-05 21:13:43', '2024-07-05 21:13:43', null);
INSERT INTO `wp_system_operation_log` VALUES ('111', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"code\":\"9cgy\",\"uuid\":\"ded1a6b6-ef59-47fd-b5fc-e8f8af19a268\"}', null, null, null, '2024-07-06 11:23:22', '2024-07-06 11:23:22', null);
INSERT INTO `wp_system_operation_log` VALUES ('112', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"21431f261ce852478074a9a724270e65\"}', null, null, null, '2024-07-06 11:23:27', '2024-07-06 11:23:27', null);
INSERT INTO `wp_system_operation_log` VALUES ('113', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"21431f261ce852478074a9a724270e65\"}', null, null, null, '2024-07-06 11:23:33', '2024-07-06 11:23:33', null);
INSERT INTO `wp_system_operation_log` VALUES ('114', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-06 11:24:55', '2024-07-06 11:24:55', null);
INSERT INTO `wp_system_operation_log` VALUES ('115', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-06 11:25:54', '2024-07-06 11:25:54', null);
INSERT INTO `wp_system_operation_log` VALUES ('116', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"isChunk\":\"false\",\"hash\":\"21431f261ce852478074a9a724270e65\"}', null, null, null, '2024-07-06 11:25:59', '2024-07-06 11:25:59', null);
INSERT INTO `wp_system_operation_log` VALUES ('117', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"isChunk\":\"false\",\"hash\":\"21431f261ce852478074a9a724270e65\"}', null, null, null, '2024-07-06 11:26:06', '2024-07-06 11:26:06', null);
INSERT INTO `wp_system_operation_log` VALUES ('118', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"isChunk\":\"false\",\"hash\":\"21431f261ce852478074a9a724270e65\"}', null, null, null, '2024-07-06 11:26:45', '2024-07-06 11:26:45', null);
INSERT INTO `wp_system_operation_log` VALUES ('119', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"isChunk\":\"false\",\"hash\":\"21431f261ce852478074a9a724270e65\"}', null, null, null, '2024-07-06 13:11:32', '2024-07-06 13:11:32', null);
INSERT INTO `wp_system_operation_log` VALUES ('120', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"avatar\":\"http:\\/\\/webman.soft\\/storage\\/20240706\\/c5a22be92d325a2b8e0b3d609394dd86d1977fb5.png\"}', null, null, null, '2024-07-06 13:11:33', '2024-07-06 13:11:33', null);
INSERT INTO `wp_system_operation_log` VALUES ('121', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"isChunk\":\"false\",\"hash\":\"21431f261ce852478074a9a724270e65\"}', null, null, null, '2024-07-06 13:11:44', '2024-07-06 13:11:44', null);
INSERT INTO `wp_system_operation_log` VALUES ('122', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"avatar\":\"http:\\/\\/webman.soft\\/storage\\/20240706\\/c5a22be92d325a2b8e0b3d609394dd86d1977fb5.png\"}', null, null, null, '2024-07-06 13:11:44', '2024-07-06 13:11:44', null);
INSERT INTO `wp_system_operation_log` VALUES ('123', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"isChunk\":\"false\",\"hash\":\"21431f261ce852478074a9a724270e65\"}', null, null, null, '2024-07-06 13:15:01', '2024-07-06 13:15:01', null);
INSERT INTO `wp_system_operation_log` VALUES ('124', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"avatar\":\"http:\\/\\/webman.soft\\/storage\\/20240706\\/c5a22be92d325a2b8e0b3d609394dd86d1977fb5.png\"}', null, null, null, '2024-07-06 13:15:01', '2024-07-06 13:15:01', null);
INSERT INTO `wp_system_operation_log` VALUES ('125', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"isChunk\":\"false\",\"hash\":\"409d94dd4dc9f69fd317cc3919c7eac7\"}', null, null, null, '2024-07-06 13:15:18', '2024-07-06 13:15:18', null);
INSERT INTO `wp_system_operation_log` VALUES ('126', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"avatar\":\"http:\\/\\/webman.soft\\/storage\\/20240706\\/11fd185c209af6b8d41a5e3953c31e970736e6d4.jpg\"}', null, null, null, '2024-07-06 13:15:18', '2024-07-06 13:15:18', null);
INSERT INTO `wp_system_operation_log` VALUES ('127', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"isChunk\":\"false\",\"hash\":\"21431f261ce852478074a9a724270e65\"}', null, null, null, '2024-07-06 13:15:25', '2024-07-06 13:15:25', null);
INSERT INTO `wp_system_operation_log` VALUES ('128', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"avatar\":\"http:\\/\\/webman.soft\\/storage\\/20240706\\/c5a22be92d325a2b8e0b3d609394dd86d1977fb5.png\"}', null, null, null, '2024-07-06 13:15:25', '2024-07-06 13:15:25', null);
INSERT INTO `wp_system_operation_log` VALUES ('129', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"isChunk\":\"false\",\"hash\":\"21431f261ce852478074a9a724270e65\"}', null, null, null, '2024-07-06 13:29:47', '2024-07-06 13:29:47', null);
INSERT INTO `wp_system_operation_log` VALUES ('130', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"avatar\":\"http:\\/\\/webman.soft\\/storage\\/20240706\\/c5a22be92d325a2b8e0b3d609394dd86d1977fb5.png\"}', null, null, null, '2024-07-06 13:29:48', '2024-07-06 13:29:48', null);
INSERT INTO `wp_system_operation_log` VALUES ('131', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"id\":1,\"username\":\"admin\",\"user_type\":\"100\",\"nickname\":\"祭道之上\",\"phone\":\"13888888888\",\"email\":\"admin@admin.com\",\"avatar\":\"http:\\/\\/webman.soft\\/storage\\/20240706\\/c5a22be92d325a2b8e0b3d609394dd86d1977fb5.png\",\"signed\":\"Today is very good！\",\"dashboard\":\"statistics\",\"department_id\":null,\"status\":1,\"login_ip\":\"127.0.0.1\",\"login_time\":\"2024-07-06 11:23:22\",\"backend_setting\":\"{\\\"mode\\\":\\\"light\\\",\\\"tag\\\":true,\\\"menuCollapse\\\":false,\\\"menuWidth\\\":230,\\\"layout\\\":\\\"classic\\\",\\\"skin\\\":\\\"mine\\\",\\\"i18n\\\":true,\\\"language\\\":\\\"zh_CN\\\",\\\"animation\\\":\\\"ma-slide-down\\\",\\\"color\\\":\\\"#165DFF\\\"}\",\"remark\":null,\"role_list\":[{\"id\":1,\"name\":\"超级管理员（创始人）\",\"code\":\"superAdmin\",\"data_scope\":1,\"status\":1,\"sort\":100,\"remark\":\"系统内置角色，不可删除\",\"created_by\":1,\"updated_by\":1,\"create_time\":\"2023-10-24 12:00:00\",\"update_time\":\"2023-10-24 12:00:00\",\"pivot\":{\"user_id\":1,\"role_id\":1}}],\"post_list\":[],\"department_list\":[]}', null, null, null, '2024-07-06 13:30:19', '2024-07-06 13:30:19', null);
INSERT INTO `wp_system_operation_log` VALUES ('132', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"id\":1,\"username\":\"admin\",\"user_type\":\"100\",\"nickname\":\"祭道之上\",\"phone\":\"13888888888\",\"email\":\"admin@admin.com\",\"avatar\":\"http:\\/\\/webman.soft\\/storage\\/20240706\\/c5a22be92d325a2b8e0b3d609394dd86d1977fb5.png\",\"signed\":\"Today is very good！\",\"dashboard\":\"statistics\",\"department_id\":null,\"status\":1,\"login_ip\":\"127.0.0.1\",\"login_time\":\"2024-07-06 11:23:22\",\"backend_setting\":\"{\\\"mode\\\":\\\"light\\\",\\\"tag\\\":true,\\\"menuCollapse\\\":false,\\\"menuWidth\\\":230,\\\"layout\\\":\\\"classic\\\",\\\"skin\\\":\\\"mine\\\",\\\"i18n\\\":true,\\\"language\\\":\\\"zh_CN\\\",\\\"animation\\\":\\\"ma-slide-down\\\",\\\"color\\\":\\\"#165DFF\\\"}\",\"remark\":null,\"role_list\":[{\"id\":1,\"name\":\"超级管理员（创始人）\",\"code\":\"superAdmin\",\"data_scope\":1,\"status\":1,\"sort\":100,\"remark\":\"系统内置角色，不可删除\",\"created_by\":1,\"updated_by\":1,\"create_time\":\"2023-10-24 12:00:00\",\"update_time\":\"2023-10-24 12:00:00\",\"pivot\":{\"user_id\":1,\"role_id\":1}}],\"post_list\":[],\"department_list\":[]}', null, null, null, '2024-07-06 13:30:20', '2024-07-06 13:30:20', null);
INSERT INTO `wp_system_operation_log` VALUES ('133', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"id\":1,\"username\":\"admin\",\"user_type\":\"100\",\"nickname\":\"祭道之上\",\"phone\":\"13888888888\",\"email\":\"admin@admin.com\",\"avatar\":\"http:\\/\\/webman.soft\\/storage\\/20240706\\/c5a22be92d325a2b8e0b3d609394dd86d1977fb5.png\",\"signed\":\"Today is very good！\",\"dashboard\":\"statistics\",\"department_id\":null,\"status\":1,\"login_ip\":\"127.0.0.1\",\"login_time\":\"2024-07-06 11:23:22\",\"backend_setting\":\"{\\\"mode\\\":\\\"light\\\",\\\"tag\\\":true,\\\"menuCollapse\\\":false,\\\"menuWidth\\\":230,\\\"layout\\\":\\\"classic\\\",\\\"skin\\\":\\\"mine\\\",\\\"i18n\\\":true,\\\"language\\\":\\\"zh_CN\\\",\\\"animation\\\":\\\"ma-slide-down\\\",\\\"color\\\":\\\"#165DFF\\\"}\",\"remark\":null,\"role_list\":[{\"id\":1,\"name\":\"超级管理员（创始人）\",\"code\":\"superAdmin\",\"data_scope\":1,\"status\":1,\"sort\":100,\"remark\":\"系统内置角色，不可删除\",\"created_by\":1,\"updated_by\":1,\"create_time\":\"2023-10-24 12:00:00\",\"update_time\":\"2023-10-24 12:00:00\",\"pivot\":{\"user_id\":1,\"role_id\":1}}],\"post_list\":[],\"department_list\":[]}', null, null, null, '2024-07-06 13:30:28', '2024-07-06 13:30:28', null);
INSERT INTO `wp_system_operation_log` VALUES ('134', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"id\":1,\"username\":\"admin\",\"user_type\":\"100\",\"nickname\":\"祭道之上\",\"phone\":\"13888888888\",\"email\":\"admin@admin.com\",\"avatar\":\"http:\\/\\/webman.soft\\/storage\\/20240706\\/c5a22be92d325a2b8e0b3d609394dd86d1977fb5.png\",\"signed\":\"Today is very good！\",\"dashboard\":\"statistics\",\"department_id\":null,\"status\":1,\"login_ip\":\"127.0.0.1\",\"login_time\":\"2024-07-06 11:23:22\",\"backend_setting\":\"{\\\"mode\\\":\\\"light\\\",\\\"tag\\\":true,\\\"menuCollapse\\\":false,\\\"menuWidth\\\":230,\\\"layout\\\":\\\"classic\\\",\\\"skin\\\":\\\"mine\\\",\\\"i18n\\\":true,\\\"language\\\":\\\"zh_CN\\\",\\\"animation\\\":\\\"ma-slide-down\\\",\\\"color\\\":\\\"#165DFF\\\"}\",\"remark\":null,\"role_list\":[{\"id\":1,\"name\":\"超级管理员（创始人）\",\"code\":\"superAdmin\",\"data_scope\":1,\"status\":1,\"sort\":100,\"remark\":\"系统内置角色，不可删除\",\"created_by\":1,\"updated_by\":1,\"create_time\":\"2023-10-24 12:00:00\",\"update_time\":\"2023-10-24 12:00:00\",\"pivot\":{\"user_id\":1,\"role_id\":1}}],\"post_list\":[],\"department_list\":[]}', null, null, null, '2024-07-06 13:31:28', '2024-07-06 13:31:28', null);
INSERT INTO `wp_system_operation_log` VALUES ('135', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"id\":1,\"username\":\"admin\",\"user_type\":\"100\",\"nickname\":\"祭道之上\",\"phone\":\"13888888888\",\"email\":\"admin@admin.com\",\"avatar\":\"http:\\/\\/webman.soft\\/storage\\/20240706\\/c5a22be92d325a2b8e0b3d609394dd86d1977fb5.png\",\"signed\":\"Today is very good！\",\"dashboard\":\"statistics\",\"department_id\":null,\"status\":1,\"login_ip\":\"127.0.0.1\",\"login_time\":\"2024-07-06 11:23:22\",\"backend_setting\":\"{\\\"mode\\\":\\\"light\\\",\\\"tag\\\":true,\\\"menuCollapse\\\":false,\\\"menuWidth\\\":230,\\\"layout\\\":\\\"classic\\\",\\\"skin\\\":\\\"mine\\\",\\\"i18n\\\":true,\\\"language\\\":\\\"zh_CN\\\",\\\"animation\\\":\\\"ma-slide-down\\\",\\\"color\\\":\\\"#165DFF\\\"}\",\"remark\":null,\"role_list\":[{\"id\":1,\"name\":\"超级管理员（创始人）\",\"code\":\"superAdmin\",\"data_scope\":1,\"status\":1,\"sort\":100,\"remark\":\"系统内置角色，不可删除\",\"created_by\":1,\"updated_by\":1,\"create_time\":\"2023-10-24 12:00:00\",\"update_time\":\"2023-10-24 12:00:00\",\"pivot\":{\"user_id\":1,\"role_id\":1}}],\"post_list\":[],\"department_list\":[]}', null, null, null, '2024-07-06 13:33:06', '2024-07-06 13:33:06', null);
INSERT INTO `wp_system_operation_log` VALUES ('136', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"id\":1,\"username\":\"admin\",\"user_type\":\"100\",\"nickname\":\"祭道之上\",\"phone\":\"13888888888\",\"email\":\"admin@admin.com\",\"avatar\":\"http:\\/\\/webman.soft\\/storage\\/20240706\\/c5a22be92d325a2b8e0b3d609394dd86d1977fb5.png\",\"signed\":\"Today is very good。\",\"dashboard\":\"statistics\",\"department_id\":null,\"status\":1,\"login_ip\":\"127.0.0.1\",\"login_time\":\"2024-07-06 11:23:22\",\"backend_setting\":\"{\\\"mode\\\":\\\"light\\\",\\\"tag\\\":true,\\\"menuCollapse\\\":false,\\\"menuWidth\\\":230,\\\"layout\\\":\\\"classic\\\",\\\"skin\\\":\\\"mine\\\",\\\"i18n\\\":true,\\\"language\\\":\\\"zh_CN\\\",\\\"animation\\\":\\\"ma-slide-down\\\",\\\"color\\\":\\\"#165DFF\\\"}\",\"remark\":null,\"role_list\":[{\"id\":1,\"name\":\"超级管理员（创始人）\",\"code\":\"superAdmin\",\"data_scope\":1,\"status\":1,\"sort\":100,\"remark\":\"系统内置角色，不可删除\",\"created_by\":1,\"updated_by\":1,\"create_time\":\"2023-10-24 12:00:00\",\"update_time\":\"2023-10-24 12:00:00\",\"pivot\":{\"user_id\":1,\"role_id\":1}}],\"post_list\":[],\"department_list\":[]}', null, null, null, '2024-07-06 13:33:12', '2024-07-06 13:33:12', null);
INSERT INTO `wp_system_operation_log` VALUES ('137', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"id\":1,\"username\":\"admin\",\"user_type\":\"100\",\"nickname\":\"祭道之上\",\"phone\":\"13888888888\",\"email\":\"admin@admin.com\",\"avatar\":\"http:\\/\\/webman.soft\\/storage\\/20240706\\/c5a22be92d325a2b8e0b3d609394dd86d1977fb5.png\",\"signed\":\"Today is very good。\",\"dashboard\":\"statistics\",\"department_id\":null,\"status\":1,\"login_ip\":\"127.0.0.1\",\"login_time\":\"2024-07-06 11:23:22\",\"backend_setting\":\"{\\\"mode\\\":\\\"light\\\",\\\"tag\\\":true,\\\"menuCollapse\\\":false,\\\"menuWidth\\\":230,\\\"layout\\\":\\\"classic\\\",\\\"skin\\\":\\\"mine\\\",\\\"i18n\\\":true,\\\"language\\\":\\\"zh_CN\\\",\\\"animation\\\":\\\"ma-slide-down\\\",\\\"color\\\":\\\"#165DFF\\\"}\",\"remark\":null,\"role_list\":[{\"id\":1,\"name\":\"超级管理员（创始人）\",\"code\":\"superAdmin\",\"data_scope\":1,\"status\":1,\"sort\":100,\"remark\":\"系统内置角色，不可删除\",\"created_by\":1,\"updated_by\":1,\"create_time\":\"2023-10-24 12:00:00\",\"update_time\":\"2023-10-24 12:00:00\",\"pivot\":{\"user_id\":1,\"role_id\":1}}],\"post_list\":[],\"department_list\":[]}', null, null, null, '2024-07-06 13:33:24', '2024-07-06 13:33:24', null);
INSERT INTO `wp_system_operation_log` VALUES ('138', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"id\":1,\"username\":\"admin\",\"user_type\":\"100\",\"nickname\":\"祭道之上\",\"phone\":\"13888888888\",\"email\":\"admin@admin.com\",\"avatar\":\"http:\\/\\/webman.soft\\/storage\\/20240706\\/c5a22be92d325a2b8e0b3d609394dd86d1977fb5.png\",\"signed\":\"Today is very good。\",\"dashboard\":\"statistics\",\"department_id\":null,\"status\":1,\"login_ip\":\"127.0.0.1\",\"login_time\":\"2024-07-06 11:23:22\",\"backend_setting\":\"{\\\"mode\\\":\\\"light\\\",\\\"tag\\\":true,\\\"menuCollapse\\\":false,\\\"menuWidth\\\":230,\\\"layout\\\":\\\"classic\\\",\\\"skin\\\":\\\"mine\\\",\\\"i18n\\\":true,\\\"language\\\":\\\"zh_CN\\\",\\\"animation\\\":\\\"ma-slide-down\\\",\\\"color\\\":\\\"#165DFF\\\"}\",\"remark\":null,\"role_list\":[{\"id\":1,\"name\":\"超级管理员（创始人）\",\"code\":\"superAdmin\",\"data_scope\":1,\"status\":1,\"sort\":100,\"remark\":\"系统内置角色，不可删除\",\"created_by\":1,\"updated_by\":1,\"create_time\":\"2023-10-24 12:00:00\",\"update_time\":\"2023-10-24 12:00:00\",\"pivot\":{\"user_id\":1,\"role_id\":1}}],\"post_list\":[],\"department_list\":[]}', null, null, null, '2024-07-06 13:36:07', '2024-07-06 13:36:07', null);
INSERT INTO `wp_system_operation_log` VALUES ('139', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"id\":1,\"username\":\"admin\",\"user_type\":\"100\",\"nickname\":\"祭道之上\",\"phone\":\"13888888888\",\"email\":\"admin@admin.com\",\"avatar\":\"http:\\/\\/webman.soft\\/storage\\/20240706\\/c5a22be92d325a2b8e0b3d609394dd86d1977fb5.png\",\"signed\":\"Today is very good .\",\"dashboard\":\"statistics\",\"department_id\":null,\"status\":1,\"login_ip\":\"127.0.0.1\",\"login_time\":\"2024-07-06 11:23:22\",\"backend_setting\":\"{\\\"mode\\\":\\\"light\\\",\\\"tag\\\":true,\\\"menuCollapse\\\":false,\\\"menuWidth\\\":230,\\\"layout\\\":\\\"classic\\\",\\\"skin\\\":\\\"mine\\\",\\\"i18n\\\":true,\\\"language\\\":\\\"zh_CN\\\",\\\"animation\\\":\\\"ma-slide-down\\\",\\\"color\\\":\\\"#165DFF\\\"}\",\"remark\":null,\"role_list\":[{\"id\":1,\"name\":\"超级管理员（创始人）\",\"code\":\"superAdmin\",\"data_scope\":1,\"status\":1,\"sort\":100,\"remark\":\"系统内置角色，不可删除\",\"created_by\":1,\"updated_by\":1,\"create_time\":\"2023-10-24 12:00:00\",\"update_time\":\"2023-10-24 12:00:00\",\"pivot\":{\"user_id\":1,\"role_id\":1}}],\"post_list\":[],\"department_list\":[]}', null, null, null, '2024-07-06 13:36:19', '2024-07-06 13:36:19', null);
INSERT INTO `wp_system_operation_log` VALUES ('140', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-06 14:38:02', '2024-07-06 14:38:02', null);
INSERT INTO `wp_system_operation_log` VALUES ('141', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"21431f261ce852478074a9a724270e65\"}', null, null, null, '2024-07-06 14:38:19', '2024-07-06 14:38:19', null);
INSERT INTO `wp_system_operation_log` VALUES ('142', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"isChunk\":\"false\",\"hash\":\"21431f261ce852478074a9a724270e65\"}', null, null, null, '2024-07-06 14:38:57', '2024-07-06 14:38:57', null);
INSERT INTO `wp_system_operation_log` VALUES ('143', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"avatar\":\"http:\\/\\/webman.soft\\/storage\\/20240706\\/c5a22be92d325a2b8e0b3d609394dd86d1977fb5.png\"}', null, null, null, '2024-07-06 14:38:57', '2024-07-06 14:38:57', null);
INSERT INTO `wp_system_operation_log` VALUES ('144', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"isChunk\":\"false\",\"hash\":\"21431f261ce852478074a9a724270e65\"}', null, null, null, '2024-07-06 14:39:05', '2024-07-06 14:39:05', null);
INSERT INTO `wp_system_operation_log` VALUES ('145', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"avatar\":\"http:\\/\\/webman.soft\\/storage\\/20240706\\/c5a22be92d325a2b8e0b3d609394dd86d1977fb5.png\"}', null, null, null, '2024-07-06 14:39:05', '2024-07-06 14:39:05', null);
INSERT INTO `wp_system_operation_log` VALUES ('146', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"id\":1,\"username\":\"admin\",\"user_type\":\"100\",\"nickname\":\"祭道之上\",\"phone\":\"13888888888\",\"email\":\"admin@admin.com\",\"avatar\":\"http:\\/\\/webman.soft\\/storage\\/20240706\\/c5a22be92d325a2b8e0b3d609394dd86d1977fb5.png\",\"signed\":\"Today is very good .\",\"dashboard\":\"statistics\",\"department_id\":null,\"status\":1,\"login_ip\":\"127.0.0.1\",\"login_time\":\"2024-07-06 11:23:22\",\"backend_setting\":\"{\\\"mode\\\":\\\"light\\\",\\\"tag\\\":true,\\\"menuCollapse\\\":false,\\\"menuWidth\\\":230,\\\"layout\\\":\\\"classic\\\",\\\"skin\\\":\\\"mine\\\",\\\"i18n\\\":true,\\\"language\\\":\\\"zh_CN\\\",\\\"animation\\\":\\\"ma-slide-down\\\",\\\"color\\\":\\\"#165DFF\\\"}\",\"remark\":null,\"role_list\":[{\"id\":1,\"name\":\"超级管理员（创始人）\",\"code\":\"superAdmin\",\"data_scope\":1,\"status\":1,\"sort\":100,\"remark\":\"系统内置角色，不可删除\",\"created_by\":1,\"updated_by\":1,\"create_time\":\"2023-10-24 12:00:00\",\"update_time\":\"2023-10-24 12:00:00\",\"pivot\":{\"user_id\":1,\"role_id\":1}}],\"post_list\":[],\"department_list\":[]}', null, null, null, '2024-07-06 14:39:12', '2024-07-06 14:39:12', null);
INSERT INTO `wp_system_operation_log` VALUES ('147', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"id\":1,\"username\":\"admin\",\"user_type\":\"100\",\"nickname\":\"祭道之上\",\"phone\":\"13888888888\",\"email\":\"admin@admin.com\",\"avatar\":\"http:\\/\\/webman.soft\\/storage\\/20240706\\/c5a22be92d325a2b8e0b3d609394dd86d1977fb5.png\",\"signed\":\"Today is very good .\",\"dashboard\":\"statistics\",\"department_id\":null,\"status\":1,\"login_ip\":\"127.0.0.1\",\"login_time\":\"2024-07-06 11:23:22\",\"backend_setting\":\"{\\\"mode\\\":\\\"light\\\",\\\"tag\\\":true,\\\"menuCollapse\\\":false,\\\"menuWidth\\\":230,\\\"layout\\\":\\\"classic\\\",\\\"skin\\\":\\\"mine\\\",\\\"i18n\\\":true,\\\"language\\\":\\\"zh_CN\\\",\\\"animation\\\":\\\"ma-slide-down\\\",\\\"color\\\":\\\"#165DFF\\\"}\",\"remark\":null,\"role_list\":[{\"id\":1,\"name\":\"超级管理员（创始人）\",\"code\":\"superAdmin\",\"data_scope\":1,\"status\":1,\"sort\":100,\"remark\":\"系统内置角色，不可删除\",\"created_by\":1,\"updated_by\":1,\"create_time\":\"2023-10-24 12:00:00\",\"update_time\":\"2023-10-24 12:00:00\",\"pivot\":{\"user_id\":1,\"role_id\":1}}],\"post_list\":[],\"department_list\":[]}', null, null, null, '2024-07-06 14:40:10', '2024-07-06 14:40:10', null);
INSERT INTO `wp_system_operation_log` VALUES ('148', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"isChunk\":\"false\",\"hash\":\"21431f261ce852478074a9a724270e65\"}', null, null, null, '2024-07-06 14:40:15', '2024-07-06 14:40:15', null);
INSERT INTO `wp_system_operation_log` VALUES ('149', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"avatar\":\"http:\\/\\/webman.soft\\/storage\\/20240706\\/c5a22be92d325a2b8e0b3d609394dd86d1977fb5.png\"}', null, null, null, '2024-07-06 14:40:15', '2024-07-06 14:40:15', null);
INSERT INTO `wp_system_operation_log` VALUES ('150', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"code\":\"ffc6\",\"uuid\":\"09663c76-9838-420e-8b1a-0116c93e3914\"}', null, null, null, '2024-07-06 14:42:19', '2024-07-06 14:42:19', null);
INSERT INTO `wp_system_operation_log` VALUES ('151', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"isChunk\":\"false\",\"hash\":\"21431f261ce852478074a9a724270e65\"}', null, null, null, '2024-07-06 14:42:25', '2024-07-06 14:42:25', null);
INSERT INTO `wp_system_operation_log` VALUES ('152', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"avatar\":\"http:\\/\\/webman.soft\\/storage\\/20240706\\/c5a22be92d325a2b8e0b3d609394dd86d1977fb5.png\"}', null, null, null, '2024-07-06 14:42:25', '2024-07-06 14:42:25', null);
INSERT INTO `wp_system_operation_log` VALUES ('153', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"id\":1,\"username\":\"admin\",\"user_type\":\"100\",\"nickname\":\"祭道之上\",\"phone\":\"13888888888\",\"email\":\"admin@admin.com\",\"avatar\":\"http:\\/\\/webman.soft\\/storage\\/20240706\\/c5a22be92d325a2b8e0b3d609394dd86d1977fb5.png\",\"signed\":\"Today is very good .\",\"dashboard\":\"statistics\",\"department_id\":null,\"status\":1,\"login_ip\":\"127.0.0.1\",\"login_time\":\"2024-07-06 14:42:19\",\"backend_setting\":\"{\\\"mode\\\":\\\"light\\\",\\\"tag\\\":true,\\\"menuCollapse\\\":false,\\\"menuWidth\\\":230,\\\"layout\\\":\\\"classic\\\",\\\"skin\\\":\\\"mine\\\",\\\"i18n\\\":true,\\\"language\\\":\\\"zh_CN\\\",\\\"animation\\\":\\\"ma-slide-down\\\",\\\"color\\\":\\\"#165DFF\\\"}\",\"remark\":null,\"role_list\":[{\"id\":1,\"name\":\"超级管理员（创始人）\",\"code\":\"superAdmin\",\"data_scope\":1,\"status\":1,\"sort\":100,\"remark\":\"系统内置角色，不可删除\",\"created_by\":1,\"updated_by\":1,\"create_time\":\"2023-10-24 12:00:00\",\"update_time\":\"2023-10-24 12:00:00\",\"pivot\":{\"user_id\":1,\"role_id\":1}}],\"post_list\":[],\"department_list\":[]}', null, null, null, '2024-07-06 14:42:28', '2024-07-06 14:42:28', null);
INSERT INTO `wp_system_operation_log` VALUES ('154', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-06 14:43:10', '2024-07-06 14:43:10', null);
INSERT INTO `wp_system_operation_log` VALUES ('155', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"avatar\":\"http:\\/\\/webman.soft\\/storage\\/20240706\\/1b62ad717b692edea0df4fe829c5f1d7e2b0daff.png\"}', null, null, null, '2024-07-06 14:43:10', '2024-07-06 14:43:10', null);
INSERT INTO `wp_system_operation_log` VALUES ('156', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"isChunk\":\"false\",\"hash\":\"21431f261ce852478074a9a724270e65\"}', null, null, null, '2024-07-06 14:45:16', '2024-07-06 14:45:16', null);
INSERT INTO `wp_system_operation_log` VALUES ('157', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"avatar\":\"http:\\/\\/127.0.0.1:8787\\/storage\\/20240706\\/c5a22be92d325a2b8e0b3d609394dd86d1977fb5.png\"}', null, null, null, '2024-07-06 14:45:16', '2024-07-06 14:45:16', null);
INSERT INTO `wp_system_operation_log` VALUES ('158', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-06 14:47:16', '2024-07-06 14:47:16', null);
INSERT INTO `wp_system_operation_log` VALUES ('159', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"avatar\":\"http:\\/\\/127.0.0.1:8787\\/storage\\/20240706\\/1b62ad717b692edea0df4fe829c5f1d7e2b0daff.png\"}', null, null, null, '2024-07-06 14:47:16', '2024-07-06 14:47:16', null);
INSERT INTO `wp_system_operation_log` VALUES ('160', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"isChunk\":\"false\",\"hash\":\"21431f261ce852478074a9a724270e65\"}', null, null, null, '2024-07-06 14:47:39', '2024-07-06 14:47:39', null);
INSERT INTO `wp_system_operation_log` VALUES ('161', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"avatar\":\"http:\\/\\/127.0.0.1:8787\\/storage\\/20240706\\/c5a22be92d325a2b8e0b3d609394dd86d1977fb5.png\"}', null, null, null, '2024-07-06 14:47:39', '2024-07-06 14:47:39', null);
INSERT INTO `wp_system_operation_log` VALUES ('162', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"image\":[],\"isChunk\":\"false\",\"hash\":\"466bb61cd7cf4e8b7d9cdf645add1d6e\"}', null, null, null, '2024-07-06 14:48:08', '2024-07-06 14:48:08', null);
INSERT INTO `wp_system_operation_log` VALUES ('163', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-06 15:53:31', '2024-07-06 15:53:31', null);
INSERT INTO `wp_system_operation_log` VALUES ('164', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"avatar\":\"http:\\/\\/127.0.0.1:8787\\/storage\\/20240706\\/1b62ad717b692edea0df4fe829c5f1d7e2b0daff.png\"}', null, null, null, '2024-07-06 15:53:31', '2024-07-06 15:53:31', null);
INSERT INTO `wp_system_operation_log` VALUES ('165', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"id\":1,\"username\":\"admin\",\"user_type\":\"100\",\"nickname\":\"祭道之上\",\"phone\":\"13888888888\",\"email\":\"admin@admin.com\",\"avatar\":\"http:\\/\\/127.0.0.1:8787\\/storage\\/20240706\\/1b62ad717b692edea0df4fe829c5f1d7e2b0daff.png\",\"signed\":\"Today is very good .\",\"dashboard\":\"statistics\",\"department_id\":null,\"status\":1,\"login_ip\":\"127.0.0.1\",\"login_time\":\"2024-07-06 14:42:19\",\"backend_setting\":\"{\\\"mode\\\":\\\"light\\\",\\\"tag\\\":true,\\\"menuCollapse\\\":false,\\\"menuWidth\\\":230,\\\"layout\\\":\\\"classic\\\",\\\"skin\\\":\\\"mine\\\",\\\"i18n\\\":true,\\\"language\\\":\\\"zh_CN\\\",\\\"animation\\\":\\\"ma-slide-down\\\",\\\"color\\\":\\\"#165DFF\\\"}\",\"remark\":null,\"role_list\":[{\"id\":1,\"name\":\"超级管理员（创始人）\",\"code\":\"superAdmin\",\"data_scope\":1,\"status\":1,\"sort\":100,\"remark\":\"系统内置角色，不可删除\",\"created_by\":1,\"updated_by\":1,\"create_time\":\"2023-10-24 12:00:00\",\"update_time\":\"2023-10-24 12:00:00\",\"pivot\":{\"user_id\":1,\"role_id\":1}}],\"post_list\":[],\"department_list\":[]}', null, null, null, '2024-07-06 15:53:40', '2024-07-06 15:53:40', null);
INSERT INTO `wp_system_operation_log` VALUES ('166', 'admin', 'backend', 'POST', '/backend/config/updatebykeys', '未知', '127.0.0.1', '内网IP', '{\"site_name\":\"JiaoshiAdmin\",\"site_keywords\":\"后台管理系统\",\"site_desc\":\"基于vue3 + webman 的极速开发框架\",\"site_copyright\":\"Copyright © 2024 JiaoshiAdmin\",\"site_record_number\":\"\"}', null, null, null, '2024-07-06 16:15:37', '2024-07-06 16:15:37', null);
INSERT INTO `wp_system_operation_log` VALUES ('167', 'admin', 'backend', 'POST', '/backend/config/updatebykeys', '未知', '127.0.0.1', '内网IP', '{\"site_name\":\"JiaoshiAdmin\",\"site_keywords\":\"后台管理系统\",\"site_desc\":\"基于vue3 + webman 的极速开发框架\",\"site_copyright\":\"Copyright © 2024 JiaoshiAdmin\",\"site_record_number\":\"\"}', null, null, null, '2024-07-06 16:18:29', '2024-07-06 16:18:29', null);
INSERT INTO `wp_system_operation_log` VALUES ('168', 'admin', 'backend', 'POST', '/backend/config/updatebykeys', '未知', '127.0.0.1', '内网IP', '{\"site_name\":\"JiaoshiAdmin\",\"site_keywords\":\"后台管理系统\",\"site_desc\":\"基于vue3 + webman 的极速开发框架\",\"site_copyright\":\"Copyright © 2024 JiaoshiAdmin\",\"site_record_number\":\"\"}', null, null, null, '2024-07-06 16:19:57', '2024-07-06 16:19:57', null);
INSERT INTO `wp_system_operation_log` VALUES ('169', 'admin', 'backend', 'POST', '/backend/config/updatebykeys', '未知', '127.0.0.1', '内网IP', '{\"site_name\":\"JiaoshiAdmin\",\"site_keywords\":\"后台管理系统\",\"site_desc\":\"基于vue3 + webman 的极速开发框架\",\"site_copyright\":\"Copyright © 2024 JiaoshiAdmin\",\"site_record_number\":\"\"}', null, null, null, '2024-07-06 16:30:54', '2024-07-06 16:30:54', null);
INSERT INTO `wp_system_operation_log` VALUES ('170', 'admin', 'backend', 'POST', '/backend/config/updatebykeys', '未知', '127.0.0.1', '内网IP', '{\"site_name\":\"JiaoshiAdmin\",\"site_keywords\":\"后台管理系统\",\"site_desc\":\"基于vue3 + webman 的极速开发框架\",\"site_copyright\":\"Copyright © 2024 JiaoshiAdmin\",\"site_record_number\":\"\"}', null, null, null, '2024-07-06 16:32:01', '2024-07-06 16:32:01', null);
INSERT INTO `wp_system_operation_log` VALUES ('171', 'admin', 'backend', 'POST', '/backend/config/updatebykeys', '未知', '127.0.0.1', '内网IP', '{\"site_name\":\"JiaoshiAdmin\",\"site_keywords\":\"后台管理系统\",\"site_desc\":\"基于vue3 + webman 的极速开发框架\",\"site_copyright\":\"Copyright © 2024 JiaoshiAdmin\",\"site_record_number\":\"\"}', null, null, null, '2024-07-06 16:32:55', '2024-07-06 16:32:55', null);
INSERT INTO `wp_system_operation_log` VALUES ('172', 'admin', 'backend', 'POST', '/backend/config/updatebykeys', '未知', '127.0.0.1', '内网IP', '{\"site_name\":\"JiaoshiAdmin\",\"site_keywords\":\"后台管理系统\",\"site_desc\":\"基于vue3 + webman 的极速开发框架\",\"site_copyright\":\"Copyright © 2024 JiaoshiAdmin\",\"site_record_number\":\"\"}', null, null, null, '2024-07-06 16:45:48', '2024-07-06 16:45:48', null);
INSERT INTO `wp_system_operation_log` VALUES ('173', 'admin', 'backend', 'POST', '/backend/config/updatebykeys', '未知', '127.0.0.1', '内网IP', '{\"site_name\":\"JiaoshiAdmin\",\"site_keywords\":\"后台管理系统\",\"site_desc\":\"基于vue3 + webman 的极速开发框架\",\"site_copyright\":\"Copyright © 2024 JiaoshiAdmin\",\"site_record_number\":\"\"}', null, null, null, '2024-07-06 16:46:30', '2024-07-06 16:46:30', null);
INSERT INTO `wp_system_operation_log` VALUES ('174', 'admin', 'backend', 'POST', '/backend/config/updatebykeys', '未知', '127.0.0.1', '内网IP', '{\"site_name\":\"JiaoshiAdmin\",\"site_keywords\":\"后台管理系统\",\"site_desc\":\"基于vue3 + webman 的极速开发框架\",\"site_copyright\":\"Copyright © 2024 JiaoshiAdmin\",\"site_record_number\":\"\"}', null, null, null, '2024-07-06 16:51:19', '2024-07-06 16:51:19', null);
INSERT INTO `wp_system_operation_log` VALUES ('175', 'admin', 'backend', 'POST', '/backend/config/updatebykeys', '未知', '127.0.0.1', '内网IP', '{\"site_name\":\"JiaoshiAdmin\",\"site_keywords\":\"后台管理系统\",\"site_desc\":\"基于vue3 + webman 的极速开发框架\",\"site_copyright\":\"Copyright © 2024 JiaoshiAdmin\",\"site_record_number\":\"\"}', null, null, null, '2024-07-06 16:51:56', '2024-07-06 16:51:56', null);
INSERT INTO `wp_system_operation_log` VALUES ('176', 'admin', 'backend', 'POST', '/backend/config/updatebykeys', '未知', '127.0.0.1', '内网IP', '{\"site_name\":\"JiaoshiAdmin\",\"site_keywords\":\"后台管理系统\",\"site_desc\":\"基于vue3 + webman 的极速开发框架\",\"site_copyright\":\"Copyright © 2024 JiaoshiAdmin\",\"site_record_number\":\"\"}', null, null, null, '2024-07-06 16:52:01', '2024-07-06 16:52:01', null);
INSERT INTO `wp_system_operation_log` VALUES ('177', 'admin', 'backend', 'POST', '/backend/config/updatebykeys', '未知', '127.0.0.1', '内网IP', '{\"site_name\":\"JiaoshiAdmin\",\"site_keywords\":\"后台管理系统\",\"site_desc\":\"基于vue3 + webman 的极速开发框架\",\"site_copyright\":\"Copyright © 2024 JiaoshiAdmin\",\"site_record_number\":\"\"}', null, null, null, '2024-07-06 16:54:45', '2024-07-06 16:54:45', null);
INSERT INTO `wp_system_operation_log` VALUES ('178', 'admin', 'backend', 'POST', '/backend/config/updatebykeys', '未知', '127.0.0.1', '内网IP', '{\"site_name\":\"JiaoshiAdmin\",\"site_keywords\":\"后台管理系统\",\"site_desc\":\"基于vue3 + webman 的极速开发框架\",\"site_copyright\":\"Copyright © 2024 JiaoshiAdmin\",\"site_record_number\":\"\"}', null, null, null, '2024-07-06 16:54:52', '2024-07-06 16:54:52', null);
INSERT INTO `wp_system_operation_log` VALUES ('179', 'admin', 'backend', 'POST', '/backend/config/updatebykeys', '未知', '127.0.0.1', '内网IP', '{\"site_name\":\"JiaoshiAdmin\",\"site_keywords\":\"后台管理系统\",\"site_desc\":\"基于vue3 + webman 的极速开发框架\",\"site_copyright\":\"Copyright © 2024 JiaoshiAdmin\",\"site_record_number\":\"\"}', null, null, null, '2024-07-06 16:59:46', '2024-07-06 16:59:46', null);
INSERT INTO `wp_system_operation_log` VALUES ('180', 'admin', 'backend', 'POST', '/backend/config/updatebykeys', '未知', '127.0.0.1', '内网IP', '{\"site_name\":\"JiaoshiAdmin\",\"site_keywords\":\"后台管理系统\",\"site_desc\":\"基于vue3 + webman 的极速开发框架\",\"site_copyright\":\"Copyright © 2024 JiaoshiAdmin\",\"site_record_number\":\"\"}', null, null, null, '2024-07-06 17:01:09', '2024-07-06 17:01:09', null);
INSERT INTO `wp_system_operation_log` VALUES ('181', 'admin', 'backend', 'POST', '/backend/config/updatebykeys', '未知', '127.0.0.1', '内网IP', '{\"site_name\":\"JiaoshiAdmin\",\"site_keywords\":\"后台管理系统\",\"site_desc\":\"基于vue3 + webman 的极速开发框架\",\"site_copyright\":\"Copyright © 2024 JiaoshiAdmin\",\"site_record_number\":\"\"}', null, null, null, '2024-07-06 17:02:47', '2024-07-06 17:02:47', null);
INSERT INTO `wp_system_operation_log` VALUES ('182', 'admin', 'backend', 'POST', '/backend/config/updatebykeys', '未知', '127.0.0.1', '内网IP', '{\"site_name\":\"JiaoshiAdmin\",\"site_keywords\":\"后台管理系统\",\"site_desc\":\"基于vue3 + webman 的极速开发框架\",\"site_copyright\":\"Copyright © 2024 JiaoshiAdmin\",\"site_record_number\":\"\"}', null, null, null, '2024-07-06 17:03:29', '2024-07-06 17:03:29', null);
INSERT INTO `wp_system_operation_log` VALUES ('183', 'admin', 'backend', 'POST', '/backend/config/updatebykeys', '未知', '127.0.0.1', '内网IP', '{\"site_name\":\"JiaoshiAdmin\",\"site_keywords\":\"后台管理系统\",\"site_desc\":\"基于vue3 + webman 的极速开发框架\",\"site_copyright\":\"Copyright © 2024 JiaoshiAdmin\",\"site_record_number\":\"\"}', null, null, null, '2024-07-06 17:05:23', '2024-07-06 17:05:23', null);
INSERT INTO `wp_system_operation_log` VALUES ('184', 'admin', 'backend', 'POST', '/backend/config/updatebykeys', '未知', '127.0.0.1', '内网IP', '{\"site_name\":\"JiaoshiAdmin\",\"site_keywords\":\"后台管理系统\",\"site_desc\":\"基于vue3 + webman 的极速开发框架\",\"site_copyright\":\"Copyright © 2024 JiaoshiAdmin\",\"site_record_number\":\"\"}', null, null, null, '2024-07-06 17:07:10', '2024-07-06 17:07:10', null);
INSERT INTO `wp_system_operation_log` VALUES ('185', 'admin', 'backend', 'POST', '/backend/config/updatebykeys', '未知', '127.0.0.1', '内网IP', '{\"site_name\":\"JiaoshiAdmin\",\"site_keywords\":\"后台管理系统\",\"site_desc\":\"基于vue3 + webman 的极速开发框架\",\"site_copyright\":\"Copyright © 2024 JiaoshiAdmin\",\"site_record_number\":\"\"}', null, null, null, '2024-07-06 17:07:47', '2024-07-06 17:07:47', null);
INSERT INTO `wp_system_operation_log` VALUES ('186', 'admin', 'backend', 'POST', '/backend/config/updatebykeys', '未知', '127.0.0.1', '内网IP', '{\"site_name\":\"JiaoshiAdmin\",\"site_keywords\":\"后台管理系统\",\"site_desc\":\"基于vue3 + webman 的极速开发框架\",\"site_copyright\":\"Copyright © 2024 JiaoshiAdmin\",\"site_record_number\":\"\"}', null, null, null, '2024-07-06 17:13:04', '2024-07-06 17:13:04', null);
INSERT INTO `wp_system_operation_log` VALUES ('187', 'admin', 'backend', 'POST', '/backend/config/updatebykeys', '未知', '127.0.0.1', '内网IP', '{\"site_name\":\"JiaoshiAdmin\",\"site_keywords\":\"后台管理系统\",\"site_desc\":\"基于vue3 + webman 的极速开发框架\",\"site_copyright\":\"Copyright © 2024 JiaoshiAdmin\",\"site_record_number\":\"\"}', null, null, null, '2024-07-06 17:13:19', '2024-07-06 17:13:19', null);
INSERT INTO `wp_system_operation_log` VALUES ('188', 'admin', 'backend', 'POST', '/backend/config/updatebykeys', '未知', '127.0.0.1', '内网IP', '{\"site_name\":\"JiaoshiAdmin\",\"site_keywords\":\"后台管理系统\",\"site_desc\":\"基于vue3 + webman 的极速开发框架\",\"site_copyright\":\"Copyright © 2024 JiaoshiAdmin\",\"site_record_number\":\"123\"}', null, null, null, '2024-07-06 17:17:24', '2024-07-06 17:17:24', null);
INSERT INTO `wp_system_operation_log` VALUES ('189', 'admin', 'backend', 'POST', '/backend/config/updatebykeys', '未知', '127.0.0.1', '内网IP', '{\"site_name\":\"JiaoshiAdmin\",\"site_keywords\":\"后台管理系统\",\"site_desc\":\"基于vue3 + webman 的极速开发框架\",\"site_copyright\":\"Copyright © 2024 JiaoshiAdmin\",\"site_record_number\":\"\"}', null, null, null, '2024-07-06 17:17:39', '2024-07-06 17:17:39', null);
INSERT INTO `wp_system_operation_log` VALUES ('190', 'admin', 'backend', 'POST', '/backend/config/updatebykeys', '未知', '127.0.0.1', '内网IP', '{\"upload_mode\":\"4\",\"upload_size\":\"5242880\",\"upload_allow_file\":\"txt,doc,docx,xls,xlsx,ppt,pptx,rar,zip,7z,gz,pdf,wps,md\",\"upload_allow_image\":\"jpg,jpeg,png,gif,svg,bmp\",\"local_root\":\"public\\/storage\\/\",\"local_domain\":\"http:\\/\\/127.0.0.1:8787\",\"local_uri\":\"\\/storage\\/\",\"qiniu_accessKey\":\"\",\"qiniu_secretKey\":\"\",\"qiniu_bucket\":\"\",\"qiniu_dirname\":\"\",\"qiniu_domain\":\"\",\"cos_secretId\":\"\",\"cos_secretKey\":\"\",\"cos_bucket\":\"\",\"cos_dirname\":\"\",\"cos_domain\":\"\",\"cos_region\":\"\",\"oss_accessKeyId\":\"\",\"oss_accessKeySecret\":\"\",\"oss_bucket\":\"\",\"oss_dirname\":\"\",\"oss_domain\":\"\",\"oss_endpoint\":\"\"}', null, null, null, '2024-07-06 17:17:46', '2024-07-06 17:17:46', null);
INSERT INTO `wp_system_operation_log` VALUES ('191', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"code\":\"3anp\",\"uuid\":\"dc7509a6-33ea-4e23-b6f3-27712617ce98\"}', null, null, null, '2024-07-06 18:20:23', '2024-07-06 18:20:23', null);
INSERT INTO `wp_system_operation_log` VALUES ('192', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-06 21:03:20', '2024-07-06 21:03:20', null);
INSERT INTO `wp_system_operation_log` VALUES ('193', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"avatar\":\"http:\\/\\/127.0.0.1:8787\\/storage\\/20240706\\/1b62ad717b692edea0df4fe829c5f1d7e2b0daff.png\"}', null, null, null, '2024-07-06 21:03:20', '2024-07-06 21:03:20', null);
INSERT INTO `wp_system_operation_log` VALUES ('194', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"code\":\"ey69\",\"uuid\":\"0a9cc778-5979-4702-92a6-a0505f8e4976\"}', null, null, null, '2024-07-07 08:15:49', '2024-07-07 08:15:49', null);
INSERT INTO `wp_system_operation_log` VALUES ('195', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"isChunk\":\"false\",\"hash\":\"21431f261ce852478074a9a724270e65\"}', null, null, null, '2024-07-07 08:35:17', '2024-07-07 08:35:17', null);
INSERT INTO `wp_system_operation_log` VALUES ('196', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"avatar\":\"http:\\/\\/127.0.0.1:8787\\/storage\\/20240707\\/c5a22be92d325a2b8e0b3d609394dd86d1977fb5.png\"}', null, null, null, '2024-07-07 08:35:17', '2024-07-07 08:35:17', null);
INSERT INTO `wp_system_operation_log` VALUES ('197', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"code\":\"kdw3\",\"uuid\":\"40a81662-3607-4d30-b6a9-ee737b5d8967\"}', null, null, null, '2024-07-07 11:11:30', '2024-07-07 11:11:30', null);
INSERT INTO `wp_system_operation_log` VALUES ('198', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"isChunk\":\"false\",\"hash\":\"21431f261ce852478074a9a724270e65\"}', null, null, null, '2024-07-07 11:11:54', '2024-07-07 11:11:54', null);
INSERT INTO `wp_system_operation_log` VALUES ('199', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"avatar\":\"http:\\/\\/127.0.0.1:8787\\/storage\\/20240707\\/c5a22be92d325a2b8e0b3d609394dd86d1977fb5.png\"}', null, null, null, '2024-07-07 11:11:54', '2024-07-07 11:11:54', null);
INSERT INTO `wp_system_operation_log` VALUES ('200', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"isChunk\":\"false\",\"hash\":\"21431f261ce852478074a9a724270e65\"}', null, null, null, '2024-07-07 11:12:29', '2024-07-07 11:12:29', null);
INSERT INTO `wp_system_operation_log` VALUES ('201', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"avatar\":\"http:\\/\\/127.0.0.1:8787\\/storage\\/20240707\\/c5a22be92d325a2b8e0b3d609394dd86d1977fb5.png\"}', null, null, null, '2024-07-07 11:12:29', '2024-07-07 11:12:29', null);
INSERT INTO `wp_system_operation_log` VALUES ('202', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"isChunk\":\"false\",\"hash\":\"21431f261ce852478074a9a724270e65\"}', null, null, null, '2024-07-07 11:13:53', '2024-07-07 11:13:53', null);
INSERT INTO `wp_system_operation_log` VALUES ('203', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"avatar\":\"http:\\/\\/127.0.0.1:8787\\/storage\\/20240707\\/c5a22be92d325a2b8e0b3d609394dd86d1977fb5.png\"}', null, null, null, '2024-07-07 11:13:53', '2024-07-07 11:13:53', null);
INSERT INTO `wp_system_operation_log` VALUES ('204', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-07 11:14:48', '2024-07-07 11:14:48', null);
INSERT INTO `wp_system_operation_log` VALUES ('205', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"avatar\":\"http:\\/\\/127.0.0.1:8787\\/storage\\/20240707\\/1b62ad717b692edea0df4fe829c5f1d7e2b0daff.png\"}', null, null, null, '2024-07-07 11:14:48', '2024-07-07 11:14:48', null);
INSERT INTO `wp_system_operation_log` VALUES ('206', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"isChunk\":\"false\",\"hash\":\"64359867f8184a6d8eb83fa575931f6a\"}', null, null, null, '2024-07-07 11:16:07', '2024-07-07 11:16:07', null);
INSERT INTO `wp_system_operation_log` VALUES ('207', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"avatar\":\"http:\\/\\/127.0.0.1:8787\\/storage\\/20240707\\/bb1b48ef155a88fb6608942ff18dbabbaf84c889.jpg\"}', null, null, null, '2024-07-07 11:16:07', '2024-07-07 11:16:07', null);
INSERT INTO `wp_system_operation_log` VALUES ('208', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"isChunk\":\"false\",\"hash\":\"64359867f8184a6d8eb83fa575931f6a\"}', null, null, null, '2024-07-07 11:16:54', '2024-07-07 11:16:54', null);
INSERT INTO `wp_system_operation_log` VALUES ('209', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"avatar\":\"http:\\/\\/127.0.0.1:8787\\/storage\\/20240707\\/bb1b48ef155a88fb6608942ff18dbabbaf84c889.jpg\"}', null, null, null, '2024-07-07 11:16:54', '2024-07-07 11:16:54', null);
INSERT INTO `wp_system_operation_log` VALUES ('210', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"isChunk\":\"false\",\"hash\":\"493ca797cef6b64e2c5fe27f83ce39fc\"}', null, null, null, '2024-07-07 11:18:41', '2024-07-07 11:18:41', null);
INSERT INTO `wp_system_operation_log` VALUES ('211', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"avatar\":\"http:\\/\\/127.0.0.1:8787\\/storage\\/20240707\\/98fc9d262014cbed0ea1580e2f3d9da71ad29853.png\"}', null, null, null, '2024-07-07 11:18:41', '2024-07-07 11:18:41', null);
INSERT INTO `wp_system_operation_log` VALUES ('212', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-07 11:19:42', '2024-07-07 11:19:42', null);
INSERT INTO `wp_system_operation_log` VALUES ('213', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"avatar\":\"http:\\/\\/127.0.0.1:8787\\/storage\\/20240707\\/1b62ad717b692edea0df4fe829c5f1d7e2b0daff.png\"}', null, null, null, '2024-07-07 11:19:42', '2024-07-07 11:19:42', null);
INSERT INTO `wp_system_operation_log` VALUES ('214', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-07 14:00:34', '2024-07-07 14:00:34', null);
INSERT INTO `wp_system_operation_log` VALUES ('215', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"avatar\":\"http:\\/\\/127.0.0.1:8787\\/storage\\/20240707\\/1b62ad717b692edea0df4fe829c5f1d7e2b0daff.png\"}', null, null, null, '2024-07-07 14:00:34', '2024-07-07 14:00:34', null);
INSERT INTO `wp_system_operation_log` VALUES ('216', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"isChunk\":\"false\",\"hash\":\"409d94dd4dc9f69fd317cc3919c7eac7\"}', null, null, null, '2024-07-07 14:00:44', '2024-07-07 14:00:44', null);
INSERT INTO `wp_system_operation_log` VALUES ('217', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"avatar\":\"http:\\/\\/127.0.0.1:8787\\/storage\\/20240707\\/11fd185c209af6b8d41a5e3953c31e970736e6d4.jpg\"}', null, null, null, '2024-07-07 14:00:44', '2024-07-07 14:00:44', null);
INSERT INTO `wp_system_operation_log` VALUES ('218', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"id\":1,\"username\":\"admin\",\"user_type\":\"100\",\"nickname\":\"祭道之上\",\"phone\":\"13888888888\",\"email\":\"admin@admin.com\",\"avatar\":\"\",\"signed\":\"Today is very good ..\",\"dashboard\":\"statistics\",\"department_id\":null,\"status\":1,\"login_ip\":\"127.0.0.1\",\"login_time\":\"2024-07-07 11:11:30\",\"backend_setting\":\"{\\\"mode\\\":\\\"light\\\",\\\"tag\\\":true,\\\"menuCollapse\\\":false,\\\"menuWidth\\\":230,\\\"layout\\\":\\\"classic\\\",\\\"skin\\\":\\\"mine\\\",\\\"i18n\\\":true,\\\"language\\\":\\\"zh_CN\\\",\\\"animation\\\":\\\"ma-slide-down\\\",\\\"color\\\":\\\"#165DFF\\\"}\",\"remark\":null,\"role_list\":[{\"id\":1,\"name\":\"超级管理员（创始人）\",\"code\":\"superAdmin\",\"data_scope\":1,\"status\":1,\"sort\":100,\"remark\":\"系统内置角色，不可删除\",\"created_by\":1,\"updated_by\":1,\"create_time\":\"2023-10-24 12:00:00\",\"update_time\":\"2023-10-24 12:00:00\",\"pivot\":{\"user_id\":1,\"role_id\":1}}],\"post_list\":[],\"department_list\":[]}', null, null, null, '2024-07-07 14:02:58', '2024-07-07 14:02:58', null);
INSERT INTO `wp_system_operation_log` VALUES ('219', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"id\":1,\"username\":\"admin\",\"user_type\":\"100\",\"nickname\":\"祭道之上\",\"phone\":\"13888888888\",\"email\":\"admin@admin.com\",\"avatar\":\"\",\"signed\":\"Today is very good .\",\"dashboard\":\"statistics\",\"department_id\":null,\"status\":1,\"login_ip\":\"127.0.0.1\",\"login_time\":\"2024-07-07 11:11:30\",\"backend_setting\":\"{\\\"mode\\\":\\\"light\\\",\\\"tag\\\":true,\\\"menuCollapse\\\":false,\\\"menuWidth\\\":230,\\\"layout\\\":\\\"classic\\\",\\\"skin\\\":\\\"mine\\\",\\\"i18n\\\":true,\\\"language\\\":\\\"zh_CN\\\",\\\"animation\\\":\\\"ma-slide-down\\\",\\\"color\\\":\\\"#165DFF\\\"}\",\"remark\":null,\"role_list\":[{\"id\":1,\"name\":\"超级管理员（创始人）\",\"code\":\"superAdmin\",\"data_scope\":1,\"status\":1,\"sort\":100,\"remark\":\"系统内置角色，不可删除\",\"created_by\":1,\"updated_by\":1,\"create_time\":\"2023-10-24 12:00:00\",\"update_time\":\"2023-10-24 12:00:00\",\"pivot\":{\"user_id\":1,\"role_id\":1}}],\"post_list\":[],\"department_list\":[]}', null, null, null, '2024-07-07 14:03:10', '2024-07-07 14:03:10', null);
INSERT INTO `wp_system_operation_log` VALUES ('220', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"id\":1,\"username\":\"admin\",\"user_type\":\"100\",\"nickname\":\"祭道之上\",\"phone\":\"13888888888\",\"email\":\"admin@admin.com\",\"avatar\":\"\",\"signed\":\"个人签名\",\"dashboard\":\"statistics\",\"department_id\":null,\"status\":1,\"login_ip\":\"127.0.0.1\",\"login_time\":\"2024-07-07 11:11:30\",\"backend_setting\":\"{\\\"mode\\\":\\\"light\\\",\\\"tag\\\":true,\\\"menuCollapse\\\":false,\\\"menuWidth\\\":230,\\\"layout\\\":\\\"classic\\\",\\\"skin\\\":\\\"mine\\\",\\\"i18n\\\":true,\\\"language\\\":\\\"zh_CN\\\",\\\"animation\\\":\\\"ma-slide-down\\\",\\\"color\\\":\\\"#165DFF\\\"}\",\"remark\":null,\"role_list\":[{\"id\":1,\"name\":\"超级管理员（创始人）\",\"code\":\"superAdmin\",\"data_scope\":1,\"status\":1,\"sort\":100,\"remark\":\"系统内置角色，不可删除\",\"created_by\":1,\"updated_by\":1,\"create_time\":\"2023-10-24 12:00:00\",\"update_time\":\"2023-10-24 12:00:00\",\"pivot\":{\"user_id\":1,\"role_id\":1}}],\"post_list\":[],\"department_list\":[]}', null, null, null, '2024-07-07 14:03:29', '2024-07-07 14:03:29', null);
INSERT INTO `wp_system_operation_log` VALUES ('221', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"id\":1,\"username\":\"admin\",\"user_type\":\"100\",\"nickname\":\"祭道之上\",\"phone\":\"13888888888\",\"email\":\"admin@admin.com\",\"avatar\":\"\",\"signed\":\"个人签名\",\"dashboard\":\"statistics\",\"department_id\":null,\"status\":1,\"login_ip\":\"127.0.0.1\",\"login_time\":\"2024-07-07 11:11:30\",\"backend_setting\":\"{\\\"mode\\\":\\\"light\\\",\\\"tag\\\":true,\\\"menuCollapse\\\":false,\\\"menuWidth\\\":230,\\\"layout\\\":\\\"classic\\\",\\\"skin\\\":\\\"mine\\\",\\\"i18n\\\":true,\\\"language\\\":\\\"zh_CN\\\",\\\"animation\\\":\\\"ma-slide-down\\\",\\\"color\\\":\\\"#165DFF\\\"}\",\"remark\":null,\"role_list\":[{\"id\":1,\"name\":\"超级管理员（创始人）\",\"code\":\"superAdmin\",\"data_scope\":1,\"status\":1,\"sort\":100,\"remark\":\"系统内置角色，不可删除\",\"created_by\":1,\"updated_by\":1,\"create_time\":\"2023-10-24 12:00:00\",\"update_time\":\"2023-10-24 12:00:00\",\"pivot\":{\"user_id\":1,\"role_id\":1}}],\"post_list\":[],\"department_list\":[]}', null, null, null, '2024-07-07 14:16:15', '2024-07-07 14:16:15', null);
INSERT INTO `wp_system_operation_log` VALUES ('222', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"id\":1,\"username\":\"admin\",\"user_type\":\"100\",\"nickname\":\"祭道之上\",\"phone\":\"13888888888\",\"email\":\"admin@admin.com\",\"avatar\":\"\",\"signed\":\"Today is very good .\",\"dashboard\":\"statistics\",\"department_id\":null,\"status\":1,\"login_ip\":\"127.0.0.1\",\"login_time\":\"2024-07-07 11:11:30\",\"backend_setting\":\"{\\\"mode\\\":\\\"light\\\",\\\"tag\\\":true,\\\"menuCollapse\\\":false,\\\"menuWidth\\\":230,\\\"layout\\\":\\\"classic\\\",\\\"skin\\\":\\\"mine\\\",\\\"i18n\\\":true,\\\"language\\\":\\\"zh_CN\\\",\\\"animation\\\":\\\"ma-slide-down\\\",\\\"color\\\":\\\"#165DFF\\\"}\",\"remark\":null,\"role_list\":[{\"id\":1,\"name\":\"超级管理员（创始人）\",\"code\":\"superAdmin\",\"data_scope\":1,\"status\":1,\"sort\":100,\"remark\":\"系统内置角色，不可删除\",\"created_by\":1,\"updated_by\":1,\"create_time\":\"2023-10-24 12:00:00\",\"update_time\":\"2023-10-24 12:00:00\",\"pivot\":{\"user_id\":1,\"role_id\":1}}],\"post_list\":[],\"department_list\":[]}', null, null, null, '2024-07-07 14:17:13', '2024-07-07 14:17:13', null);
INSERT INTO `wp_system_operation_log` VALUES ('223', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"id\":1,\"username\":\"admin\",\"user_type\":\"100\",\"nickname\":\"祭道之上\",\"phone\":\"13888888888\",\"email\":\"admin@admin.com\",\"avatar\":\"\",\"signed\":\"Today is very good .rrrrrrrrrrrrrr\",\"dashboard\":\"statistics\",\"department_id\":null,\"status\":1,\"login_ip\":\"127.0.0.1\",\"login_time\":\"2024-07-07 11:11:30\",\"backend_setting\":\"{\\\"mode\\\":\\\"light\\\",\\\"tag\\\":true,\\\"menuCollapse\\\":false,\\\"menuWidth\\\":230,\\\"layout\\\":\\\"classic\\\",\\\"skin\\\":\\\"mine\\\",\\\"i18n\\\":true,\\\"language\\\":\\\"zh_CN\\\",\\\"animation\\\":\\\"ma-slide-down\\\",\\\"color\\\":\\\"#165DFF\\\"}\",\"remark\":null,\"role_list\":[{\"id\":1,\"name\":\"超级管理员（创始人）\",\"code\":\"superAdmin\",\"data_scope\":1,\"status\":1,\"sort\":100,\"remark\":\"系统内置角色，不可删除\",\"created_by\":1,\"updated_by\":1,\"create_time\":\"2023-10-24 12:00:00\",\"update_time\":\"2023-10-24 12:00:00\",\"pivot\":{\"user_id\":1,\"role_id\":1}}],\"post_list\":[],\"department_list\":[]}', null, null, null, '2024-07-07 14:17:30', '2024-07-07 14:17:30', null);
INSERT INTO `wp_system_operation_log` VALUES ('224', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"id\":1,\"username\":\"admin\",\"user_type\":\"100\",\"nickname\":\"祭道之上\",\"phone\":\"13888888888\",\"email\":\"admin@admin.com\",\"avatar\":\"\",\"signed\":\"Today is very good .eeeeeeeeeeeeeee\",\"dashboard\":\"statistics\",\"department_id\":null,\"status\":1,\"login_ip\":\"127.0.0.1\",\"login_time\":\"2024-07-07 11:11:30\",\"backend_setting\":\"{\\\"mode\\\":\\\"light\\\",\\\"tag\\\":true,\\\"menuCollapse\\\":false,\\\"menuWidth\\\":230,\\\"layout\\\":\\\"classic\\\",\\\"skin\\\":\\\"mine\\\",\\\"i18n\\\":true,\\\"language\\\":\\\"zh_CN\\\",\\\"animation\\\":\\\"ma-slide-down\\\",\\\"color\\\":\\\"#165DFF\\\"}\",\"remark\":null,\"role_list\":[{\"id\":1,\"name\":\"超级管理员（创始人）\",\"code\":\"superAdmin\",\"data_scope\":1,\"status\":1,\"sort\":100,\"remark\":\"系统内置角色，不可删除\",\"created_by\":1,\"updated_by\":1,\"create_time\":\"2023-10-24 12:00:00\",\"update_time\":\"2023-10-24 12:00:00\",\"pivot\":{\"user_id\":1,\"role_id\":1}}],\"post_list\":[],\"department_list\":[]}', null, null, null, '2024-07-07 14:21:10', '2024-07-07 14:21:10', null);
INSERT INTO `wp_system_operation_log` VALUES ('225', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-07 14:21:30', '2024-07-07 14:21:30', null);
INSERT INTO `wp_system_operation_log` VALUES ('226', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"avatar\":\"http:\\/\\/127.0.0.1:8787\\/storage\\/20240707\\/1b62ad717b692edea0df4fe829c5f1d7e2b0daff.png\"}', null, null, null, '2024-07-07 14:21:30', '2024-07-07 14:21:30', null);
INSERT INTO `wp_system_operation_log` VALUES ('227', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"id\":1,\"username\":\"admin\",\"user_type\":\"100\",\"nickname\":\"祭道之上\",\"phone\":\"13888888888\",\"email\":\"admin@admin.com\",\"avatar\":\"http:\\/\\/127.0.0.1:8787\\/storage\\/20240707\\/1b62ad717b692edea0df4fe829c5f1d7e2b0daff.png\",\"signed\":\"Today is very good .eeeeeeeeeeeeeee\",\"dashboard\":\"statistics\",\"department_id\":null,\"status\":1,\"login_ip\":\"127.0.0.1\",\"login_time\":\"2024-07-07 11:11:30\",\"backend_setting\":\"{\\\"mode\\\":\\\"light\\\",\\\"tag\\\":true,\\\"menuCollapse\\\":false,\\\"menuWidth\\\":230,\\\"layout\\\":\\\"classic\\\",\\\"skin\\\":\\\"mine\\\",\\\"i18n\\\":true,\\\"language\\\":\\\"zh_CN\\\",\\\"animation\\\":\\\"ma-slide-down\\\",\\\"color\\\":\\\"#165DFF\\\"}\",\"remark\":null,\"role_list\":[{\"id\":1,\"name\":\"超级管理员（创始人）\",\"code\":\"superAdmin\",\"data_scope\":1,\"status\":1,\"sort\":100,\"remark\":\"系统内置角色，不可删除\",\"created_by\":1,\"updated_by\":1,\"create_time\":\"2023-10-24 12:00:00\",\"update_time\":\"2023-10-24 12:00:00\",\"pivot\":{\"user_id\":1,\"role_id\":1}}],\"post_list\":[],\"department_list\":[]}', null, null, null, '2024-07-07 14:21:36', '2024-07-07 14:21:36', null);
INSERT INTO `wp_system_operation_log` VALUES ('228', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"id\":1,\"username\":\"admin\",\"user_type\":\"100\",\"nickname\":\"祭道之上\",\"phone\":\"13888888888\",\"email\":\"admin@admin.com\",\"avatar\":\"http:\\/\\/127.0.0.1:8787\\/storage\\/20240707\\/1b62ad717b692edea0df4fe829c5f1d7e2b0daff.png\",\"signed\":\"Today is very good .eeeeeeeeeeeeeee\",\"dashboard\":\"statistics\",\"department_id\":null,\"status\":1,\"login_ip\":\"127.0.0.1\",\"login_time\":\"2024-07-07 11:11:30\",\"backend_setting\":\"{\\\"mode\\\":\\\"light\\\",\\\"tag\\\":true,\\\"menuCollapse\\\":false,\\\"menuWidth\\\":230,\\\"layout\\\":\\\"classic\\\",\\\"skin\\\":\\\"mine\\\",\\\"i18n\\\":true,\\\"language\\\":\\\"zh_CN\\\",\\\"animation\\\":\\\"ma-slide-down\\\",\\\"color\\\":\\\"#165DFF\\\"}\",\"remark\":null,\"role_list\":[{\"id\":1,\"name\":\"超级管理员（创始人）\",\"code\":\"superAdmin\",\"data_scope\":1,\"status\":1,\"sort\":100,\"remark\":\"系统内置角色，不可删除\",\"created_by\":1,\"updated_by\":1,\"create_time\":\"2023-10-24 12:00:00\",\"update_time\":\"2023-10-24 12:00:00\",\"pivot\":{\"user_id\":1,\"role_id\":1}}],\"post_list\":[],\"department_list\":[]}', null, null, null, '2024-07-07 14:29:57', '2024-07-07 14:29:57', null);
INSERT INTO `wp_system_operation_log` VALUES ('229', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"id\":1,\"username\":\"admin\",\"user_type\":\"100\",\"nickname\":\"祭道之上\",\"phone\":\"13888888888\",\"email\":\"admin@admin.com\",\"avatar\":\"http:\\/\\/127.0.0.1:8787\\/storage\\/20240707\\/1b62ad717b692edea0df4fe829c5f1d7e2b0daff.png\",\"signed\":\"Today is very good .eeeeeeeeeeeeeee\",\"dashboard\":\"statistics\",\"department_id\":null,\"status\":1,\"login_ip\":\"127.0.0.1\",\"login_time\":\"2024-07-07 11:11:30\",\"backend_setting\":\"{\\\"mode\\\":\\\"light\\\",\\\"tag\\\":true,\\\"menuCollapse\\\":false,\\\"menuWidth\\\":230,\\\"layout\\\":\\\"classic\\\",\\\"skin\\\":\\\"mine\\\",\\\"i18n\\\":true,\\\"language\\\":\\\"zh_CN\\\",\\\"animation\\\":\\\"ma-slide-down\\\",\\\"color\\\":\\\"#165DFF\\\"}\",\"remark\":null,\"role_list\":[{\"id\":1,\"name\":\"超级管理员（创始人）\",\"code\":\"superAdmin\",\"data_scope\":1,\"status\":1,\"sort\":100,\"remark\":\"系统内置角色，不可删除\",\"created_by\":1,\"updated_by\":1,\"create_time\":\"2023-10-24 12:00:00\",\"update_time\":\"2023-10-24 12:00:00\",\"pivot\":{\"user_id\":1,\"role_id\":1}}],\"post_list\":[],\"department_list\":[]}', null, null, null, '2024-07-07 14:30:44', '2024-07-07 14:30:44', null);
INSERT INTO `wp_system_operation_log` VALUES ('230', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"id\":1,\"username\":\"admin\",\"user_type\":\"100\",\"nickname\":\"祭道之上\",\"phone\":\"13888888888\",\"email\":\"admin@admin.com\",\"avatar\":\"\",\"signed\":\"Today is very good .44444444444\",\"dashboard\":\"statistics\",\"department_id\":null,\"status\":1,\"login_ip\":\"127.0.0.1\",\"login_time\":\"2024-07-07 11:11:30\",\"backend_setting\":\"{\\\"mode\\\":\\\"light\\\",\\\"tag\\\":true,\\\"menuCollapse\\\":false,\\\"menuWidth\\\":230,\\\"layout\\\":\\\"classic\\\",\\\"skin\\\":\\\"mine\\\",\\\"i18n\\\":true,\\\"language\\\":\\\"zh_CN\\\",\\\"animation\\\":\\\"ma-slide-down\\\",\\\"color\\\":\\\"#165DFF\\\"}\",\"remark\":null,\"role_list\":[{\"id\":1,\"name\":\"超级管理员（创始人）\",\"code\":\"superAdmin\",\"data_scope\":1,\"status\":1,\"sort\":100,\"remark\":\"系统内置角色，不可删除\",\"created_by\":1,\"updated_by\":1,\"create_time\":\"2023-10-24 12:00:00\",\"update_time\":\"2023-10-24 12:00:00\",\"pivot\":{\"user_id\":1,\"role_id\":1}}],\"post_list\":[],\"department_list\":[]}', null, null, null, '2024-07-07 14:31:32', '2024-07-07 14:31:32', null);
INSERT INTO `wp_system_operation_log` VALUES ('231', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"id\":1,\"username\":\"admin\",\"user_type\":\"100\",\"nickname\":\"祭道之上\",\"phone\":\"13888888888\",\"email\":\"admin@admin.com\",\"avatar\":\"\",\"signed\":\"Today is very good .55555\",\"dashboard\":\"statistics\",\"department_id\":null,\"status\":1,\"login_ip\":\"127.0.0.1\",\"login_time\":\"2024-07-07 11:11:30\",\"backend_setting\":\"{\\\"mode\\\":\\\"light\\\",\\\"tag\\\":true,\\\"menuCollapse\\\":false,\\\"menuWidth\\\":230,\\\"layout\\\":\\\"classic\\\",\\\"skin\\\":\\\"mine\\\",\\\"i18n\\\":true,\\\"language\\\":\\\"zh_CN\\\",\\\"animation\\\":\\\"ma-slide-down\\\",\\\"color\\\":\\\"#165DFF\\\"}\",\"remark\":null,\"role_list\":[{\"id\":1,\"name\":\"超级管理员（创始人）\",\"code\":\"superAdmin\",\"data_scope\":1,\"status\":1,\"sort\":100,\"remark\":\"系统内置角色，不可删除\",\"created_by\":1,\"updated_by\":1,\"create_time\":\"2023-10-24 12:00:00\",\"update_time\":\"2023-10-24 12:00:00\",\"pivot\":{\"user_id\":1,\"role_id\":1}}],\"post_list\":[],\"department_list\":[]}', null, null, null, '2024-07-07 14:32:12', '2024-07-07 14:32:12', null);
INSERT INTO `wp_system_operation_log` VALUES ('232', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"id\":1,\"username\":\"admin\",\"user_type\":\"100\",\"nickname\":\"祭道之上\",\"phone\":\"13888888888\",\"email\":\"admin@admin.com\",\"avatar\":\"\",\"signed\":\"Today is very good .9999\",\"dashboard\":\"statistics\",\"department_id\":null,\"status\":1,\"login_ip\":\"127.0.0.1\",\"login_time\":\"2024-07-07 11:11:30\",\"backend_setting\":\"{\\\"mode\\\":\\\"light\\\",\\\"tag\\\":true,\\\"menuCollapse\\\":false,\\\"menuWidth\\\":230,\\\"layout\\\":\\\"classic\\\",\\\"skin\\\":\\\"mine\\\",\\\"i18n\\\":true,\\\"language\\\":\\\"zh_CN\\\",\\\"animation\\\":\\\"ma-slide-down\\\",\\\"color\\\":\\\"#165DFF\\\"}\",\"remark\":null,\"role_list\":[{\"id\":1,\"name\":\"超级管理员（创始人）\",\"code\":\"superAdmin\",\"data_scope\":1,\"status\":1,\"sort\":100,\"remark\":\"系统内置角色，不可删除\",\"created_by\":1,\"updated_by\":1,\"create_time\":\"2023-10-24 12:00:00\",\"update_time\":\"2023-10-24 12:00:00\",\"pivot\":{\"user_id\":1,\"role_id\":1}}],\"post_list\":[],\"department_list\":[]}', null, null, null, '2024-07-07 14:32:40', '2024-07-07 14:32:40', null);
INSERT INTO `wp_system_operation_log` VALUES ('233', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"id\":1,\"username\":\"admin\",\"user_type\":\"100\",\"nickname\":\"祭道之上\",\"phone\":\"13888888888\",\"email\":\"admin@admin.com\",\"avatar\":\"\",\"signed\":\"Today is very good .345\",\"dashboard\":\"statistics\",\"department_id\":null,\"status\":1,\"login_ip\":\"127.0.0.1\",\"login_time\":\"2024-07-07 11:11:30\",\"backend_setting\":\"{\\\"mode\\\":\\\"light\\\",\\\"tag\\\":true,\\\"menuCollapse\\\":false,\\\"menuWidth\\\":230,\\\"layout\\\":\\\"classic\\\",\\\"skin\\\":\\\"mine\\\",\\\"i18n\\\":true,\\\"language\\\":\\\"zh_CN\\\",\\\"animation\\\":\\\"ma-slide-down\\\",\\\"color\\\":\\\"#165DFF\\\"}\",\"remark\":null,\"role_list\":[{\"id\":1,\"name\":\"超级管理员（创始人）\",\"code\":\"superAdmin\",\"data_scope\":1,\"status\":1,\"sort\":100,\"remark\":\"系统内置角色，不可删除\",\"created_by\":1,\"updated_by\":1,\"create_time\":\"2023-10-24 12:00:00\",\"update_time\":\"2023-10-24 12:00:00\",\"pivot\":{\"user_id\":1,\"role_id\":1}}],\"post_list\":[],\"department_list\":[]}', null, null, null, '2024-07-07 14:34:45', '2024-07-07 14:34:45', null);
INSERT INTO `wp_system_operation_log` VALUES ('234', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"id\":1,\"username\":\"admin\",\"user_type\":\"100\",\"nickname\":\"祭道之上\",\"phone\":\"13888888888\",\"email\":\"admin@admin.com\",\"avatar\":\"\",\"signed\":\"Today is very good .44444\",\"dashboard\":\"statistics\",\"department_id\":null,\"status\":1,\"login_ip\":\"127.0.0.1\",\"login_time\":\"2024-07-07 11:11:30\",\"backend_setting\":\"{\\\"mode\\\":\\\"light\\\",\\\"tag\\\":true,\\\"menuCollapse\\\":false,\\\"menuWidth\\\":230,\\\"layout\\\":\\\"classic\\\",\\\"skin\\\":\\\"mine\\\",\\\"i18n\\\":true,\\\"language\\\":\\\"zh_CN\\\",\\\"animation\\\":\\\"ma-slide-down\\\",\\\"color\\\":\\\"#165DFF\\\"}\",\"remark\":null,\"role_list\":[{\"id\":1,\"name\":\"超级管理员（创始人）\",\"code\":\"superAdmin\",\"data_scope\":1,\"status\":1,\"sort\":100,\"remark\":\"系统内置角色，不可删除\",\"created_by\":1,\"updated_by\":1,\"create_time\":\"2023-10-24 12:00:00\",\"update_time\":\"2023-10-24 12:00:00\",\"pivot\":{\"user_id\":1,\"role_id\":1}}],\"post_list\":[],\"department_list\":[]}', null, null, null, '2024-07-07 14:40:43', '2024-07-07 14:40:43', null);
INSERT INTO `wp_system_operation_log` VALUES ('235', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"id\":1,\"username\":\"admin\",\"user_type\":\"100\",\"nickname\":\"祭道之上\",\"phone\":\"13888888888\",\"email\":\"admin@admin.com\",\"avatar\":\"\",\"signed\":\"Today is very good .44444\",\"dashboard\":\"statistics\",\"department_id\":null,\"status\":1,\"login_ip\":\"127.0.0.1\",\"login_time\":\"2024-07-07 11:11:30\",\"backend_setting\":\"{\\\"mode\\\":\\\"light\\\",\\\"tag\\\":true,\\\"menuCollapse\\\":false,\\\"menuWidth\\\":230,\\\"layout\\\":\\\"classic\\\",\\\"skin\\\":\\\"mine\\\",\\\"i18n\\\":true,\\\"language\\\":\\\"zh_CN\\\",\\\"animation\\\":\\\"ma-slide-down\\\",\\\"color\\\":\\\"#165DFF\\\"}\",\"remark\":null,\"role_list\":[{\"id\":1,\"name\":\"超级管理员（创始人）\",\"code\":\"superAdmin\",\"data_scope\":1,\"status\":1,\"sort\":100,\"remark\":\"系统内置角色，不可删除\",\"created_by\":1,\"updated_by\":1,\"create_time\":\"2023-10-24 12:00:00\",\"update_time\":\"2023-10-24 12:00:00\",\"pivot\":{\"user_id\":1,\"role_id\":1}}],\"post_list\":[],\"department_list\":[]}', null, null, null, '2024-07-07 14:41:40', '2024-07-07 14:41:40', null);
INSERT INTO `wp_system_operation_log` VALUES ('236', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"id\":1,\"username\":\"admin\",\"user_type\":\"100\",\"nickname\":\"祭道之上\",\"phone\":\"13888888888\",\"email\":\"admin@admin.com\",\"avatar\":\"\",\"signed\":\"Today is very good .44444\",\"dashboard\":\"statistics\",\"department_id\":null,\"status\":1,\"login_ip\":\"127.0.0.1\",\"login_time\":\"2024-07-07 11:11:30\",\"backend_setting\":\"{\\\"mode\\\":\\\"light\\\",\\\"tag\\\":true,\\\"menuCollapse\\\":false,\\\"menuWidth\\\":230,\\\"layout\\\":\\\"classic\\\",\\\"skin\\\":\\\"mine\\\",\\\"i18n\\\":true,\\\"language\\\":\\\"zh_CN\\\",\\\"animation\\\":\\\"ma-slide-down\\\",\\\"color\\\":\\\"#165DFF\\\"}\",\"remark\":null,\"role_list\":[{\"id\":1,\"name\":\"超级管理员（创始人）\",\"code\":\"superAdmin\",\"data_scope\":1,\"status\":1,\"sort\":100,\"remark\":\"系统内置角色，不可删除\",\"created_by\":1,\"updated_by\":1,\"create_time\":\"2023-10-24 12:00:00\",\"update_time\":\"2023-10-24 12:00:00\",\"pivot\":{\"user_id\":1,\"role_id\":1}}],\"post_list\":[],\"department_list\":[]}', null, null, null, '2024-07-07 14:44:27', '2024-07-07 14:44:27', null);
INSERT INTO `wp_system_operation_log` VALUES ('237', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"id\":1,\"username\":\"admin\",\"user_type\":\"100\",\"nickname\":\"祭道之上\",\"phone\":\"13888888888\",\"email\":\"admin@admin.com\",\"avatar\":\"\",\"signed\":\"Today is very good .44444\",\"dashboard\":\"statistics\",\"department_id\":null,\"status\":1,\"login_ip\":\"127.0.0.1\",\"login_time\":\"2024-07-07 11:11:30\",\"backend_setting\":\"{\\\"mode\\\":\\\"light\\\",\\\"tag\\\":true,\\\"menuCollapse\\\":false,\\\"menuWidth\\\":230,\\\"layout\\\":\\\"classic\\\",\\\"skin\\\":\\\"mine\\\",\\\"i18n\\\":true,\\\"language\\\":\\\"zh_CN\\\",\\\"animation\\\":\\\"ma-slide-down\\\",\\\"color\\\":\\\"#165DFF\\\"}\",\"remark\":null,\"role_list\":[{\"id\":1,\"name\":\"超级管理员（创始人）\",\"code\":\"superAdmin\",\"data_scope\":1,\"status\":1,\"sort\":100,\"remark\":\"系统内置角色，不可删除\",\"created_by\":1,\"updated_by\":1,\"create_time\":\"2023-10-24 12:00:00\",\"update_time\":\"2023-10-24 12:00:00\",\"pivot\":{\"user_id\":1,\"role_id\":1}}],\"post_list\":[],\"department_list\":[]}', null, null, null, '2024-07-07 14:45:50', '2024-07-07 14:45:50', null);
INSERT INTO `wp_system_operation_log` VALUES ('238', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-07 14:47:17', '2024-07-07 14:47:17', null);
INSERT INTO `wp_system_operation_log` VALUES ('239', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"avatar\":\"http:\\/\\/127.0.0.1:8787\\/storage\\/20240707\\/1b62ad717b692edea0df4fe829c5f1d7e2b0daff.png\"}', null, null, null, '2024-07-07 14:47:17', '2024-07-07 14:47:17', null);
INSERT INTO `wp_system_operation_log` VALUES ('240', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"id\":1,\"username\":\"admin\",\"user_type\":\"100\",\"nickname\":\"祭道之上\",\"phone\":\"13888888888\",\"email\":\"admin@admin.com\",\"avatar\":\"http:\\/\\/127.0.0.1:8787\\/storage\\/20240707\\/1b62ad717b692edea0df4fe829c5f1d7e2b0daff.png\",\"signed\":\"Today is very good .\",\"dashboard\":\"statistics\",\"department_id\":null,\"status\":1,\"login_ip\":\"127.0.0.1\",\"login_time\":\"2024-07-07 11:11:30\",\"backend_setting\":\"{\\\"mode\\\":\\\"light\\\",\\\"tag\\\":true,\\\"menuCollapse\\\":false,\\\"menuWidth\\\":230,\\\"layout\\\":\\\"classic\\\",\\\"skin\\\":\\\"mine\\\",\\\"i18n\\\":true,\\\"language\\\":\\\"zh_CN\\\",\\\"animation\\\":\\\"ma-slide-down\\\",\\\"color\\\":\\\"#165DFF\\\"}\",\"remark\":null,\"role_list\":[{\"id\":1,\"name\":\"超级管理员（创始人）\",\"code\":\"superAdmin\",\"data_scope\":1,\"status\":1,\"sort\":100,\"remark\":\"系统内置角色，不可删除\",\"created_by\":1,\"updated_by\":1,\"create_time\":\"2023-10-24 12:00:00\",\"update_time\":\"2023-10-24 12:00:00\",\"pivot\":{\"user_id\":1,\"role_id\":1}}],\"post_list\":[],\"department_list\":[]}', null, null, null, '2024-07-07 14:47:22', '2024-07-07 14:47:22', null);
INSERT INTO `wp_system_operation_log` VALUES ('241', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"isChunk\":\"false\",\"hash\":\"0ab02f80efc4b85df188987de546bc44\"}', null, null, null, '2024-07-07 15:29:53', '2024-07-07 15:29:53', null);
INSERT INTO `wp_system_operation_log` VALUES ('242', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"avatar\":\"http:\\/\\/127.0.0.1:8787\\/storage\\/20240707\\/1b62ad717b692edea0df4fe829c5f1d7e2b0daff.png\"}', null, null, null, '2024-07-07 15:29:53', '2024-07-07 15:29:53', null);
INSERT INTO `wp_system_operation_log` VALUES ('243', '', 'backend', 'POST', '/backend/login', '未知', '127.0.0.1', '内网IP', '{\"username\":\"admin\",\"password\":\"******\",\"code\":\"xwsv\",\"uuid\":\"73f5291f-e40c-4b77-a804-4ead531ad75d\"}', null, null, null, '2024-07-07 17:32:30', '2024-07-07 17:32:30', null);
INSERT INTO `wp_system_operation_log` VALUES ('244', 'admin', 'backend', 'POST', '/backend/upload/uploadimage', '未知', '127.0.0.1', '内网IP', '{\"isChunk\":\"false\",\"hash\":\"21431f261ce852478074a9a724270e65\"}', null, null, null, '2024-07-07 17:32:41', '2024-07-07 17:32:41', null);
INSERT INTO `wp_system_operation_log` VALUES ('245', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"avatar\":\"http:\\/\\/127.0.0.1:8787\\/storage\\/20240707\\/c5a22be92d325a2b8e0b3d609394dd86d1977fb5.png\"}', null, null, null, '2024-07-07 17:32:41', '2024-07-07 17:32:41', null);
INSERT INTO `wp_system_operation_log` VALUES ('246', 'admin', 'backend', 'POST', '/backend/admin/updateinfo', '未知', '127.0.0.1', '内网IP', '{\"id\":1,\"username\":\"admin\",\"user_type\":\"100\",\"nickname\":\"JiaoshiAdmin\",\"phone\":\"13888888888\",\"email\":\"admin@admin.com\",\"avatar\":\"http:\\/\\/127.0.0.1:8787\\/storage\\/20240707\\/c5a22be92d325a2b8e0b3d609394dd86d1977fb5.png\",\"signed\":\"Today is very good .\",\"dashboard\":\"statistics\",\"department_id\":null,\"status\":1,\"login_ip\":\"127.0.0.1\",\"login_time\":\"2024-07-07 17:32:31\",\"backend_setting\":\"{\\\"mode\\\":\\\"light\\\",\\\"tag\\\":true,\\\"menuCollapse\\\":false,\\\"menuWidth\\\":230,\\\"layout\\\":\\\"classic\\\",\\\"skin\\\":\\\"mine\\\",\\\"i18n\\\":true,\\\"language\\\":\\\"zh_CN\\\",\\\"animation\\\":\\\"ma-slide-down\\\",\\\"color\\\":\\\"#165DFF\\\"}\",\"remark\":null,\"role_list\":[{\"id\":1,\"name\":\"超级管理员（创始人）\",\"code\":\"superAdmin\",\"data_scope\":1,\"status\":1,\"sort\":100,\"remark\":\"系统内置角色，不可删除\",\"created_by\":1,\"updated_by\":1,\"create_time\":\"2023-10-24 12:00:00\",\"update_time\":\"2023-10-24 12:00:00\",\"pivot\":{\"user_id\":1,\"role_id\":1}}],\"post_list\":[],\"department_list\":[]}', null, null, null, '2024-07-07 17:32:53', '2024-07-07 17:32:53', null);

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
INSERT INTO `wp_system_role_department` VALUES ('3', '3');

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
INSERT INTO `wp_system_role_menu` VALUES ('2', '1000');
INSERT INTO `wp_system_role_menu` VALUES ('2', '1100');
INSERT INTO `wp_system_role_menu` VALUES ('3', '1103');

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
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='上传文件信息表';

-- ----------------------------
-- Records of wp_system_upload
-- ----------------------------
INSERT INTO `wp_system_upload` VALUES ('1', '1', 'test1', null, null, 'image', null, null, null, null, null, null, null, null, '2024-06-27 21:10:17', '2024-06-27 21:10:17', null);
INSERT INTO `wp_system_upload` VALUES ('2', '1', 'test2', null, null, 'zip', null, null, null, null, null, null, null, null, '2024-06-27 21:10:17', '2024-06-27 21:10:17', null);
INSERT INTO `wp_system_upload` VALUES ('3', '1', 'test3', null, null, 'zip', null, null, null, null, null, null, null, null, '2024-06-27 21:10:17', '2024-06-27 21:10:17', null);
INSERT INTO `wp_system_upload` VALUES ('4', '1', null, null, null, null, null, null, null, null, null, null, null, null, '2024-07-06 11:25:54', '2024-07-06 11:25:54', null);
INSERT INTO `wp_system_upload` VALUES ('5', '1', null, null, null, null, null, null, null, null, null, null, null, null, '2024-07-06 11:25:59', '2024-07-06 11:25:59', null);
INSERT INTO `wp_system_upload` VALUES ('6', '1', null, null, null, null, null, null, null, null, null, null, null, null, '2024-07-06 11:26:06', '2024-07-06 11:26:06', null);
INSERT INTO `wp_system_upload` VALUES ('7', '1', null, null, null, null, null, null, null, null, null, null, null, null, '2024-07-06 11:26:45', '2024-07-06 11:26:45', null);
INSERT INTO `wp_system_upload` VALUES ('8', '1', null, null, null, null, null, null, null, null, null, null, null, null, '2024-07-06 13:11:33', '2024-07-06 13:11:33', null);
INSERT INTO `wp_system_upload` VALUES ('9', '1', null, null, null, null, null, null, null, null, null, null, null, null, '2024-07-06 13:11:44', '2024-07-06 13:11:44', null);
INSERT INTO `wp_system_upload` VALUES ('10', '1', null, null, null, null, null, null, null, null, null, null, null, null, '2024-07-06 13:15:01', '2024-07-06 13:15:01', null);
INSERT INTO `wp_system_upload` VALUES ('11', '1', null, null, null, null, null, null, null, null, null, null, null, null, '2024-07-06 13:15:18', '2024-07-06 13:15:18', null);
INSERT INTO `wp_system_upload` VALUES ('12', '1', null, null, null, null, null, null, null, null, null, null, null, null, '2024-07-06 13:15:25', '2024-07-06 13:15:25', null);
INSERT INTO `wp_system_upload` VALUES ('13', '1', null, null, null, null, null, null, null, null, null, null, null, null, '2024-07-06 13:29:48', '2024-07-06 13:29:48', null);
INSERT INTO `wp_system_upload` VALUES ('14', '1', null, null, null, null, null, null, null, null, null, null, null, null, '2024-07-06 14:38:57', '2024-07-06 14:38:57', null);
INSERT INTO `wp_system_upload` VALUES ('15', '1', null, null, null, null, null, null, null, null, null, null, null, null, '2024-07-06 14:39:05', '2024-07-06 14:39:05', null);
INSERT INTO `wp_system_upload` VALUES ('16', '1', null, null, null, null, null, null, null, null, null, null, null, null, '2024-07-06 14:40:15', '2024-07-06 14:40:15', null);
INSERT INTO `wp_system_upload` VALUES ('17', '1', null, null, null, null, null, null, null, null, null, null, null, null, '2024-07-06 14:42:25', '2024-07-06 14:42:25', null);
INSERT INTO `wp_system_upload` VALUES ('18', '1', null, null, null, null, null, null, null, null, null, null, null, null, '2024-07-06 14:43:10', '2024-07-06 14:43:10', null);
INSERT INTO `wp_system_upload` VALUES ('19', '1', null, null, null, null, null, null, null, null, null, null, null, null, '2024-07-06 14:45:16', '2024-07-06 14:45:16', null);
INSERT INTO `wp_system_upload` VALUES ('20', '1', null, null, null, null, null, null, null, null, null, null, null, null, '2024-07-06 14:47:16', '2024-07-06 14:47:16', null);
INSERT INTO `wp_system_upload` VALUES ('21', '1', null, null, null, null, null, null, null, null, null, null, null, null, '2024-07-06 14:47:39', '2024-07-06 14:47:39', null);
INSERT INTO `wp_system_upload` VALUES ('22', '1', null, null, null, null, null, null, null, null, null, null, null, null, '2024-07-06 15:53:31', '2024-07-06 15:53:31', null);
INSERT INTO `wp_system_upload` VALUES ('23', '1', null, null, null, null, null, null, null, null, null, null, null, null, '2024-07-06 21:03:20', '2024-07-06 21:03:20', null);
INSERT INTO `wp_system_upload` VALUES ('24', '1', null, null, null, null, null, null, null, null, null, null, null, null, '2024-07-07 08:35:17', '2024-07-07 08:35:17', null);
INSERT INTO `wp_system_upload` VALUES ('25', '1', null, null, null, null, null, null, null, null, null, null, null, null, '2024-07-07 11:11:54', '2024-07-07 11:11:54', null);
INSERT INTO `wp_system_upload` VALUES ('26', '1', null, null, null, null, null, null, null, null, null, null, null, null, '2024-07-07 11:12:29', '2024-07-07 11:12:29', null);
INSERT INTO `wp_system_upload` VALUES ('27', '1', null, null, null, null, null, null, null, null, null, null, null, null, '2024-07-07 11:13:53', '2024-07-07 11:13:53', null);
INSERT INTO `wp_system_upload` VALUES ('28', '1', null, null, null, null, null, null, null, null, null, null, null, null, '2024-07-07 11:14:48', '2024-07-07 11:14:48', null);
INSERT INTO `wp_system_upload` VALUES ('29', '1', null, null, null, null, null, null, null, null, null, null, null, null, '2024-07-07 11:16:07', '2024-07-07 11:16:07', null);
INSERT INTO `wp_system_upload` VALUES ('30', '1', null, null, null, null, null, null, null, null, null, null, null, null, '2024-07-07 11:16:54', '2024-07-07 11:16:54', null);
INSERT INTO `wp_system_upload` VALUES ('31', '1', null, null, null, null, null, null, null, null, null, null, null, null, '2024-07-07 11:18:41', '2024-07-07 11:18:41', null);
INSERT INTO `wp_system_upload` VALUES ('32', '1', null, null, null, null, null, null, null, null, null, null, null, null, '2024-07-07 11:19:42', '2024-07-07 11:19:42', null);
INSERT INTO `wp_system_upload` VALUES ('33', '1', null, null, null, null, null, null, null, null, null, null, null, null, '2024-07-07 14:00:34', '2024-07-07 14:00:34', null);
INSERT INTO `wp_system_upload` VALUES ('34', '1', null, null, null, null, null, null, null, null, null, null, null, null, '2024-07-07 14:00:44', '2024-07-07 14:00:44', null);
INSERT INTO `wp_system_upload` VALUES ('35', '1', null, null, null, null, null, null, null, null, null, null, null, null, '2024-07-07 14:21:30', '2024-07-07 14:21:30', null);
INSERT INTO `wp_system_upload` VALUES ('36', '1', null, null, null, null, null, null, null, null, null, null, null, null, '2024-07-07 14:47:17', '2024-07-07 14:47:17', null);
INSERT INTO `wp_system_upload` VALUES ('37', '1', null, null, null, null, null, null, null, null, null, null, null, null, '2024-07-07 15:29:53', '2024-07-07 15:29:53', null);
INSERT INTO `wp_system_upload` VALUES ('38', '1', null, null, null, null, null, null, null, null, null, null, null, null, '2024-07-07 17:32:41', '2024-07-07 17:32:41', null);

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
  `department_id` int(11) DEFAULT NULL COMMENT '部门ID',
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
  KEY `idx_dept_id` (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户信息表';

-- ----------------------------
-- Records of wp_system_user
-- ----------------------------
INSERT INTO `wp_system_user` VALUES ('1', 'admin', '$2y$10$Q70WC9RBqMSS72DmppsbIuQtyAydXSmeD.Ae6W8YhmE/w15uLLpiy', '100', 'JiaoshiAdmin', '13888888888', 'admin@admin.com', 'http://127.0.0.1:8787/storage/20240707/c5a22be92d325a2b8e0b3d609394dd86d1977fb5.png', 'Today is very good .', 'statistics', null, '1', '127.0.0.1', '2024-07-07 17:32:31', '{\"mode\":\"light\",\"tag\":true,\"menuCollapse\":false,\"menuWidth\":230,\"layout\":\"classic\",\"skin\":\"mine\",\"i18n\":true,\"language\":\"zh_CN\",\"animation\":\"ma-slide-down\",\"color\":\"#165DFF\"}', null, '1', '1', '2024-01-20 16:02:23', '2024-07-07 17:32:53', null);
INSERT INTO `wp_system_user` VALUES ('2', 'test1', '$2y$10$Q70WC9RBqMSS72DmppsbIuQtyAydXSmeD.Ae6W8YhmE/w15uLLpiy', '100', '小小测试员', '15822222222', 'test@saadmin.com', null, null, 'work', '5', '1', '127.0.0.1', '2024-06-27 14:52:58', 'null', null, '1', '1', '2023-11-15 14:30:14', '2024-06-27 14:52:58', null);
INSERT INTO `wp_system_user` VALUES ('3', 'test2', '', '100', '酱油党', '13977777777', 'zhang@saadmin.com', null, null, 'statistics', '2', '1', '127.0.0.1', '2023-11-22 22:47:26', 'null', '5566', '1', '1', '2023-11-15 16:27:27', '2024-06-23 16:32:39', null);

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
INSERT INTO `wp_system_user_post` VALUES ('2', '2');
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
INSERT INTO `wp_system_user_role` VALUES ('2', '3');

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
