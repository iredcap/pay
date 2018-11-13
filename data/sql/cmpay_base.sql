/*
Navicat MySQL Data Transfer

Source Server         : 本地数据库
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : caomao

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2018-10-29 22:38:08
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for cm_action_log
-- ----------------------------
DROP TABLE IF EXISTS `cm_action_log`;
CREATE TABLE `cm_action_log` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uid` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '执行会员id',
  `module` varchar(30) NOT NULL DEFAULT 'admin' COMMENT '模块',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT '行为',
  `describe` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '执行的URL',
  `ip` char(30) NOT NULL DEFAULT '' COMMENT '执行行为者ip',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态',
  `update_time` int(10) unsigned unsigned NOT NULL DEFAULT '0',
  `create_time` int(10) unsigned unsigned NOT NULL DEFAULT '0' COMMENT '执行行为的时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='行为日志表';


-- ----------------------------
-- Table structure for cm_article
-- ----------------------------
DROP TABLE IF EXISTS `cm_article`;
CREATE TABLE `cm_article` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文章ID',
  `author` char(20) NOT NULL DEFAULT 'admin' COMMENT '作者',
  `title` char(40) NOT NULL DEFAULT '' COMMENT '文章名称',
  `describe` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `content` text NOT NULL COMMENT '文章内容',
  `cover_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '封面图片id',
  `file_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件id',
  `img_ids` varchar(200) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '数据状态',
  `create_time` int(10) unsigned unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `article_index` (`id`,`title`,`status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='文章表';

-- ----------------------------
-- Table structure for cm_api
-- ----------------------------
DROP TABLE IF EXISTS `cm_api`;
CREATE TABLE `cm_api` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `uid` mediumint(8) DEFAULT NULL COMMENT '商户id',
  `key` varchar(32) DEFAULT NULL COMMENT 'API验证KEY',
  `sitename` varchar(30) NOT NULL,
  `domain` varchar(100) NOT NULL COMMENT '商户验证域名',
  `daily` decimal(11,2) NOT NULL DEFAULT '20000.00' COMMENT '日限访问（超过就锁）',
  `secretkey` text NOT NULL COMMENT '商户请求RSA私钥',
  `role` int(4) NOT NULL COMMENT '角色1-普通商户,角色2-特约商户',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '商户API状态,0-禁用,1-锁,2-正常',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `api_domain_unique` (`id`,`domain`,`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商户信息表';


-- ----------------------------
-- Table structure for cm_admin
-- ----------------------------
DROP TABLE IF EXISTS `cm_admin`;
CREATE TABLE `cm_admin` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `leader_id` mediumint(8) NOT NULL DEFAULT '1',
  `username` varchar(20) DEFAULT '0',
  `nickname` varchar(40) DEFAULT NULL,
  `password` varchar(32) DEFAULT NULL,
  `phone` varchar(11) DEFAULT NULL,
  `email` varchar(80) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='管理员信息';

-- ----------------------------
-- Records of cm_admin
-- ----------------------------
INSERT INTO `cm_admin` VALUES ('1', '0', 'admin', '超级管理员', '5c4a6053ebbcaef6785df30a0bd10343', '18078687485', 'admin@iredcap.cn', '1', '1538393200', '1540815750');
INSERT INTO `cm_admin` VALUES ('2', '1', 'nouser', '管理员', 'd31f4b567830340af5ec399e4e4da8d6', '18888889999', 'nouser@iredcap.cn', '1', '1540372659', '1540815699');
-- ----------------------------
-- Table structure for cm_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `cm_auth_group`;
CREATE TABLE `cm_auth_group` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户组id,自增主键',
  `uid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `module` varchar(20) NOT NULL DEFAULT '' COMMENT '用户组所属模块',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '用户组名称',
  `describe` varchar(80) NOT NULL DEFAULT '' COMMENT '描述信息',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户组状态：为1正常，为0禁用,-1为删除',
  `rules` varchar(1000) NOT NULL DEFAULT '' COMMENT '用户组拥有的规则id，多个规则 , 隔开',
  `update_time` int(10) unsigned unsigned NOT NULL DEFAULT '0',
  `create_time` int(10) unsigned unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='权限组表';

-- ----------------------------
-- Records of cm_auth_group
-- ----------------------------
INSERT INTO `cm_auth_group` VALUES ('1', '1', '', '超级管理员', '拥有至高无上的权利', '1', '超级权限', '1541001599', '1538323200');
INSERT INTO `cm_auth_group` VALUES ('2', '2', '', '管理员', '主要管理者，事情很多，权力很大', '1', '1,2,3,4,5,9,10,11,15,16,32,41,42,17,18,19,43,44,45,20,21,22,23,24,25,26,27,28,29', '1540534192', '1538323200');
INSERT INTO `cm_auth_group` VALUES ('3', '0', '', '编辑', '负责编辑文章和站点公告', '1', '1,15,16,17,32', '1540557029', '1540381656');

-- ----------------------------
-- Table structure for cm_auth_group_access
-- ----------------------------
DROP TABLE IF EXISTS `cm_auth_group_access`;
CREATE TABLE `cm_auth_group_access` (
  `uid` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `group_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '用户组id',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `create_time` int(10) unsigned unsigned NOT NULL DEFAULT '0',
  `update_time` int(10) unsigned unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户组授权表';

-- Records of cm_auth_group_access
-- ----------------------------
INSERT INTO `cm_auth_group_access` VALUES ('2', '2', '1', '1540793071', '1540793071');
INSERT INTO `cm_auth_group_access` VALUES ('3', '3', '1', '1540800597', '1540800597');


-- ----------------------------
-- Table structure for cm_wallet
-- ----------------------------
DROP TABLE IF EXISTS `cm_wallet`;
CREATE TABLE `cm_wallet` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` mediumint(8) NOT NULL COMMENT '商户ID',
  `balance` decimal(11,2) unsigned DEFAULT '0.00' COMMENT '余额=可用+冻结',
  `enable` decimal(11,2) unsigned DEFAULT '0.00' COMMENT '可用余额(已结算金额)',
  `disable` decimal(11,2) unsigned DEFAULT '0.00' COMMENT '冻结金额(待结算金额)',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '账户状态 1正常 0禁止操作',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cash_index` (`id`,`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商户资产表';

-- ----------------------------
-- Table structure for cm_wallet_cash
-- ----------------------------
DROP TABLE IF EXISTS `cm_wallet_cash`;
CREATE TABLE `cm_wallet_cash` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` mediumint(8) NOT NULL COMMENT '商户ID',
  `settle_no` varchar(80) NOT NULL COMMENT '对应结算申请',
  `cash_no` varchar(80) NOT NULL COMMENT '取现记录单号',
  `amount` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '取现金额',
  `account` int(2) NOT NULL COMMENT '取现账户（关联商户结算账户表）',
  `remarks` varchar(255) NOT NULL COMMENT '取现说明',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '取现状态',
  `create_time` int(10) unsigned NOT NULL COMMENT '申请时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '处理时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cash_index` (`id`,`uid`,`cash_no`,`status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商户账户取现记录';

-- ----------------------------
-- Table structure for cm_wallet_change
-- ----------------------------
DROP TABLE IF EXISTS `cm_wallet_change`;
CREATE TABLE `cm_wallet_change` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` mediumint(8) NOT NULL COMMENT '商户ID',
  `type` varchar(20) NOT NULL DEFAULT 'enable' COMMENT '资金类型',
  `preinc` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '变动前金额',
  `increase` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '增加金额',
  `reduce` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '减少金额',
  `suffixred` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '变动后金额',
  `remarks` varchar(255) NOT NULL COMMENT '资金变动说明',
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `change_index` (`id`,`uid`,`type`,`status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商户资产变动记录表';

-- ----------------------------
-- Table structure for cm_wallet_settle
-- ----------------------------
DROP TABLE IF EXISTS `cm_wallet_settle`;
CREATE TABLE `cm_wallet_settle` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` mediumint(8) NOT NULL COMMENT '商户ID',
  `settle_no` varchar(80) NOT NULL COMMENT '结算记录单号',
  `amount` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '结算金额',
  `rate` decimal(4,3) NOT NULL,
  `fee` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '费率金额',
  `actual` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '实际金额',
  `remarks` varchar(255) NOT NULL COMMENT '申请结算说明',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '结算状态：0-等待中 1-进行中 2- 已结款',
  `create_time` int(10) unsigned NOT NULL COMMENT '申请时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '处理时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `settle_index` (`id`,`uid`,`settle_no`,`status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商户账户结算记录';

-- ----------------------------
-- Table structure for cm_banker
-- ----------------------------
DROP TABLE IF EXISTS `cm_banker`;
CREATE TABLE `cm_banker` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT COMMENT '银行ID',
  `name` varchar(80) NOT NULL COMMENT '银行名称',
  `remarks` varchar(140) NOT NULL COMMENT '备注',
  `default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '默认账户,0-不默认,1-默认',
  `status` tinyint(1) NOT NULL DEFAULT '1'COMMENT '银行可用性',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='系统支持银行列表';

-- ----------------------------
-- Records of cm_bank
-- ----------------------------
INSERT INTO `cm_banker` VALUES ('1', '支付宝', '支付宝即时到账', '1', '1', '1535983287', '1535983287');
INSERT INTO `cm_banker` VALUES ('2', '工商银行', '工商银行两小时到账', '0', '1', '1535983287', '1535983287');
INSERT INTO `cm_banker` VALUES ('3', '农业银行', '农业银行两小时到账', '0', '1', '1535983287', '1535983287');

-- ----------------------------
-- Table structure for cm_config
-- ----------------------------
DROP TABLE IF EXISTS `cm_config`;
CREATE TABLE `cm_config` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '配置名称',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '配置标题',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置类型',
  `sort` smallint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `group` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置分组',
  `value` text NOT NULL COMMENT '配置值',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '配置选项',
  `describe` varchar(255) NOT NULL DEFAULT '' COMMENT '配置说明',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `create_time` int(10) unsigned unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `conf_name` (`name`),
  KEY `type` (`type`),
  KEY `group` (`group`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='基本配置表';

-- ----------------------------
-- Records of cm_config
-- ----------------------------
INSERT INTO `cm_config` VALUES ('1', 'seo_title', '网站标题', '1', '1', '1', '草帽聚合', '', '', '1', '1378898976', '1540556596');
INSERT INTO `cm_config` VALUES ('8', 'email_port', 'SMTP端口号', '1', '8', '2', '465', '', '如：一般为 25 或 465', '1', '0', '1540556601');
INSERT INTO `cm_config` VALUES ('2', 'seo_description', '网站描述', '2', '3', '1', 'Caomao|草帽聚合|ThinkPHP5', '', '网站搜索引擎描述，优先级低于SEO模块', '1', '1378898976', '1540556596');
INSERT INTO `cm_config` VALUES ('3', 'seo_keywords', '网站关键字', '2', '4', '1', 'Caomao,ThinkPHP5', '', '网站搜索引擎关键字，优先级低于SEO模块', '1', '1378898976', '1540556596');
INSERT INTO `cm_config` VALUES ('4', 'app_index_title', '首页标题', '1', '2', '1', '小红帽科技|草帽聚合支付', '', '', '1', '1378898976', '1540556596');
INSERT INTO `cm_config` VALUES ('5', 'app_domain', '网站域名', '1', '5', '1', 'http://www.caomao.com', '', '网站域名', '1', '1378898976', '1540556596');
INSERT INTO `cm_config` VALUES ('6', 'app_copyright', '版权信息', '2', '6', '1', '© 2018 Caomao. ', '', '版权信息', '1', '1378898976', '1540556596');
INSERT INTO `cm_config` VALUES ('7', 'email_host', 'SMTP服务器', '3', '7', '2', '2', '1:smtp.163.com,2:smtp.aliyun.com,3:smtp.qq.com', '如：smtp.163.com', '1', '1378898976', '1540556601');
INSERT INTO `cm_config` VALUES ('9', 'send_email', '发件人邮箱', '1', '9', '2', 'me@iredcap.cn', '', '', '1', '0', '1540556601');
INSERT INTO `cm_config` VALUES ('10', 'send_nickname', '发件人昵称', '1', '10', '2', '小红帽', '', '', '1', '0', '1540556601');
INSERT INTO `cm_config` VALUES ('11', 'email_password', '邮箱密码', '1', '11', '2', 'xzx595...', '', '', '1', '0', '1540556601');

-- ----------------------------
-- Table structure for cm_menu
-- ----------------------------
DROP TABLE IF EXISTS `cm_menu`;
CREATE TABLE `cm_menu` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `sort` int(100) NOT NULL DEFAULT '100' COMMENT '排序',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '菜单名称',
  `module` char(20) NOT NULL DEFAULT '' COMMENT '模块',
  `url` char(255) NOT NULL DEFAULT '' COMMENT '链接地址',
  `is_hide` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否隐藏',
  `icon` char(30) NOT NULL DEFAULT '' COMMENT '图标',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `update_time` int(10) unsigned unsigned NOT NULL DEFAULT '0',
  `create_time` int(10) unsigned unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 COMMENT='基本菜单表';

-- ----------------------------
-- Records of cm_menu
-- ----------------------------
INSERT INTO `cm_menu` VALUES ('1', '0', '100', '控制台', 'admin', '/', '0', 'console', '1', '1540484285', '1539583897');
INSERT INTO `cm_menu` VALUES ('2', '0', '100', '系统设置', 'admin', 'System', '0', 'set', '1', '1540800845', '1539583897');
INSERT INTO `cm_menu` VALUES ('3', '2', '100', '基本设置', 'admin', 'System', '0', 'set-fill', '1', '1539584897', '1539583897');
INSERT INTO `cm_menu` VALUES ('4', '3', '100', '网站设置', 'admin', 'System/website', '0', '', '1', '1539584897', '1539583897');
INSERT INTO `cm_menu` VALUES ('5', '3', '100', '邮件服务', 'admin', 'System/email', '0', '', '1', '1539584897', '1539583897');
INSERT INTO `cm_menu` VALUES ('6', '2', '100', '权限设置', 'admin', 'Admin', '0', 'set-sm', '1', '1539584897', '1539583897');
INSERT INTO `cm_menu` VALUES ('7', '6', '100', '管理员设置', 'admin', 'Admin/index', '0', '', '1', '1539584897', '1539583897');
INSERT INTO `cm_menu` VALUES ('8', '6', '100', '角色管理', 'admin', 'Admin/group', '0', '', '1', '1539584897', '1539583897');
INSERT INTO `cm_menu` VALUES ('9', '2', '100', '我的设置', 'admin', 'Admin/profile', '0', '', '1', '1540486245', '1539583897');
INSERT INTO `cm_menu` VALUES ('10', '9', '100', '基本资料', 'admin', 'System/profile', '0', '', '1', '1540557980', '1539583897');
INSERT INTO `cm_menu` VALUES ('11', '9', '100', '修改密码', 'admin', 'System/changePwd', '0', '', '1', '1540557985', '1539583897');
INSERT INTO `cm_menu` VALUES ('12', '0', '100', '支付设置', 'admin', 'Pay', '0', 'senior', '1', '1540483267', '1539583897');
INSERT INTO `cm_menu` VALUES ('13', '12', '100', '支付产品', 'admin', 'Pay/index', '0', '', '1', '1539584897', '1539583897');
INSERT INTO `cm_menu` VALUES ('14', '12', '100', '支付渠道', 'admin', 'Pay/channel', '0', '', '1', '1539584897', '1539583897');
INSERT INTO `cm_menu` VALUES ('15', '0', '100', '内容管理', 'admin', 'Article', '0', 'template', '1', '1540484655', '1539583897');
INSERT INTO `cm_menu` VALUES ('16', '15', '100', '文章管理', 'admin', 'Article/index', '0', '', '1', '1539584897', '1539583897');
INSERT INTO `cm_menu` VALUES ('17', '15', '100', '公告管理', 'admin', 'Article/notice', '0', '', '1', '1539584897', '1539583897');
INSERT INTO `cm_menu` VALUES ('18', '0', '100', '商户管理', 'admin', 'User', '0', 'user', '1', '1539584897', '1539583897');
INSERT INTO `cm_menu` VALUES ('19', '18', '100', '商户列表', 'admin', 'User/index', '0', '', '1', '1539584897', '1539583897');
INSERT INTO `cm_menu` VALUES ('20', '18', '100', '商户结算', 'admin', 'Balance/settle', '0', '', '1', '1539584897', '1539583897');
INSERT INTO `cm_menu` VALUES ('21', '18', '100', '付款记录', 'admin', 'Balance/paid', '0', '', '1', '1539584897', '1539583897');
INSERT INTO `cm_menu` VALUES ('22', '18', '100', '商户账户', 'admin', 'Account/index', '0', '', '1', '1539584897', '1539583897');
INSERT INTO `cm_menu` VALUES ('23', '18', '100', '商户资金', 'admin', 'Balance/index', '0', '', '1', '1539584897', '1539583897');
INSERT INTO `cm_menu` VALUES ('24', '18', '100', '商户API', 'admin', 'Api/index', '0', '', '1', '1539584897', '1539583897');
INSERT INTO `cm_menu` VALUES ('25', '0', '100', '订单管理', 'admin', 'Orders', '0', 'form', '1', '1539584897', '1539583897');
INSERT INTO `cm_menu` VALUES ('26', '25', '100', '交易列表', 'admin', 'Orders/index', '0', '', '1', '1539584897', '1539583897');
INSERT INTO `cm_menu` VALUES ('27', '25', '100', '退款列表', 'admin', 'Orders/refund', '0', '', '1', '1539584897', '1539583897');
INSERT INTO `cm_menu` VALUES ('28', '25', '100', '商户统计', 'admin', 'Orders/user', '0', '', '1', '1539584897', '1539583897');
INSERT INTO `cm_menu` VALUES ('29', '25', '100', '渠道统计', 'admin', 'Orders/channel', '0', '', '1', '1539584897', '1539583897');
INSERT INTO `cm_menu` VALUES ('30', '6', '100', '菜单管理', 'admin', 'Menu/index', '0', '', '1', '1539584897', '1539583897');
INSERT INTO `cm_menu` VALUES ('31', '7', '100', '获取管理员列表', 'admin', 'Admin/userList', '1', 'user', '1', '1540485169', '1540484869');
INSERT INTO `cm_menu` VALUES ('32', '16', '100', '获取文章列表', 'admin', 'Article/getList', '1', 'lis', '1', '1540485927', '1540484939');
INSERT INTO `cm_menu` VALUES ('33', '7', '100', '新增管理员', 'admin', 'Admin/userAdd', '1', 'user', '1', '1540485182', '1540485125');
INSERT INTO `cm_menu` VALUES ('34', '7', '100', '编辑管理员', 'admin', 'Admin/userEdit', '1', 'user', '1', '1540485199', '1540485155');
INSERT INTO `cm_menu` VALUES ('35', '7', '100', '删除管理员', 'admin', 'AdminuserDel', '1', 'user', '1', '1540485310', '1540485310');
INSERT INTO `cm_menu` VALUES ('36', '8', '100', '获取角色列表', 'admin', 'Admin/groupList', '1', '', '1', '1540485432', '1540485432');
INSERT INTO `cm_menu` VALUES ('37', '8', '100', '新增权限组', 'admin', 'Admin/groupAdd', '1', '', '1', '1540485531', '1540485488');
INSERT INTO `cm_menu` VALUES ('38', '8', '100', '编辑权限组', 'admin', 'Admin/groupEdit', '1', '', '1', '1540485515', '1540485515');
INSERT INTO `cm_menu` VALUES ('39', '8', '100', '删除权限组', 'admin', 'Admin/groupDel', '1', '', '1', '1540485570', '1540485570');
INSERT INTO `cm_menu` VALUES ('40', '30', '100', '获取菜单列表', 'admin', 'Menu/getList', '1', '', '1', '1540485652', '1540485632');
INSERT INTO `cm_menu` VALUES ('41', '16', '100', '新增文章', 'admin', 'Article/add', '1', '', '1', '1540486058', '1540486058');
INSERT INTO `cm_menu` VALUES ('42', '16', '100', '编辑文章', 'admin', 'Article/edit', '1', '', '1', '1540486097', '1540486097');
INSERT INTO `cm_menu` VALUES ('43', '19', '100', '获取商户列表', 'admin', 'User/getList', '1', '', '1', '1540486400', '1540486400');
INSERT INTO `cm_menu` VALUES ('44', '19', '100', '新增商户', 'admin', 'User/add', '1', '', '1', '1540533973', '1540533973');
INSERT INTO `cm_menu` VALUES ('45', '19', '100', '商户修改', 'admin', 'User/edit', '1', '', '1', '1540533993', '1540533993');
INSERT INTO `cm_menu` VALUES ('46', '30', '100', '新增菜单', 'admin', 'Menu/menuAdd', '1', '', '1', '1540534094', '1540534094');
INSERT INTO `cm_menu` VALUES ('47', '30', '100', '编辑菜单', 'admin', 'Menu/menuEdit', '1', '', '1', '1540534133', '1540534133');
INSERT INTO `cm_menu` VALUES ('48', '3', '100', '行为日志', 'admin', 'Log/index', '0', 'flag', '1', '1540563678', '1540563678');
INSERT INTO `cm_menu` VALUES ('49', '48', '100', '获取日志列表', 'admin', 'Log/getList', '1', '', '1', '1540566783', '1540566783');
INSERT INTO `cm_menu` VALUES ('50', '48', '100', '删除日志', 'admin', 'Log/logDel', '1', '', '1', '1540566819', '1540566819');
INSERT INTO `cm_menu` VALUES ('51', '48', '100', '清空日志', 'admin', 'Log/logClean', '1', '', '1', '1540566849', '1540566849');
INSERT INTO `cm_menu` VALUES ('52', '12', '100', '银行管理', 'admin', 'Pay/bank', '0', '', '1', '1540822566', '1540822549');

-- ----------------------------
-- Table structure for cm_notice
-- ----------------------------
DROP TABLE IF EXISTS `cm_notice`;
CREATE TABLE `cm_notice` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `content` varchar(250) NOT NULL COMMENT '公告内容',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '公告状态,0-不展示,1-展示',
  `create_time` int(10) unsigned unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='公告表';

-- ----------------------------
-- Table structure for cm_orders
-- ----------------------------
DROP TABLE IF EXISTS `cm_orders`;
CREATE TABLE `cm_orders` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `uid` mediumint(8) NOT NULL COMMENT '商户id',
  `trade_no` varchar(30) NOT NULL COMMENT '交易订单号',
  `out_trade_no` varchar(30) NOT NULL COMMENT '商户订单号',
  `subject` varchar(64) NOT NULL COMMENT '商品标题',
  `body` varchar(256) NOT NULL COMMENT '商品描述信息',
  `channel` varchar(30) NOT NULL COMMENT '交易方式(wx_qrcode)',
  `cnl_id` int(3) NOT NULL COMMENT '支付通道ID',
  `extra` text COMMENT '特定渠道发起时额外参数',
  `amount` decimal(11,2) unsigned NOT NULL COMMENT '实际付款金额,单位是元,12-9保留3位小数',
  `currency` varchar(3) NOT NULL DEFAULT 'CNY' COMMENT '三位货币代码,人民币:CNY',
  `client_ip` varchar(32) NOT NULL COMMENT '客户端IP',
  `return_url` varchar(128) NOT NULL COMMENT '同步通知地址',
  `notify_url` varchar(128) NOT NULL COMMENT '异步通知地址',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '订单状态:0-已取消-1-待付款，2-已付款',
  `create_time` int(10) unsigned unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_no_index` (`out_trade_no`,`trade_no`,`uid`,`channel`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='交易订单表';


-- ----------------------------
-- Table structure for cm_orders_notify
-- ----------------------------
DROP TABLE IF EXISTS `cm_orders_notify`;
CREATE TABLE `cm_orders_notify` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `is_status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `result` varchar(300) NOT NULL DEFAULT '' COMMENT '请求相响应',
  `times` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '请求次数',
  `create_time` int(10) unsigned unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='交易订单通知表';

-- ----------------------------
-- Table structure for cm_pay_code
-- ----------------------------
DROP TABLE IF EXISTS `cm_pay_code`;
CREATE TABLE `cm_pay_code` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT COMMENT '渠道ID',
  `name` varchar(30) NOT NULL COMMENT '支付方式名称',
  `code` varchar(30) NOT NULL COMMENT '支付方式代码,如:WXSCAN,WXH5,WXJSAPI;',
  `remarks` varchar(128) DEFAULT NULL COMMENT '备注',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '方式状态,0-停止使用,1-开放使用',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='交易方式表';

-- ----------------------------
-- Records of cm_pay_code
-- ----------------------------
INSERT INTO `cm_pay_code` VALUES ('1', '微信扫码支付', 'WXSCAN', '微信扫码支付', '1', '1535983487', '1539958749');
INSERT INTO `cm_pay_code` VALUES ('2', 'QQ扫码支付', 'QSCAN', 'QQ扫码支付', '1', '1539959282', '1539959282');
INSERT INTO `cm_pay_code` VALUES ('3', '支付宝Web', 'AWEP', '支付宝即时到账', '1', '1540556514', '1540556514');


-- ----------------------------
-- Table structure for cm_pay_channel
-- ----------------------------
DROP TABLE IF EXISTS `cm_pay_channel`;
CREATE TABLE `cm_pay_channel` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT COMMENT '渠道ID',
  `code_id` mediumint(10) unsigned NOT NULL COMMENT '交易方式id',
  `name` varchar(30) NOT NULL COMMENT '支付渠道名称',
  `action` varchar(30) NOT NULL COMMENT '控制器名称,如:WxScan,QScan,AliScan;用于分发处理支付请求',
  `rate` decimal(4,3) NOT NULL COMMENT '渠道费率',
  `daily` decimal(11,2) NOT NULL COMMENT '日限额',
  `param` text NOT NULL COMMENT '账户配置参数,json字符串',
  `remarks` varchar(128) DEFAULT NULL COMMENT '备注',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '渠道状态,0-停止使用,1-开放使用',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='支付渠道表';

-- ----------------------------
-- Records of cm_pay_channel
-- ----------------------------
INSERT INTO `cm_pay_channel` VALUES ('1', '1', '官方微信支付', 'WxScan', '0.020', '20000.000', '{\"mchid\":\"1493758822\",\"appid\":\"wx1c32cda245563ee1\",\"key\":\"06c56a89949d617def52f371c357b6db\",\"notify_url\":\"https://api.iredcap.cn/notify/wx_notify\"}', '草帽官方微信支付', '1', '1535983487', '1539957036');
INSERT INTO `cm_pay_channel` VALUES ('2', '2', '官方QQ支付', 'QqScan', '0.020', '20000.000', '{\"mchid\":\"1493758822\",\"appid\":\"wx1c32cda245563ee1\",\"key\":\"06c56a89949d617def52f371c357b6db\"}', '草帽官方QQ支付', '1', '1539959369', '1539959418');

-- ----------------------------
-- Table structure for cm_transaction
-- ----------------------------
DROP TABLE IF EXISTS `cm_transaction`;
CREATE TABLE `cm_transaction` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `uid` mediumint(8) DEFAULT NULL COMMENT '商户id',
  `order_no` varchar(80) DEFAULT NULL COMMENT '交易订单号',
  `amount` decimal(11,2) DEFAULT NULL COMMENT '交易金额',
  `platform` tinyint(1) DEFAULT NULL COMMENT '交易平台:1-支付宝,2-微信',
  `platform_number` varchar(200) DEFAULT NULL COMMENT '交易平台交易流水号',
  `status` tinyint(1) DEFAULT NULL COMMENT '交易状态',
  `create_time` int(10) unsigned DEFAULT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `transaction_index` (`order_no`,`platform`,`uid`,`amount`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='交易流水表';

-- ----------------------------
-- Table structure for cm_user
-- ----------------------------
DROP TABLE IF EXISTS `cm_user`;
CREATE TABLE `cm_user` (
  `uid` mediumint(8) NOT NULL AUTO_INCREMENT COMMENT '商户uid',
  `account` varchar(50) NOT NULL COMMENT '商户邮件',
  `password` varchar(50) NOT NULL COMMENT '商户登录密码',
  `username` varchar(30) NOT NULL COMMENT '商户名称',
  `phone` varchar(250) NOT NULL COMMENT '手机号',
  `qq` varchar(250) NOT NULL COMMENT 'QQ',
  `is_agent` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '代理商',
  `is_verify` tinyint(1) NOT NULL COMMENT '验证账号',
  `is_verify_phone` tinyint(1) NOT NULL COMMENT '验证手机',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '商户状态,0-未激活,1-使用中,2-禁用',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `user_name_unique` (`account`,`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商户信息表';

-- ----------------------------
-- Table structure for cm_user_account
-- ----------------------------
DROP TABLE IF EXISTS `cm_user_account`;
CREATE TABLE `cm_user_account` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `uid` mediumint(8) NOT NULL COMMENT '商户ID',
  `bank` mediumint(8) NOT NULL DEFAULT '1' COMMENT '开户行(关联银行表)',
  `account` varchar(250) NOT NULL COMMENT '开户号',
  `address` varchar(250) NOT NULL COMMENT '开户所在地',
  `remarks` varchar(250) NOT NULL COMMENT '备注',
  `default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '默认账户,0-不默认,1-默认',
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商户结算账户表';
