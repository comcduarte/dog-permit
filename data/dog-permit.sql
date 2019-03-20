CREATE TABLE IF NOT EXISTS `actions` (
  `UUID` varchar(36) NOT NULL,
  `ACTION` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `annotations` (
  `UUID` varchar(36) NOT NULL,
  `TABLENAME` varchar(100) DEFAULT NULL,
  `PRIKEY` varchar(36) DEFAULT NULL,
  `USER` varchar(36) DEFAULT NULL,
  `STATUS` int(11) DEFAULT NULL,
  `DATE_CREATED` timestamp NULL DEFAULT NULL,
  `DATE_MODIFIED` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ANNOTATION` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dogs` (
  `UUID` varchar(36) NOT NULL,
  `NAME` varchar(100) DEFAULT NULL,
  `BREED` varchar(36) DEFAULT NULL,
  `SEX` int(11) DEFAULT NULL,
  `DESCRIPTION` text,
  `DATE_BIRTH` date DEFAULT NULL,
  `DATE_RABIESEXP` date DEFAULT NULL,
  `MICROCHIP` varchar(255) DEFAULT NULL,
  `PHOTO` varchar(255) DEFAULT NULL,
  `STATUS` int(11) DEFAULT NULL,
  `DATE_CREATED` timestamp NULL DEFAULT NULL,
  `DATE_MODIFIED` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dog_breeds` (
  `UUID` varchar(36) NOT NULL DEFAULT 'UUID()',
  `BREED` varchar(255) DEFAULT NULL,
  `STATUS` int(11) DEFAULT NULL,
  `DATE_CREATED` timestamp NULL DEFAULT NULL,
  `DATE_MODIFIED` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dog_codes` (
  `UUID` varchar(36) NOT NULL,
  `CODE` varchar(10) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `STATUS` int(11) DEFAULT NULL,
  `DATE_CREATED` timestamp NULL DEFAULT NULL,
  `DATE_MODIFIED` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dog_licenses` (
  `UUID` varchar(36) NOT NULL,
  `TAG` int(11) DEFAULT NULL,
  `DOG` varchar(36) DEFAULT NULL,
  `YEAR` varchar(4) DEFAULT NULL,
  `STATUS` int(11) DEFAULT NULL,
  `PAYMENT_STATUS` int(11) DEFAULT '0',
  `FEE` tinyint(4) DEFAULT NULL,
  `DATE_CREATED` timestamp NULL DEFAULT NULL,
  `DATE_MODIFIED` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dog_users` (
  `UUID` varchar(36) NOT NULL,
  `USER` varchar(36) NOT NULL,
  `DOG` varchar(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Version00001';

CREATE TABLE IF NOT EXISTS `license_codes` (
  `UUID` varchar(36) NOT NULL,
  `CODE` varchar(36) NOT NULL,
  `LICENSE` varchar(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Version00001';

CREATE TABLE IF NOT EXISTS `reports` (
  `UUID` varchar(36) NOT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `CODE` text,
  `VIEW` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `roles` (
  `UUID` varchar(36) NOT NULL,
  `ROLENAME` varchar(255) DEFAULT NULL,
  `STATUS` int(11) DEFAULT NULL,
  `DATE_CREATED` timestamp NULL DEFAULT NULL,
  `DATE_MODIFIED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Version00001';

CREATE TABLE IF NOT EXISTS `users` (
  `UUID` varchar(36) NOT NULL,
  `USERNAME` varchar(32) NOT NULL,
  `FNAME` varchar(100) DEFAULT NULL,
  `LNAME` varchar(100) DEFAULT NULL,
  `ADDR1` varchar(100) DEFAULT NULL,
  `ADDR2` varchar(100) DEFAULT NULL,
  `CITY` varchar(100) DEFAULT NULL,
  `STATE` varchar(2) DEFAULT NULL,
  `ZIP` varchar(9) DEFAULT NULL,
  `PHONE` varchar(10) DEFAULT NULL,
  `EMAIL` varchar(64) DEFAULT NULL,
  `PASSWORD` varchar(64) NOT NULL,
  `STATUS` int(11) DEFAULT NULL,
  `DATE_CREATED` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `DATE_MODIFIED` timestamp NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Version00001';

CREATE TABLE IF NOT EXISTS `user_roles` (
  `UUID` varchar(36) NOT NULL,
  `USER` varchar(36) NOT NULL,
  `ROLE` varchar(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Version00001';
CREATE TABLE IF NOT EXISTS `view_dogusersform` (
`UUID` varchar(36)
,`NAME` varchar(202)
);
CREATE TABLE IF NOT EXISTS `view_licensecodesform` (
`UUID` varchar(36)
,`CODE` varchar(268)
);
DROP TABLE IF EXISTS `view_dogusersform`;

CREATE VIEW `view_dogusersform` AS select `users`.`UUID` AS `UUID`,concat(`users`.`LNAME`,', ',`users`.`FNAME`) AS `NAME` from `users` order by concat(`users`.`LNAME`,', ',`users`.`FNAME`);
DROP TABLE IF EXISTS `view_licensecodesform`;

CREATE VIEW `view_licensecodesform` AS select `dog_codes`.`UUID` AS `UUID`,concat(`dog_codes`.`CODE`,' - ',`dog_codes`.`DESCRIPTION`) AS `CODE` from `dog_codes`;


ALTER TABLE `actions`
  ADD PRIMARY KEY (`UUID`);

ALTER TABLE `annotations`
  ADD PRIMARY KEY (`UUID`);

ALTER TABLE `dogs`
  ADD PRIMARY KEY (`UUID`);

ALTER TABLE `dog_breeds`
  ADD PRIMARY KEY (`UUID`),
  ADD FULLTEXT KEY `BREED` (`BREED`);

ALTER TABLE `dog_codes`
  ADD PRIMARY KEY (`UUID`);

ALTER TABLE `dog_licenses`
  ADD PRIMARY KEY (`UUID`);

ALTER TABLE `dog_users`
  ADD PRIMARY KEY (`UUID`);

ALTER TABLE `license_codes`
  ADD PRIMARY KEY (`UUID`);

ALTER TABLE `reports`
  ADD PRIMARY KEY (`UUID`);

ALTER TABLE `roles`
  ADD PRIMARY KEY (`UUID`);

ALTER TABLE `users`
  ADD PRIMARY KEY (`UUID`);

ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`UUID`);