/*
Navicat MySQL Data Transfer

Source Server         : mysql_server
Source Server Version : 50719
Source Host           : localhost:3306
Source Database       : atm

Target Server Type    : MYSQL
Target Server Version : 50719
File Encoding         : 65001

Date: 2017-09-21 16:57:28
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `transaction`
-- ----------------------------
DROP TABLE IF EXISTS `transaction`;
CREATE TABLE `transaction` (
  `trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `balance` int(50) DEFAULT NULL,
  `date_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`trans_id`),
  KEY `email` (`email`),
  CONSTRAINT `email` FOREIGN KEY (`email`) REFERENCES `users` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of transaction
-- ----------------------------
INSERT INTO `transaction` VALUES ('1', 'festo782@gmail.com', '550', '2017-09-21 16:54:19');

-- ----------------------------
-- Table structure for `trans_history`
-- ----------------------------
DROP TABLE IF EXISTS `trans_history`;
CREATE TABLE `trans_history` (
  `trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `trans_type` varchar(50) DEFAULT NULL,
  `amount` int(50) DEFAULT NULL,
  `balance` int(50) DEFAULT NULL,
  `charges` int(11) DEFAULT NULL,
  `date_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`trans_id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of trans_history
-- ----------------------------
INSERT INTO `trans_history` VALUES ('43', 'makau@gmail.com', '', '0', '1000', '1000', '2017-09-21 16:52:53');
INSERT INTO `trans_history` VALUES ('44', 'makau@gmail.com', '', '10', '500', '490', '2017-09-21 16:53:46');
INSERT INTO `trans_history` VALUES ('45', 'festo782@gmail.com', 'receiv_transfer', '200', '550', '0', '2017-09-21 16:54:19');
INSERT INTO `trans_history` VALUES ('46', 'makau@gmail.com', 'Withdraw_transfer', '200', '240', '50', '2017-09-21 16:54:19');

-- ----------------------------
-- Table structure for `users`
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `fname` varchar(255) NOT NULL,
  `phone` int(50) NOT NULL,
  `email` varchar(255) NOT NULL DEFAULT 'unique',
  `password` varchar(255) NOT NULL,
  `time_stamp` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('13', 'festo', '2232323', 'festo782@gmail.com', '12345', '2017-09-05 17:25:12');
