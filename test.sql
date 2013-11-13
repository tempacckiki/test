SELECT 	`ynu`.id, `ynu`.userId, `ynu`.identity, `ynu`.serviceId, `yns`.name, `yns`.title, `yna`.tokenData 	
FROM  ow_ynsocialconnect_user_linking  AS `ynu`
INNER JOIN `ow_ynsocialconnect_services` AS `yns` ON(`yns`.`id` = `ynu`.`serviceId`) 
INNER JOIN `ow_ynsocialconnect_agents` AS `yna` ON(`yna`.`userId` = `ynu`.`userId` AND `yna`.`serviceId` = `ynu`.`serviceId`)
WHERE 1=1 
AND `ynu`.userId = 60
GROUP BY `ynu`.id, `ynu`.identity
ORDER BY `yns`.ordering ASC


SELECT 	`ynu`.id, `ynu`.userId, `ynu`.identity, `ynu`.serviceId, `yns`.name, `yns`.title, `yna`.tokenData 	
FROM  ow_ynsocialconnect_user_linking  AS `ynu`
INNER JOIN `ow_ynsocialconnect_services` AS `yns` ON(`yns`.`id` = `ynu`.`serviceId`) 
INNER JOIN `ow_ynsocialconnect_agents` AS `yna` ON(`yna`.`userId` = `ynu`.`userId` AND `yna`.`serviceId` = `ynu`.`serviceId` AND `yna`.`identity` = `ynu`.`identity`)
WHERE 1=1 
AND `ynu`.userId = 60



SELECT 	`ynu`.*, `yns`.*
FROM  ow_ynsocialconnect_user_linking  AS `ynu`
INNER JOIN `ow_ynsocialconnect_services` AS `yns` ON(`yns`.`id` = `ynu`.`serviceId`) 
WHERE 1=1 
AND `ynu`.userId = 60
GROUP BY `ynu`.id
ORDER BY `yns`.ordering ASC


day: 0523

select u.user_id, u.full_name, u.email, u.birthday, user_field.dob_setting
from phpfox_user as u 
join phpfox_user_field as user_field on user_field.user_id = u.user_id
where u.birthday like '%0523%'


select u.user_id, u.full_name, u.email, u.birthday, user_field.dob_setting
from phpfox_user as u 
join phpfox_user_field as user_field on user_field.user_id = u.user_id
where u.birthday like '%0529%'



SELECT 	`ynu`.id, `ynu`.userId, `ynu`.identity, `ynu`.serviceId, `yns`.name, `yns`.title, `yna`.tokenData 	
FROM  ow_ynsocialconnect_user_linking  AS `ynu`
INNER JOIN `ow_ynsocialconnect_services` AS `yns` ON(`yns`.`id` = `ynu`.`serviceId`) 
INNER JOIN `ow_ynsocialconnect_agents` AS `yna` ON(`yna`.`userId` = `ynu`.`userId` AND `yna`.`serviceId` = `ynu`.`serviceId`  AND `yna`.`identity` = `ynu`.`identity` )
WHERE 1=1 
   AND `ynu`.userId = 2 ORDER BY `yns`.ordering ASC, `ynu`.id ASC 

   
   
UPDATE `phpfox_fevent`
SET image_path = CONCAT(SUBSTRING(image_path,1,40), '%s.jpg')
WHERE event_id = 448

UPDATE `phpfox_fevent`
SET image_path = '2013/05/9f27006531f6843e2909e15b01397868.jpg'
WHERE event_id = 449


SELECT SUBSTRING(image_path,1,40)
from `phpfox_fevent`
WHERE event_id = 449




CREATE TABLE IF NOT EXISTS `phpfox_reservation_payment_account` (
  `account_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `type` varchar(20) NOT NULL,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`account_id`),
  KEY `user_id` (`user_id`,`type`,`email`)
) AUTO_INCREMENT=1 ;



CREATE TABLE IF NOT EXISTS `phpfox_reservation_package` (
	`package_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
	`name` varchar(255) NOT NULL,
	`post_number` int(10) unsigned NOT NULL DEFAULT '0',
	`expire_number` int(10) unsigned DEFAULT NULL,
	`expire_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0: never expire, 1: day, 2: week, 3: month',
	`fee` decimal(14,2) unsigned NOT NULL DEFAULT '0.00',
	`active` tinyint(1) unsigned NOT NULL DEFAULT '1',
	`is_delete` tinyint(1) unsigned NOT NULL DEFAULT '0',
	PRIMARY KEY (`package_id`)
) AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `phpfox_reservation_package_user_group` (
	`package_id` int(10) unsigned NOT NULL,
	`user_group_id` int(10) unsigned NOT NULL,
	PRIMARY KEY (`package_id`,`user_group_id`)
) ;




CREATE TABLE IF NOT EXISTS `phpfox_reservation_ticket_type` (
	`event_id` int(10) unsigned NOT NULL,
	`event_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0: free, 1: paid',
	PRIMARY KEY (`event_id`)
) ;

CREATE TABLE IF NOT EXISTS `phpfox_reservation_ticket` (
	`ticket_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
	`event_id` int(10) unsigned NOT NULL,
	`name` varchar(255) NOT NULL,
	`description` mediumtext,
	`description_parsed` mediumtext,
	`price` varchar(50),
	`total_quantity` int(10) unsigned NOT NULL,
	`total_quantity_remaining` int(10) unsigned NOT NULL,
	`is_start_type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '1: specific day, 2: time before',
	`start_sales_time` int(10) unsigned NOT NULL,
	`start_day` int(10) unsigned,
	`start_hour` int(10) unsigned,
	`start_min` int(10) unsigned,
	`is_end_type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '1: specific day, 2: time before',
	`end_sales_time` int(10) unsigned NOT NULL,
	`end_day` int(10) unsigned,
	`end_hour` int(10) unsigned,
	`end_min` int(10) unsigned,
	`is_min_max_per_order` tinyint(1) unsigned NOT NULL DEFAULT '0',
	`min_per_order` int(10) unsigned,
	`max_per_order` int(10) unsigned,
	`is_active` tinyint(1) unsigned NOT NULL DEFAULT '1',
	`is_delete` tinyint(1) unsigned NOT NULL DEFAULT '0',
	PRIMARY KEY (`ticket_id`), 
	KEY `event_id` (`event_id`)
) AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `phpfox_reservation_ticket_lock` (
 `ticket_id` int(10) unsigned NOT NULL,
 `timeout_time` int(10) unsigned NOT NULL COMMENT 'if over timeout need to release lock',
 `user_id` int(10) unsigned NOT NULL,
 `lock_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0: by buyer, 1: by seller',
 `reason` varchar(255) ,
 PRIMARY KEY (`ticket_id`), 
 KEY `user_id` (`user_id`), 
 KEY `lock_type` (`lock_type`) 
)  ;

CREATE TABLE IF NOT EXISTS `phpfox_reservation_order` (
 `order_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
 `event_id` int(10) unsigned NOT NULL,
 `user_id` int(10) unsigned NOT NULL COMMENT 'is Buyer',
 `time_stamp` int(10) unsigned NOT NULL,
 `total_price` varchar(255) COMMENT 'total value of order',
 `total_quantity` int(10) unsigned COMMENT 'total order detail record',
 `total_quantity_remaining` int(10) unsigned COMMENT 'total order detail record which can be used',
 `status_payment` tinyint(1) unsigned COMMENT 'update when receive status from payment',
 `commission_value` varchar(50) COMMENT 'commission when ordering',
 `order_code` varchar(50),
 PRIMARY KEY (`order_id`), 
 KEY `event_id` (`event_id`), 
 KEY `user_id` (`user_id`)
);


CREATE TABLE IF NOT EXISTS `phpfox_reservation_order_detail` (
 `order_detail_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
 `order_id` int(10) unsigned NOT NULL,
 `ticket_id` int(10) unsigned NOT NULL,
 `price` varchar(50),
 `order_detail_code` varchar(50),
 `use_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0: available, 1: used',
 PRIMARY KEY (`order_detail_id`), 
 KEY `order_id` (`order_id`),  
 KEY `ticket_id` (`ticket_id`) 
);


CREATE TABLE IF NOT EXISTS `phpfox_reservation_request_payment` (
 `request_payment_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
 `requester_id` int(10) unsigned NOT NULL,
 `responder_id` int(10) unsigned,
 `amount` varchar(50),
 `request_message` varchar(255), 
 `request_time` int(10) unsigned NOT NULL,
 `response_message` varchar(255), 
 `respond_time` int(10) unsigned,
 `transaction_id` int(10) unsigned,
 `request_status` tinyint(1) unsigned,
 PRIMARY KEY (`request_payment_id`), 
 KEY `requester_id` (`requester_id`), 
 KEY `responder_id` (`responder_id`) 
);


view event: 
	- get ALL ticket type theo event, check table lock, release neu hop le (current datetime > timeout)
	- list ticket type co ngay end sale > current date
	- show
		. co the mua
		. khong the mua (title: co 1 user dang mua)




INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("1","2","4","1372028854","72","91","76","2","10","GUZ51KSM1WI");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("2","2","2","1389356370","66","96","91","3","5","TOD50ZSI2YD");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("3","2","3","1378269019","60","88","91","2","5","YPY84AHL7AZ");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("4","2","4","1368908938","63","68","53","3","5","TWX56ZOY5NO");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("5","2","1","1367898088","81","70","62","4","10","KYL70RHG3AD");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("6","2","22","1336353540","55","89","92","4","5","IXO71FCG3NE");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("7","2","3","1344359639","79","73","93","4","10","LJG21VOO7WL");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("8","2","1","1364485706","85","92","98","3","5","FIC61SHH8SQ");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("9","2","22","1398488419","73","68","86","4","5","KQP25VHK3NS");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("10","2","2","1366261502","74","57","53","2","10","PCP98XUX8FN");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("11","2","4","1357329730","86","75","82","2","10","BIX23CZO2PQ");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("12","2","1","1356141510","68","66","77","1","10","YGS48YQA3RJ");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("13","2","22","1388962257","95","64","81","4","10","JEK67ZOR9MY");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("14","2","1","1375166354","79","93","50","4","10","YQB22OES5OW");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("15","2","4","1368720518","89","62","97","3","10","AGU82BCO2BF");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("16","2","1","1391131763","74","57","70","2","10","OJA72HZX5AE");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("17","2","3","1380062703","99","100","79","3","10","QRU70UUM0JW");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("18","2","2","1353122142","56","53","95","2","10","ROZ61ZWA3NR");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("19","2","22","1353988193","55","63","98","4","5","GKT32WOM8GB");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("20","2","3","1369519753","90","62","58","4","5","SES91EBD7IO");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("21","2","2","1367335959","62","67","63","4","10","QZG81OUL1MQ");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("22","2","4","1385102593","75","96","92","3","10","HTS60FAE6QE");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("23","2","4","1388402821","65","89","82","1","10","EPS04NNU0VN");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("24","2","1","1347372914","73","87","81","4","5","FZX06RKD8PS");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("25","2","2","1391572329","59","96","55","1","10","AUW73ZQX6WW");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("26","2","22","1346850653","64","81","55","1","5","MUS39SVT1WN");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("27","2","1","1389586219","62","90","80","2","5","EIH74EDD6PY");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("28","2","2","1384279476","91","79","61","2","10","ZFN78QLY6PH");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("29","2","4","1381160760","75","93","89","2","10","PHX15OGT8FZ");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("30","2","22","1337557905","70","87","84","3","10","SRW54YIQ0YX");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("31","2","3","1373523916","69","60","66","4","5","ZUA74ASB3LS");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("32","2","22","1351953040","66","90","60","4","10","EPU39KOQ9NK");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("33","2","4","1396626930","98","96","68","1","10","VUR69YIC3NR");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("34","2","22","1349208947","71","61","76","1","10","NND48NBM8XG");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("35","2","2","1360929109","93","69","92","3","10","RNQ80PNO7BB");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("36","2","4","1394759270","77","70","62","1","5","YHV31EJC4AP");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("37","2","22","1374016058","73","59","69","2","5","EQN58ZFR9EY");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("38","2","3","1372701495","92","59","67","2","5","LAH63UWQ7AH");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("39","2","22","1398277081","90","93","58","1","10","XWH01DWO9HO");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("40","2","22","1344717936","88","80","88","2","10","AHD84CRK5OG");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("41","2","1","1398484053","75","100","96","3","5","NDL18FZY5AG");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("42","2","1","1393363438","79","54","65","2","5","TBH79BIC7VF");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("43","2","22","1353417069","97","53","99","3","5","ZLK07OKV3DX");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("44","2","1","1380198964","61","99","71","3","10","IBY30XRR7RC");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("45","2","22","1357213246","58","84","99","1","10","MFL46NRH5ZJ");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("46","2","22","1351482589","53","53","53","2","5","AWS68AHK2TQ");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("47","2","2","1346607209","93","79","86","2","10","INI35BOU5OQ");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("48","2","3","1354833240","75","93","78","3","10","ULI31EHI3PV");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("49","2","1","1389108717","75","59","69","4","10","HZU15AQU4KG");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("50","2","1","1358246729","50","86","68","4","5","YWB12CZX3GX");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("51","2","3","1337950847","100","62","83","3","10","XKD67SEV2DR");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("52","2","4","1337915175","62","91","91","1","5","DDV47FXG3UR");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("53","2","22","1360316342","79","63","74","1","5","WHF60SJB5NF");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("54","2","1","1349630303","92","62","96","2","10","IPQ50JOX3KE");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("55","2","2","1396097381","72","65","90","3","5","NTS76IQB3ZQ");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("56","2","2","1364184987","55","78","86","2","5","ZOA23ZUN8HG");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("57","2","4","1354869872","84","99","65","4","10","GSI84VOT4NH");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("58","2","22","1382138363","78","58","67","1","5","JWN31EXN3EF");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("59","2","1","1387352714","77","70","100","2","5","IXK42FXE0GA");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("60","2","22","1349014283","74","84","58","1","5","OLE94GRX0ZU");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("61","2","22","1364644005","68","60","90","2","10","KES03IZG9OS");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("62","2","2","1347348641","58","51","76","4","5","WSZ05PHY8RD");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("63","2","1","1383009068","86","87","93","3","5","PLZ69CLZ7HR");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("64","2","22","1358090177","82","55","56","3","10","SMT43AWJ8LV");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("65","2","22","1400444466","75","88","81","3","10","QQU77BZK1RX");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("66","2","3","1339805219","50","82","87","1","5","GLA00VLJ9CA");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("67","2","1","1368978334","91","60","97","3","5","JSQ94CLZ6SK");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("68","2","22","1356012818","59","93","71","4","10","RZX88KZS0IK");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("69","2","1","1343448339","89","94","68","4","10","UMK68RNB8EA");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("70","2","2","1354720551","51","80","58","3","5","XPM79YCY1WK");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("71","2","2","1372907952","50","67","54","4","10","GYH81QVY3TO");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("72","2","1","1392368497","81","71","97","1","5","DVA49FVS4BR");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("73","2","2","1355473456","86","88","87","3","10","UHQ22CBT0EO");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("74","2","4","1377039090","74","60","89","1","10","RXD46PSE6ML");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("75","2","22","1376706094","88","72","71","3","5","MVC66POD0GB");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("76","2","22","1356448333","69","94","68","3","5","AXI43HLW8YS");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("77","2","4","1352591959","60","73","80","1","10","FNM08IKM9KK");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("78","2","1","1381233225","65","80","72","4","5","QZC05OPJ6VW");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("79","2","2","1394162969","66","61","69","1","5","JFX96EHB0XB");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("80","2","4","1376823662","81","50","69","1","10","QZR83KNA9WF");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("81","2","2","1336234638","55","96","55","2","10","PAQ64CNX4DW");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("82","2","3","1389996556","77","62","78","3","10","HMJ26KEX4UY");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("83","2","4","1352787701","96","62","82","3","10","JIQ68BBI2JU");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("84","2","22","1370379906","88","66","73","4","5","OSW83XYC0IL");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("85","2","3","1399297321","100","80","100","1","5","VRR11FKR1ZK");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("86","2","22","1371412428","87","93","98","3","5","PIY13HPY2LQ");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("87","2","2","1357955029","99","73","64","2","5","PFM41NTU4IC");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("88","2","1","1364499142","57","67","99","1","10","TAD22CBO8RU");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("89","2","4","1342395226","96","87","64","1","5","FMY54NOI6HI");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("90","2","1","1387221635","79","60","88","4","10","ZWI71ONX3TJ");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("91","2","1","1346869567","93","57","76","3","5","DHF30MIC8HZ");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("92","2","3","1396150283","77","51","57","3","5","FGM37PWD2ZK");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("93","2","1","1361606112","83","79","94","3","5","SWN79UDL3IR");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("94","2","4","1393406108","77","79","87","2","5","LEM00LPD4HZ");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("95","2","4","1364010514","57","71","55","3","10","OLS11GCJ0OO");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("96","2","4","1343911931","59","88","71","4","5","SBQ11DGC3UO");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("97","2","2","1374185083","51","54","68","1","10","HXJ03WUR3NS");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("98","2","2","1379066034","95","99","74","1","5","FVQ31FZC4GA");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("99","2","1","1378102521","54","50","100","1","10","PDD56UCD3IY");
INSERT INTO `phpfox_reservation_order` (`order_id`,`event_id`,`user_id`,`time_stamp`,`total_price`,`total_quantity`,`total_quantity_remaining`,`status_payment`,`commission_value`,`order_code`) VALUES ("100","2","2","1379067106","80","60","82","2","10","OBF50VHA0XE");


INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("1","31","3","30","VJF43XEE9SF","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("2","36","4","22","SUU27QEF7OE","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("3","23","4","24","GXH40GDH6RR","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("4","44","3","27","MIG65ZGT9JY","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("5","46","1","26","JUW50NET0ZP","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("6","36","4","25","MLM72KBD0XL","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("7","40","3","30","WNM02NAX8OD","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("8","34","4","21","TCN82PTS6KU","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("9","46","2","22","XRS95NNR1ZI","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("10","47","4","30","UGP59FYS1UL","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("11","25","1","23","YKX40ALJ2IV","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("12","31","3","24","NOP42UGT8LJ","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("13","28","1","26","FTR61XAY0JT","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("14","50","4","28","CWO35KVY2CR","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("15","43","4","30","WPW85YGH0GL","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("16","44","4","28","EFE91KBW4VE","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("17","29","4","30","KMY67ZWF6RK","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("18","29","4","23","QSS75DOT7WW","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("19","44","3","28","HAU12MVR9DV","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("20","40","2","29","ZYA56UKO0FK","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("21","34","2","20","ETM94LDG0UL","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("22","25","4","23","WUD23ELT8XY","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("23","32","2","24","BOX18ZZG3DP","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("24","27","3","20","SJG11EBB0MA","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("25","38","4","24","IAJ32RLW2SU","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("26","43","3","21","QGH73IEI4UV","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("27","49","4","26","FGG60NJW2DT","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("28","27","3","21","CUM21XAY4ZE","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("29","49","3","20","HGN61UTW5AS","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("30","34","2","23","GJF23SHM0FG","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("31","32","1","28","PUP36DJK0WG","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("32","23","4","28","QUN92PDN2OU","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("33","26","2","21","FSI51KLJ4OY","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("34","20","1","22","KBW55CCJ3IZ","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("35","30","3","24","ZDV45IZM1ZG","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("36","43","4","23","PKM77VBT9KX","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("37","34","1","21","UDM76QTW2MJ","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("38","29","1","21","RNZ72ZDE3PN","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("39","26","4","21","GYV08CNE4VW","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("40","37","2","20","UJA95JOA0US","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("41","24","2","27","VXV30GDX6SY","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("42","44","3","30","MQI06KVJ9YG","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("43","20","1","28","YZA18RVV4PV","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("44","42","3","21","LAO23NEQ3FO","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("45","24","4","24","AZB88MKR4DM","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("46","34","2","22","MWS64AWB9AK","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("47","23","2","29","RYI05TFB5SS","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("48","26","2","26","XOP76PTA4WV","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("49","50","4","20","CNT35HAH0FD","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("50","28","4","23","YMY64JOI7OZ","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("51","34","4","28","EOB18CKZ3SS","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("52","37","3","30","ENJ78BHV7TV","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("53","42","2","27","ZCS30CCU6QV","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("54","40","2","21","AAG38ABS6UI","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("55","21","3","27","TFU80KNV5EQ","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("56","31","2","20","EHB29RAH0CG","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("57","27","2","27","BMC52QTY4DT","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("58","36","1","29","SUO71QVJ0CH","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("59","37","3","20","XIS62EUA5HV","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("60","23","1","22","MAX33ZKR2ZQ","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("61","50","4","24","FOQ95DHK1KC","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("62","30","3","23","STH14OCB1CU","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("63","31","4","29","YMZ28DQA0YK","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("64","29","2","30","FMN25SJI4TN","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("65","41","3","23","OBM10MDM8ME","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("66","36","2","27","LOJ88VOK2GU","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("67","32","2","26","JOC50YZF8NI","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("68","37","3","23","HAE84LCE0NH","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("69","20","1","20","CQZ18WQE8FD","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("70","29","3","27","MTC59DCF3CD","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("71","40","2","21","DDZ72WZK2HX","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("72","39","4","26","YHT04BEQ0VT","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("73","24","2","29","ZOS99XGW7WK","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("74","27","3","28","EAV36VFK8IG","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("75","38","2","28","ZDS29NDJ6JJ","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("76","47","4","30","JNT59QXE6MH","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("77","40","4","28","YTH01ZKM7HP","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("78","25","4","23","QPX57PAB2RD","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("79","33","2","22","ZHE37YRK6WY","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("80","37","3","21","ZYT90BRE0DC","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("81","29","1","25","IJK97CWS8KY","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("82","37","3","29","HOX97XBU8JC","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("83","49","2","30","CCA97XJT1YV","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("84","34","2","26","RTM75ICQ1BF","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("85","32","3","22","GHC60HNW7ZN","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("86","20","3","26","XIX09ACE2MI","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("87","50","2","26","JIW92PXT0YV","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("88","41","4","23","EAH21NTN0TB","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("89","21","2","25","CPD03FYE4RO","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("90","41","1","21","CXQ84RQM4SD","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("91","23","1","28","UAZ72MKT1CP","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("92","44","3","24","YDC55PHS2KJ","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("93","22","2","21","QIO00RDS6XM","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("94","38","1","30","GIO50VXJ8AM","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("95","23","4","21","KOW52MLS2BP","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("96","44","2","21","PDX55UNA5RQ","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("97","23","1","27","WXD36IJG1EU","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("98","28","2","29","LYQ99EQP1TJ","1");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("99","32","2","21","QYN92SDA9KX","0");
INSERT INTO `phpfox_reservation_order_detail` (`order_detail_id`,`order_id`,`ticket_id`,`price`,`order_detail_code`,`use_status`) VALUES ("100","45","4","23","HSN93RQR1AS","1");


--	default: get all event theo user hien tai, event da duoc publish
SELECT * 
FROM  `phpfox_reservation` 
JOIN `phpfox_reservation_transaction` ON 
				(`phpfox_reservation_transaction`.item_id = `phpfox_reservation`.event_id 
				AND `phpfox_reservation_transaction`.payment_type IN (1,3) 				
				)
WHERE  `phpfox_reservation`.`user_id` =7 AND  `phpfox_reservation`.`post_status` =1
ORDER BY `phpfox_reservation`.event_id


-- search: get all event theo user hien tai, event da duoc publish, like %event_name%, 
--			between [A] publish_time [B], status paypal : completed
SELECT * 
FROM  `phpfox_reservation` 
JOIN `phpfox_reservation_transaction` ON 
				(`phpfox_reservation_transaction`.item_id = `phpfox_reservation`.event_id 
				AND `phpfox_reservation_transaction`.payment_type IN (1,3) 
				AND `phpfox_reservation_transaction`.status = 3
				)
WHERE  `phpfox_reservation`.`user_id` =7 
		AND  `phpfox_reservation`.`post_status` =1 
		AND `phpfox_reservation`.title LIKE '%test%'
		AND `phpfox_reservation`.`publish_time` BETWEEN 1370475453 AND 1370475729
ORDER BY `phpfox_reservation`.event_id

-- search: 
--			get all event theo user hien tai
--			get all order theo event tren
--			between [A]  time_stamp cua order [B]
--			status paypal : completed/ other completed 
--			like %event_name%
SELECT `phpfox_reservation_order`.*, `phpfox_reservation`.title as 'event_name', `phpfox_user`.full_name as 'buyer'
FROM  `phpfox_reservation` 
JOIN `phpfox_reservation_order` ON 
				(`phpfox_reservation_order`.event_id = `phpfox_reservation`.event_id 
				AND `phpfox_reservation_order`.`time_stamp` BETWEEN 1370355721 AND 1370529686
				AND `phpfox_reservation_order`.status_payment = 3
				)
LEFT JOIN `phpfox_user` ON (`phpfox_reservation_order`.user_id = `phpfox_user`.user_id)				
WHERE  `phpfox_reservation`.`user_id` =7 
		AND `phpfox_reservation`.title LIKE '%test%'
ORDER BY `phpfox_reservation_order`.order_id




 ALTER TABLE  `phpfox_ynnews_items` CHANGE  `item_image`  `item_image` VARCHAR( 300 ) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL
 
 
 SHOW FULL COLUMNS FROM `phpfox_m2bmusic_album_song`;
 ALTER TABLE  `phpfox_m2bmusic_album_song` CHANGE  `title`  `title` VARCHAR( 200 ) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL
 ALTER TABLE  `phpfox_m2bmusic_album_song` CHANGE  `title_url`  `title_url` VARCHAR( 200 ) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL
 
 
 
 SHOW FULL COLUMNS FROM `phpfox_m2bmusic_album`;
 ALTER TABLE  `phpfox_m2bmusic_album` CHANGE  `title`  `title` VARCHAR( 200 ) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL
 ALTER TABLE  `phpfox_m2bmusic_album` CHANGE  `title_url`  `title_url` VARCHAR( 200 ) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL
	  
	  
	  
	  
	  
CREATE TABLE IF NOT EXISTS `phpfox_profilepopup_module_item` (
            `item_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
            `module_id` varchar(75) NOT NULL,
            `is_custom_field` tinyint(1) NOT NULL DEFAULT '0',
            `group_id` int(10) unsigned DEFAULT NULL,
            `field_id` int(10) unsigned DEFAULT NULL,
            `name` varchar(250) NOT NULL,
            `phrase_var_name` varchar(250) NOT NULL,
            `is_active` tinyint(1) NOT NULL DEFAULT '1',
            `is_display` tinyint(1) NOT NULL DEFAULT '1',
            `ordering` tinyint(1) NOT NULL DEFAULT '0',
            `item_type` enum('user','pages','event') NOT NULL DEFAULT 'user',
            PRIMARY KEY (`item_id`)
          );
		  
		  
INSERT IGNORE INTO `phpfox_profilepopup_module_item` (`item_id`, `module_id`, `is_custom_field`, `group_id`, `field_id`, `name`, `phrase_var_name`, `is_active`, `is_display`, `ordering`, `item_type`) VALUES
      (NULL, 'resume', '0', NULL, NULL, 'currently_work', 'pp_item_r_currently_work', '1', '1', '1', 'user'),
      (NULL, 'resume', '0', NULL, NULL, 'highest_level', 'pp_item_r_highest_level', '1', '1', '2', 'user'),
      (NULL, 'resume', '0', NULL, NULL, 'highest_education', 'pp_item_r_highest_education', '1', '1', '3', 'user'),
      (NULL, 'resume', '0', NULL, NULL, 'phone_number', 'pp_item_r_phone_number', '1', '1', '4', 'user'),
      (NULL, 'resume', '0', NULL, NULL, 'im', 'pp_item_r_im', '1', '1', '5', 'user'),
      (NULL, 'resume', '0', NULL, NULL, 'email', 'pp_item_r_email', '1', '1', '6', 'user'),
      (NULL, 'resume', '0', NULL, NULL, 'categories', 'pp_item_r_categories', '1', '1', '7', 'user');
	  
	  
SELECT rbi.*
	,  u.user_id, u.profile_page_id
	, u.server_id AS user_server_id
	, u.user_name, u.full_name
	, u.gender, u.user_image
	, u.is_invisible, u.user_group_id
	, u.language_id
	
FROM phpfox_resume_basicinfo AS rbi
JOIN phpfox_user AS u
	ON(u.user_id = rbi.user_id)

WHERE rbi.user_id = 1  
and( 
	rbi.user_id=1 
	or rbi.privacy=0 
	or (rbi.privacy=1 and 1="1") 
	or (rbi.privacy=1 and rbi.user_id=1) 
	or (
		rbi.privacy=2 
		and 0<(select count("*") from phpfox_friend f where f.user_id = rbi.user_id AND f.friend_user_id = 1)
		)  
)

ORDER BY rbi.time_stamp DESC
LIMIT 5