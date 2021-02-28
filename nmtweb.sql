/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50529
Source Host           : localhost:3306
Source Database       : nmtweb

Target Server Type    : MYSQL
Target Server Version : 50529
File Encoding         : 65001

Date: 2018-06-10 20:44:50
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `answer`
-- ----------------------------
DROP TABLE IF EXISTS `answer`;
CREATE TABLE `answer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `aString` varchar(1000) NOT NULL,
  `qUserName` varchar(50) NOT NULL,
  `aDate` varchar(20) NOT NULL,
  `aUserName` varchar(50) NOT NULL,
  `qId` int(11) NOT NULL,
  `accept` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of answer
-- ----------------------------
INSERT INTO `answer` VALUES ('1', '这是一本书。', 'lss', '2018-02-26 21:16:20', 'zmr', '9', '0');
INSERT INTO `answer` VALUES ('2', '我们一块去吃披萨。', 'lss', '2018-02-26 21:16:20', 'zmr', '10', '0');
INSERT INTO `answer` VALUES ('3', '让我们开始学习！', 'lss', '2018-02-26 21:16:20', 'zmr', '11', '0');
INSERT INTO `answer` VALUES ('4', '一块去爬山吧！', 'lss', '2018-02-26 21:16:20', 'zmr', '12', '0');
INSERT INTO `answer` VALUES ('5', '我的名字是张明睿', 'zmr', '2018-03-01 20:19:00', 'lss', '1', '0');
INSERT INTO `answer` VALUES ('6', '它是狗', 'zmr', '2018-03-01 20:19:00', 'lss', '2', '1');
INSERT INTO `answer` VALUES ('7', '我的名字叫张明睿', 'zmr', '2018-03-01 20:19:00', 'lss', '1', '0');
INSERT INTO `answer` VALUES ('8', '抱歉，这是我的书', 'zmr', '2018-03-01 20:19:00', 'lss', '3', '1');
INSERT INTO `answer` VALUES ('9', '好的，一块走', 'zmr', '2018-03-01 20:19:00', 'lss', '4', '1');
INSERT INTO `answer` VALUES ('10', '我想取得最高的奖项', 'zmr', '2018-03-01 20:19:00', 'lss', '5', '0');
INSERT INTO `answer` VALUES ('11', '她是我的朋友，她的名字是刘姗姗', 'zmr', '2018-03-01 20:19:00', 'lss', '6', '0');
INSERT INTO `answer` VALUES ('12', '我想有一场旅行', 'zmr', '2018-03-01 20:19:00', 'lss', '7', '0');
INSERT INTO `answer` VALUES ('13', '我们去吃披萨吧！', 'zmr', '2018-03-01 20:19:00', 'lss', '8', '0');
INSERT INTO `answer` VALUES ('14', '这个女孩如此美丽', 'zmr', '2018-03-01 20:19:00', 'lss', '13', '0');
INSERT INTO `answer` VALUES ('15', '她是我的妈妈', 'zmr', '2018-03-01 20:19:00', 'lss', '14', '1');
INSERT INTO `answer` VALUES ('16', '我叫张明睿', 'zmr', '2018-03-01 15:19:05', 'lss', '1', '0');
INSERT INTO `answer` VALUES ('17', '一只狗', 'zmr', '2018-03-02 09:48:11', 'lss', '2', '0');
INSERT INTO `answer` VALUES ('18', '对不起，这是我的书', 'zmr', '2018-03-02 09:55:07', 'lss', '3', '0');
INSERT INTO `answer` VALUES ('19', '好的，走起', 'zmr', '2018-03-02 10:30:45', 'lss', '4', '0');
INSERT INTO `answer` VALUES ('20', '我想夺得最好的奖项', 'zmr', '2018-03-02 10:38:00', 'lss', '5', '0');
INSERT INTO `answer` VALUES ('21', '我想夺得最高的奖', 'zmr', '2018-03-02 10:38:00', 'lss', '5', '0');
INSERT INTO `answer` VALUES ('22', '我想取得最好的奖项', 'zmr', '2018-03-02 10:38:00', 'lss', '5', '0');
INSERT INTO `answer` VALUES ('23', '我想取得最高的奖', 'zmr', '2018-03-02 10:38:00', 'lss', '5', '0');
INSERT INTO `answer` VALUES ('24', '这是我的手表', 'zmr', '2018-03-02 10:52:39', 'lss', '15', '0');
INSERT INTO `answer` VALUES ('25', '我想赢得最高的奖项', 'zmr', '2018-03-02 10:55:23', 'lss', '5', '1');
INSERT INTO `answer` VALUES ('26', '我想去旅行', 'zmr', '2018-03-02 13:40:05', 'zmr', '7', '0');
INSERT INTO `answer` VALUES ('27', '这个女孩好漂亮啊！', 'zmr', '2018-03-02 13:40:46', 'lss', '13', '1');
INSERT INTO `answer` VALUES ('28', '让我们一块去爬山吧！', 'lss', '2018-03-02 13:41:44', 'zmr', '12', '0');
INSERT INTO `answer` VALUES ('29', '我是张明睿', 'zmr', '2018-03-02 13:46:35', 'zmr', '1', '1');
INSERT INTO `answer` VALUES ('30', '漂亮的女孩！', 'zmr', '2018-03-04 11:50:40', 'lss', '13', '0');
INSERT INTO `answer` VALUES ('31', '他是我的好朋友。', 'test0', '2018-03-05 10:53:17', 'test1', '17', '1');
INSERT INTO `answer` VALUES ('32', '你好啊？', 'zmr', '2018-03-05 11:08:37', 'test0', '16', '1');
INSERT INTO `answer` VALUES ('33', '我在修改程序错误。', 'zmr', '2018-03-05 14:40:25', 'lss', '19', '0');
INSERT INTO `answer` VALUES ('34', '他在修改程序错误', 'lss', '2018-03-05 14:48:42', 'zmr', '20', '1');
INSERT INTO `answer` VALUES ('35', '我是一个学生。', 'zmr', '2018-03-05 16:51:49', 'lss', '21', '1');
INSERT INTO `answer` VALUES ('36', '这是我的笔，你不能用！', 'lss', '2018-05-07 22:00:51', 'test5', '22', '1');

-- ----------------------------
-- Table structure for `corpusinfo`
-- ----------------------------
DROP TABLE IF EXISTS `corpusinfo`;
CREATE TABLE `corpusinfo` (
  `name` varchar(255) NOT NULL,
  `comeFrom` varchar(255) NOT NULL,
  `ciDate` varchar(255) NOT NULL,
  `isUsed` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of corpusinfo
-- ----------------------------
INSERT INTO `corpusinfo` VALUES ('test', 'Zmr', '2018-06-01 19:30:42', '0');
INSERT INTO `corpusinfo` VALUES ('UM-Corpus-Bi-Laws', '自然语言处理与中葡机器翻译实验室', '2018-03-06 19:40:49', '1');
INSERT INTO `corpusinfo` VALUES ('UM-Corpus-Bi-Microblog', '自然语言处理与中葡机器翻译实验室', '2018-03-06 20:33:18', '1');
INSERT INTO `corpusinfo` VALUES ('UM-Corpus-Bi-Science', '自然语言处理与中葡机器翻译实验室', '2018-05-07 22:06:00', '0');
INSERT INTO `corpusinfo` VALUES ('UM-Corpus-Test', '自然语言处理与中葡机器翻译实验室', '2018-03-06 19:35:48', '1');
INSERT INTO `corpusinfo` VALUES ('人工翻译语料库', 'NMT-Web 机器翻译平台', '2018-05-07 22:03:32', '0');

-- ----------------------------
-- Table structure for `corpus_en_cn`
-- ----------------------------
DROP TABLE IF EXISTS `corpus_en_cn`;
CREATE TABLE `corpus_en_cn` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qString` varchar(1000) NOT NULL,
  `aString` varchar(1000) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of corpus_en_cn
-- ----------------------------
INSERT INTO `corpus_en_cn` VALUES ('1', 'Ok, let\'s go.', '好的，一块走');
INSERT INTO `corpus_en_cn` VALUES ('2', 'My name is zhangmingrui.', '我是张明睿');
INSERT INTO `corpus_en_cn` VALUES ('3', 'It is a dog.', '它是狗');
INSERT INTO `corpus_en_cn` VALUES ('4', 'This girl is so beautiful!', '这个女孩好漂亮啊！');
INSERT INTO `corpus_en_cn` VALUES ('5', 'Sorry, this is my book.', '抱歉，这是我的书');
INSERT INTO `corpus_en_cn` VALUES ('6', 'I want to get the best prize.', '我想赢得最高的奖项');
INSERT INTO `corpus_en_cn` VALUES ('7', 'He is my good friend.', '他是我的好朋友。');
INSERT INTO `corpus_en_cn` VALUES ('8', 'How are you?', '你好啊？');
INSERT INTO `corpus_en_cn` VALUES ('9', 'I am a student.', '我是一个学生。');
INSERT INTO `corpus_en_cn` VALUES ('10', 'He is debugging.', '他在修改程序错误');
INSERT INTO `corpus_en_cn` VALUES ('11', 'She is my mother.', '她是我的妈妈');
INSERT INTO `corpus_en_cn` VALUES ('12', 'This is my pen, you can\'t use it!', '这是我的笔，你不能用！');

-- ----------------------------
-- Table structure for `message`
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qId` int(11) NOT NULL,
  `aId` int(11) NOT NULL,
  `qUserName` varchar(50) NOT NULL,
  `aUserName` varchar(50) NOT NULL,
  `mDate` varchar(20) NOT NULL,
  `qString` varchar(1000) NOT NULL,
  `aString` varchar(1000) NOT NULL,
  `type` int(11) NOT NULL COMMENT '0为回答，1为采纳',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES ('7', '5', '25', 'zmr', 'lss', '2018-03-05 08:48:56', 'I want to get the best prize.', '我想赢得最高的奖项', '1');
INSERT INTO `message` VALUES ('8', '17', '31', 'test0', 'test1', '2018-03-05 10:53:17', 'He is my good friend.', '他是我的好朋友。', '0');
INSERT INTO `message` VALUES ('9', '17', '31', 'test0', 'test1', '2018-03-05 10:54:37', 'He is my good friend.', '他是我的好朋友。', '1');
INSERT INTO `message` VALUES ('10', '16', '32', 'zmr', 'test0', '2018-03-05 11:08:37', 'How are you?', '你好啊？', '0');
INSERT INTO `message` VALUES ('11', '16', '32', 'zmr', 'test0', '2018-03-05 11:10:20', 'How are you?', '你好啊？', '1');
INSERT INTO `message` VALUES ('13', '20', '34', 'lss', 'zmr', '2018-03-05 14:48:42', 'He is debugging.', '他在修改程序错误', '0');
INSERT INTO `message` VALUES ('14', '21', '35', 'zmr', 'lss', '2018-03-05 16:51:49', 'I am a student.', '我是一个学生。', '0');
INSERT INTO `message` VALUES ('15', '21', '35', 'zmr', 'lss', '2018-03-05 16:52:10', 'I am a student.', '我是一个学生。', '1');
INSERT INTO `message` VALUES ('16', '20', '34', 'lss', 'zmr', '2018-03-07 09:48:25', 'He is debugging.', '他在修改程序错误', '1');
INSERT INTO `message` VALUES ('17', '14', '15', 'zmr', 'lss', '2018-05-07 21:58:19', 'She is my mother.', '她是我的妈妈', '1');
INSERT INTO `message` VALUES ('18', '22', '36', 'lss', 'test5', '2018-05-07 22:00:51', 'This is my pen, you can\'t use it!', '这是我的笔，你不能用！', '0');
INSERT INTO `message` VALUES ('19', '22', '36', 'lss', 'test5', '2018-05-07 22:01:32', 'This is my pen, you can\'t use it!', '这是我的笔，你不能用！', '1');

-- ----------------------------
-- Table structure for `question`
-- ----------------------------
DROP TABLE IF EXISTS `question`;
CREATE TABLE `question` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qString` varchar(1000) NOT NULL,
  `userName` varchar(50) NOT NULL,
  `qDate` varchar(20) NOT NULL,
  `aNum` int(11) unsigned NOT NULL,
  `end` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of question
-- ----------------------------
INSERT INTO `question` VALUES ('1', 'My name is zhangmingrui.', 'zmr', '2018-02-26 21:16:20', '4', '1');
INSERT INTO `question` VALUES ('2', 'It is a dog.', 'zmr', '2018-02-28 19:17:31', '2', '1');
INSERT INTO `question` VALUES ('3', 'Sorry, this is my book.', 'zmr', '2018-02-28 19:17:31', '2', '1');
INSERT INTO `question` VALUES ('4', 'Ok, let\'s go.', 'zmr', '2018-02-28 19:17:31', '2', '1');
INSERT INTO `question` VALUES ('5', 'I want to get the best prize.', 'zmr', '2018-02-28 19:17:31', '6', '1');
INSERT INTO `question` VALUES ('6', 'She is my friend, Her name is lss.', 'zmr', '2018-02-28 19:17:31', '1', '0');
INSERT INTO `question` VALUES ('7', 'I want to have a travel.', 'zmr', '2018-02-28 19:17:31', '2', '0');
INSERT INTO `question` VALUES ('8', 'Let us go to eat piza!', 'zmr', '2018-02-28 19:17:31', '1', '0');
INSERT INTO `question` VALUES ('9', 'This is a book.', 'lss', '2018-02-23 21:47:15', '1', '0');
INSERT INTO `question` VALUES ('10', 'Let\'s go to eat piza.', 'lss', '2018-02-23 21:47:15', '1', '0');
INSERT INTO `question` VALUES ('11', 'Let\'s start to study!', 'lss', '2018-02-23 21:47:15', '1', '0');
INSERT INTO `question` VALUES ('12', 'Let\'s climb the mountain!', 'lss', '2018-02-23 21:47:15', '2', '0');
INSERT INTO `question` VALUES ('13', 'This girl is so beautiful!', 'zmr', '2018-03-01 15:19:05', '3', '1');
INSERT INTO `question` VALUES ('14', 'She is my mother.', 'zmr', '2018-03-01 15:22:17', '1', '1');
INSERT INTO `question` VALUES ('15', 'This is my watch.', 'zmr', '2018-03-02 08:35:00', '1', '0');
INSERT INTO `question` VALUES ('16', 'How are you?', 'zmr', '2018-03-05 09:46:16', '1', '1');
INSERT INTO `question` VALUES ('17', 'He is my good friend.', 'test0', '2018-03-05 10:51:27', '1', '1');
INSERT INTO `question` VALUES ('18', 'My duty is to test the project.', 'test1', '2018-03-05 10:57:06', '0', '0');
INSERT INTO `question` VALUES ('19', 'I am debugging.', 'zmr', '2018-03-05 11:17:13', '1', '0');
INSERT INTO `question` VALUES ('20', 'He is debugging.', 'lss', '2018-03-05 14:41:05', '1', '1');
INSERT INTO `question` VALUES ('21', 'I am a student.', 'zmr', '2018-03-05 16:51:19', '1', '1');
INSERT INTO `question` VALUES ('22', 'This is my pen, you can\'t use it!', 'lss', '2018-05-07 21:59:49', '1', '1');
INSERT INTO `question` VALUES ('23', 'I want to be a good man.', 'zmr', '2018-06-01 19:18:51', '0', '0');

-- ----------------------------
-- Table structure for `syschange`
-- ----------------------------
DROP TABLE IF EXISTS `syschange`;
CREATE TABLE `syschange` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `opt` varchar(20) NOT NULL,
  `target` varchar(30) NOT NULL,
  `cDate` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of syschange
-- ----------------------------
INSERT INTO `syschange` VALUES ('4', '语料库添加', 'UM-Corpus-Bi-Education', '2018-03-06 18:47:15');
INSERT INTO `syschange` VALUES ('5', '语料库下载', 'UM-Corpus-Bi-Education', '2018-03-06 19:33:21');
INSERT INTO `syschange` VALUES ('6', '语料库删除', 'UM-Corpus-Test', '2018-03-06 19:34:47');
INSERT INTO `syschange` VALUES ('7', '语料库添加', 'UM-Corpus-Test', '2018-03-06 19:35:48');
INSERT INTO `syschange` VALUES ('8', '语料库添加', 'UM-Corpus-Bi-Laws', '2018-03-06 19:40:49');
INSERT INTO `syschange` VALUES ('9', '语料库添加', 'UM-Corpus-Bi-Microblog', '2018-03-06 20:33:18');
INSERT INTO `syschange` VALUES ('10', '语料库添加', '人工翻译语料库', '2018-03-06 22:25:32');
INSERT INTO `syschange` VALUES ('11', '语料库删除', '人工翻译语料库', '2018-03-07 09:38:39');
INSERT INTO `syschange` VALUES ('12', '语料库添加', '人工翻译语料库', '2018-03-07 09:38:47');
INSERT INTO `syschange` VALUES ('13', '语料库下载', '人工翻译语料库', '2018-03-07 09:42:27');
INSERT INTO `syschange` VALUES ('14', '语料库删除', '人工翻译语料库', '2018-03-07 09:44:47');
INSERT INTO `syschange` VALUES ('15', '语料库添加', '人工翻译语料库', '2018-03-07 09:44:49');
INSERT INTO `syschange` VALUES ('16', '语料库下载', '人工翻译语料库', '2018-03-07 09:44:55');
INSERT INTO `syschange` VALUES ('17', '语料库删除', '人工翻译语料库', '2018-03-07 09:49:42');
INSERT INTO `syschange` VALUES ('18', '语料库添加', '人工翻译语料库', '2018-03-07 09:49:47');
INSERT INTO `syschange` VALUES ('19', '语料库下载', '人工翻译语料库', '2018-03-07 09:49:50');
INSERT INTO `syschange` VALUES ('20', '语料库下载', 'UM-Corpus-Bi-Education', '2018-04-05 09:41:23');
INSERT INTO `syschange` VALUES ('21', '语料库删除', 'UM-Corpus-Bi-Education', '2018-04-05 09:43:22');
INSERT INTO `syschange` VALUES ('22', '语料库删除', '人工翻译语料库', '2018-04-17 16:55:20');
INSERT INTO `syschange` VALUES ('23', '语料库添加', '人工翻译语料库', '2018-04-17 16:55:23');
INSERT INTO `syschange` VALUES ('24', '语料库下载', '人工翻译语料库', '2018-04-17 16:58:08');
INSERT INTO `syschange` VALUES ('25', '语料库添加', 'UM-Corpus-Bi-Education', '2018-04-17 17:01:54');
INSERT INTO `syschange` VALUES ('26', '语料库下载', '人工翻译语料库', '2018-04-17 17:02:31');
INSERT INTO `syschange` VALUES ('27', '语料库下载', 'UM-Corpus-Bi-Education', '2018-04-17 17:02:49');
INSERT INTO `syschange` VALUES ('28', '语料库删除', 'UM-Corpus-Bi-Education', '2018-04-17 17:03:29');
INSERT INTO `syschange` VALUES ('29', '模型训练', 'Ch2En', '2018-04-26 19:51:23');
INSERT INTO `syschange` VALUES ('30', '模型训练', 'Ch2En', '2018-04-26 20:03:11');
INSERT INTO `syschange` VALUES ('31', '模型训练', 'Ch2En', '2018-04-26 20:18:41');
INSERT INTO `syschange` VALUES ('32', '模型训练', 'Ch2En', '2018-04-26 20:22:44');
INSERT INTO `syschange` VALUES ('33', '模型训练', 'Ch2En', '2018-04-26 20:30:27');
INSERT INTO `syschange` VALUES ('34', '模型训练', 'Ch2En', '2018-04-26 20:39:48');
INSERT INTO `syschange` VALUES ('35', '语料库下载', 'UM-Corpus-Bi-Laws', '2018-05-07 22:02:59');
INSERT INTO `syschange` VALUES ('36', '语料库删除', '人工翻译语料库', '2018-05-07 22:03:25');
INSERT INTO `syschange` VALUES ('37', '语料库添加', '人工翻译语料库', '2018-05-07 22:03:32');
INSERT INTO `syschange` VALUES ('38', '语料库添加', 'UM-Corpus-Bi-Science', '2018-05-07 22:06:00');
INSERT INTO `syschange` VALUES ('39', '模型训练', 'Ch2En', '2018-05-07 22:07:03');
INSERT INTO `syschange` VALUES ('40', '模型训练', 'Ch2En', '2018-05-07 22:14:08');
INSERT INTO `syschange` VALUES ('41', '模型训练', 'Ch2En', '2018-05-07 22:22:01');
INSERT INTO `syschange` VALUES ('42', '模型训练', 'Ch2En', '2018-05-07 22:27:35');
INSERT INTO `syschange` VALUES ('43', '模型训练', 'Ch2En', '2018-05-07 22:34:01');
INSERT INTO `syschange` VALUES ('44', '模型训练', 'Ch2En', '2018-05-07 22:39:15');
INSERT INTO `syschange` VALUES ('45', '模型训练', 'Ch2En', '2018-05-07 22:45:47');
INSERT INTO `syschange` VALUES ('46', '模型训练', 'En2Ch', '2018-05-18 10:08:16');
INSERT INTO `syschange` VALUES ('47', '模型训练', 'En2Ch', '2018-05-18 10:19:52');
INSERT INTO `syschange` VALUES ('48', '模型训练', 'Ch2En', '2018-05-18 10:25:43');
INSERT INTO `syschange` VALUES ('49', '模型训练', 'Ch2En', '2018-05-18 10:36:56');
INSERT INTO `syschange` VALUES ('50', '语料库添加', 'test', '2018-06-01 19:30:42');

-- ----------------------------
-- Table structure for `userinfo`
-- ----------------------------
DROP TABLE IF EXISTS `userinfo`;
CREATE TABLE `userinfo` (
  `userName` varchar(50) NOT NULL,
  `lastLoginTime` varchar(50) NOT NULL,
  `questionNum` varchar(50) NOT NULL,
  `answerNum` varchar(50) NOT NULL,
  `acceptNum` varchar(50) NOT NULL,
  `userType` varchar(50) NOT NULL,
  `sex` varchar(50) NOT NULL,
  `comeFrom` varchar(50) NOT NULL,
  `signature` varchar(1000) NOT NULL,
  `email` varchar(50) NOT NULL,
  PRIMARY KEY (`userName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userinfo
-- ----------------------------
INSERT INTO `userinfo` VALUES ('lss', '2018-06-01 19:11:20', '6', '25', '6', '普通用户', '女', '潍坊', '人生仿若一场修行', '123456789@qq.com');
INSERT INTO `userinfo` VALUES ('test0', '2018-03-07 09:47:55', '1', '1', '1', '普通用户', '男', '未填写', '未填写', '未填写');
INSERT INTO `userinfo` VALUES ('test1', '2018-03-05 10:56:33', '1', '1', '1', '普通用户', '女', '上海', '我是一个测试用户', '123456789@qq.com');
INSERT INTO `userinfo` VALUES ('test2', '2018-03-05 10:40:42', '0', '0', '0', '普通用户', '男', '未填写', '未填写', '未填写');
INSERT INTO `userinfo` VALUES ('test3', '2018-03-05 10:41:40', '0', '0', '0', '普通用户', '男', '未填写', '未填写', '未填写');
INSERT INTO `userinfo` VALUES ('test4', '2018-03-05 10:43:27', '0', '0', '0', '普通用户', '男', '未填写', '未填写', '未填写');
INSERT INTO `userinfo` VALUES ('test5', '2018-05-07 22:02:20', '0', '1', '1', '普通用户', '男', '未填写', '未填写', '未填写');
INSERT INTO `userinfo` VALUES ('zls', '2018-04-05 09:16:22', '0', '0', '0', '普通用户', '男', '未填写', '未填写', '未填写');
INSERT INTO `userinfo` VALUES ('zmr', '2018-06-01 19:14:35', '15', '8', '2', '普通用户', '男', '泰安', '低调做人，高调做事', '1307068691@qq.com');

-- ----------------------------
-- Table structure for `userlogin`
-- ----------------------------
DROP TABLE IF EXISTS `userlogin`;
CREATE TABLE `userlogin` (
  `userName` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL COMMENT '用户登录信息表',
  PRIMARY KEY (`userName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userlogin
-- ----------------------------
INSERT INTO `userlogin` VALUES ('admin', '123456');
INSERT INTO `userlogin` VALUES ('lss', '123456');
INSERT INTO `userlogin` VALUES ('test0', '123456');
INSERT INTO `userlogin` VALUES ('test1', '123456');
INSERT INTO `userlogin` VALUES ('test2', '123456');
INSERT INTO `userlogin` VALUES ('test3', '123456');
INSERT INTO `userlogin` VALUES ('test4', '123456');
INSERT INTO `userlogin` VALUES ('test5', '123456');
INSERT INTO `userlogin` VALUES ('zls', '123456');
INSERT INTO `userlogin` VALUES ('zmr', '123456');
