

    
    -- INSTALLER VERSION V.1.9.180525
    
    SET foreign_key_checks = 0;
    
    DROP TABLE IF EXISTS tmp_installLog;
    CREATE TEMPORARY TABLE IF NOT EXISTS tmp_installLog (objectName VARCHAR(500),message VARCHAR(2000)) ENGINE=MyISAM;
    
    
    
    
    


DROP procedure IF EXISTS `sysApplicationModulInstaller`;
DROP procedure IF EXISTS `sysCheckDependency`;

  
-- sys OBJECT TO CREATE

        




	
	DROP TABLE IF EXISTS `contact`;
    CREATE TABLE IF NOT EXISTS `contact` (                
`contact_id` mediumint(8) unsigned NOT NULL  auto_increment,                
`title` varchar(10) NULL DEFAULT NULL ,                
`first_name` varchar(100) NOT NULL  ,                
`last_name` varchar(100) NOT NULL  ,                
`tel` varchar(100) NULL DEFAULT NULL ,                
`fax` varchar(100) NULL DEFAULT NULL ,                
`webpage` varchar(200) NULL DEFAULT NULL ,                
`note` text NULL DEFAULT NULL ,                
`country_id` smallint(6) unsigned NULL DEFAULT NULL ,                
`address_id` mediumint(8) unsigned NULL DEFAULT NULL ,                
`uuid` char(36) NULL DEFAULT NULL ,                
`updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
, PRIMARY KEY (`contact_id`),                
KEY `fk_contact_address_id_idx` (`address_id`),                
KEY `fk_contact_country_id_idx` (`country_id`),                
KEY `ix_contact_uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO tmp_installLog (objectName,message) VALUES('contact','Table created');

    
    
	
			DROP trigger IF EXISTS `contact_BEFORE_INSERT`;
DELIMITER $$
CREATE DEFINER=CURRENT_USER TRIGGER `contact_BEFORE_INSERT` BEFORE INSERT on `contact` for each row 
BEGIN
	SET new.uuid = ifnull(new.uuid,uuid());
END$$
	DELIMITER ;
	
	INSERT INTO tmp_installLog (objectName,message) VALUES('contact','Trigger created');
	
	
			DROP trigger IF EXISTS `contact_after_update`;
DELIMITER $$
CREATE DEFINER=CURRENT_USER TRIGGER `contact_after_update` AFTER UPDATE on `contact` for each row 
BEGIN
	INSERT INTO audit_contact (`contact_id`,`title`,`first_name`,`last_name`,`note`,`country_id`,`address_id`,`uuid`,`updated`,updated_by,`action_type`)VALUES(old.contact_id,old.title,old.first_name,old.last_name,old.note,old.country_id,old.address_id,old.uuid,old.updated,IFNULL(@applicationSessionUser,CURRENT_USER()),'updated');
END$$
	DELIMITER ;
	
	INSERT INTO tmp_installLog (objectName,message) VALUES('contact','Trigger created');
	
	
			DROP trigger IF EXISTS `contact_after_delete`;
DELIMITER $$
CREATE DEFINER=CURRENT_USER TRIGGER `contact_after_delete` AFTER DELETE on `contact` for each row 
BEGIN
    INSERT INTO audit_contact (`contact_id`,`title`,`first_name`,`last_name`,`note`,`country_id`,`address_id`,`uuid`,`updated`,updated_by,`action_type`)VALUES(old.contact_id,old.title,old.first_name,old.last_name,old.note,old.country_id,old.address_id,old.uuid,old.updated,IFNULL(@applicationSessionUser,CURRENT_USER()),'deleted');
END$$
	DELIMITER ;
	
	INSERT INTO tmp_installLog (objectName,message) VALUES('contact','Trigger created');
	
	
    
    
	
	DROP TABLE IF EXISTS `contact_email`;
    CREATE TABLE IF NOT EXISTS `contact_email` (                
`contact_id` mediumint(9) unsigned NOT NULL  ,                
`email` varchar(200) NOT NULL  ,                
`status` enum('primary','secondary','inactive','blacklisted') NOT NULL DEFAULT 'primary' ,                
`uuid` varchar(36) NULL DEFAULT NULL ,                
`last_review_date` timestamp NULL DEFAULT NULL ,                
`updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
, PRIMARY KEY (`contact_id`,`email`),                
KEY `ix_contact_email_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO tmp_installLog (objectName,message) VALUES('contact_email','Table created');

    
    
	
			DROP trigger IF EXISTS `contact_email_BEFORE_INSERT`;
DELIMITER $$
CREATE DEFINER=CURRENT_USER TRIGGER `contact_email_BEFORE_INSERT` BEFORE INSERT on `contact_email` for each row 
BEGIN
	SET new.uuid = ifnull(new.uuid,uuid());
END$$
	DELIMITER ;
	
	INSERT INTO tmp_installLog (objectName,message) VALUES('contact_email','Trigger created');
	
	
			DROP trigger IF EXISTS `contact_email_after_update`;
DELIMITER $$
CREATE DEFINER=CURRENT_USER TRIGGER `contact_email_after_update` AFTER UPDATE on `contact_email` for each row 
BEGIN
	INSERT INTO audit_contact_email (`contact_id`,`email`,`status`,`updated`,updated_by,`action_type`)VALUES(old.contact_id,old.email,old.status,old.updated,IFNULL(@applicationSessionUser,CURRENT_USER()),'updated');
END$$
	DELIMITER ;
	
	INSERT INTO tmp_installLog (objectName,message) VALUES('contact_email','Trigger created');
	
	
			DROP trigger IF EXISTS `contact_email_after_delete`;
DELIMITER $$
CREATE DEFINER=CURRENT_USER TRIGGER `contact_email_after_delete` AFTER DELETE on `contact_email` for each row 
BEGIN
    INSERT INTO audit_contact_email (`contact_id`,`email`,`status`,`updated`,updated_by,`action_type`)VALUES(old.contact_id,old.email,old.status,old.updated,IFNULL(@applicationSessionUser,CURRENT_USER()),'deleted');
END$$
	DELIMITER ;
	
	INSERT INTO tmp_installLog (objectName,message) VALUES('contact_email','Trigger created');
	
	
    
    
	
	DROP TABLE IF EXISTS `contact_in_organisation`;
    CREATE TABLE IF NOT EXISTS `contact_in_organisation` (                
`contact_in_organisation_id` mediumint(8) unsigned NOT NULL  auto_increment,                
`contact_id` mediumint(9) unsigned NOT NULL  ,                
`organisation_id` mediumint(9) unsigned NOT NULL  ,                
`valid_from` date NULL DEFAULT NULL ,                
`valid_to` date NULL DEFAULT NULL ,                
`updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
, PRIMARY KEY (`contact_in_organisation_id`),                
KEY `fk_contact_in_organisation_contact_id_idx` (`contact_id`),                
KEY `fk_contact_in_organisation_organisation_id` (`organisation_id`),                
UNIQUE KEY `uqix_contact_in_organisation_unique_index` (`contact_id`,`organisation_id`,`valid_from`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO tmp_installLog (objectName,message) VALUES('contact_in_organisation','Table created');

    
    
	
			DROP trigger IF EXISTS `contact_in_organisation_after_update`;
DELIMITER $$
CREATE DEFINER=CURRENT_USER TRIGGER `contact_in_organisation_after_update` AFTER UPDATE on `contact_in_organisation` for each row 
BEGIN
	INSERT INTO audit_contact_in_organisation (`contact_id`,`organisation_id`,`valid_from`,`valid_to`,`updated`,updated_by,`action_type`)VALUES(old.contact_id,old.organisation_id,old.valid_from,old.valid_to,old.updated,IFNULL(@applicationSessionUser,CURRENT_USER()),'updated');
END$$
	DELIMITER ;
	
	INSERT INTO tmp_installLog (objectName,message) VALUES('contact_in_organisation','Trigger created');
	
	
			DROP trigger IF EXISTS `contact_in_organisation_after_delete`;
DELIMITER $$
CREATE DEFINER=CURRENT_USER TRIGGER `contact_in_organisation_after_delete` AFTER DELETE on `contact_in_organisation` for each row 
BEGIN
    INSERT INTO audit_contact_in_organisation (`contact_id`,`organisation_id`,`valid_from`,`valid_to`,`updated`,updated_by,`action_type`)VALUES(old.contact_id,old.organisation_id,old.valid_from,old.valid_to,old.updated,IFNULL(@applicationSessionUser,CURRENT_USER()),'deleted');
END$$
	DELIMITER ;
	
	INSERT INTO tmp_installLog (objectName,message) VALUES('contact_in_organisation','Trigger created');
	
	
    
    
	
	DROP TABLE IF EXISTS `contact_email_address`;
    CREATE TABLE IF NOT EXISTS `contact_email_address` (                
`contact_email_address_id` int(10) unsigned NOT NULL  auto_increment,                
`name` varchar(1024) NULL DEFAULT NULL ,                
`email` varchar(1024) NOT NULL  ,                
`updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
, PRIMARY KEY (`contact_email_address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO tmp_installLog (objectName,message) VALUES('contact_email_address','Table created');

    
    
	
    
    
	
	DROP TABLE IF EXISTS `contact_email_header`;
    CREATE TABLE IF NOT EXISTS `contact_email_header` (                
`contact_email_header_id` int(11) unsigned NOT NULL  auto_increment,                
`eml_file` varchar(1024) NOT NULL  ,                
`date` datetime NULL DEFAULT NULL ,                
`subject` varchar(1024) NOT NULL  ,                
`message_id` varchar(1024) NULL DEFAULT NULL ,                
`in_reply_to` varchar(1024) NULL DEFAULT NULL ,                
`references` varchar(1024) NULL DEFAULT NULL ,                
`mail_date` datetime NULL DEFAULT NULL ,                
`size` int(11) NULL DEFAULT NULL ,                
`user_agent` varchar(1024) NULL DEFAULT NULL ,                
`content_type` varchar(64) NULL DEFAULT NULL ,                
`content_language` varchar(8) NULL DEFAULT NULL ,                
`has_attachment` tinyint(1) NULL DEFAULT NULL ,                
`status` enum('new','indexing','finished') NOT NULL DEFAULT 'new' ,                
`error` text NULL DEFAULT NULL ,                
`updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
, PRIMARY KEY (`contact_email_header_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO tmp_installLog (objectName,message) VALUES('contact_email_header','Table created');

    
    
	
    
    
	
	DROP TABLE IF EXISTS `contact_in_email_address_header`;
    CREATE TABLE IF NOT EXISTS `contact_in_email_address_header` (                
`contact_email_header_id` int(11) unsigned NOT NULL  ,                
`contact_email_address_id` int(10) unsigned NOT NULL  ,                
`role` enum('from','to','cc','reply_to','sender','delivered_to') NOT NULL  ,                
`updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
, PRIMARY KEY (`contact_email_header_id`,`contact_email_address_id`,`role`),                
KEY `fk_contact_email_address_id_idx` (`contact_email_address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO tmp_installLog (objectName,message) VALUES('contact_in_email_address_header','Table created');

    
    
	
    
    
	
	DROP TABLE IF EXISTS `contact_imap_last_sync`;
    CREATE TABLE IF NOT EXISTS `contact_imap_last_sync` (                
`imap_id` int(10) unsigned NOT NULL  ,                
`last_sync_date` date NOT NULL DEFAULT '2016-01-01' ,                
`updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
, PRIMARY KEY (`imap_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO tmp_installLog (objectName,message) VALUES('contact_imap_last_sync','Table created');

    
    
	
    
    
	
	DROP procedure IF EXISTS `wrk_contactCreateTempTable`;
DELIMITER $$
CREATE DEFINER=CURRENT_USER PROCEDURE `wrk_contactCreateTempTable`(
		type enum('analyze','process','tags'),
		dropTempTableFirst bit(1),
		returnResult tinyint(4),
		dropAllLocallyCreatedTempTable tinyint(4),
		debugMode tinyint(4),
		rollbackIt tinyint(4),
		inDepth tinyint(4)
	)
	BEGIN
	DECLARE var VARCHAR(100) DEFAULT '';
	DECLARE errorMsg VARCHAR(4000) DEFAULT '';
    DECLARE customErrorMsg VARCHAR(200) DEFAULT '';
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
		-- IF ZERO LEVEL THEN ROLLBACK
		IF IFNULL(inDepth,0) = 0
		THEN
			ROLLBACK;
        END IF;
		-- CALL IT FOR FORMATTED PARAMETERS TO errorMsg
			-- SELECT deployment.sysReturnIncomingParametersString(DATABASE(),'wrk_contactCreateTempTable','PROCEDURE')
		SET errorMsg = 'FILL_IT_BY_FUNCT_ABOVE';
        
		SET @errorMsg = CONCAT('
        ERROR (SQL) happened in stored procedure [wrk_contactCreateTempTable] on depth ',@depthLevel,'! Params:
        ',errorMsg,'
        ',IFNULL(@errorMsg,''));
        
        IF NOT debugMode AND @depthLevel = 0
        THEN
			-- tmp_log WITH NO RESTRICTIONS OF NUMBER OF ROWS ARE AVAILABLE IN sysErrorHandler
			DROP TEMPORARY TABLE IF EXISTS tmp_log;
			CREATE TEMPORARY TABLE tmp_log (id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY, col_name VARCHAR(200), col_value TEXT)
			ENGINE=MyISAM DEFAULT CHARSET=utf8;
            
            INSERT INTO tmp_log (col_name,col_value)
            VALUES
            ('error_msg',@errorMsg),
            ('cur_user',CURRENT_USER())
            ;
            IF EXISTS
            (
				SELECT 1 FROM information_schema.ROUTINES rout
				WHERE rout.ROUTINE_SCHEMA = DATABASE() AND ROUTINE_NAME = 'sysErrorHandler'
            )
            THEN
				CALL sysErrorHandler('error_log');
			END IF;
            
            DROP TEMPORARY TABLE IF EXISTS tmp_log;
        END IF;
        
        SET @depthLevel = GREATEST(@depthLevel - 1, 0);
        -- DROP TEMP TABLES
		DROP TEMPORARY TABLE IF EXISTS tmp_toRename;
        
        RESIGNAL;
    END;
       
    -- SET AND CHECK DEPTH
		-- NO DEPTH LEVEL SET YET
    IF IFNULL(inDepth,0) = 0
    THEN
		-- IF CALLED ON ZERO LEVEL START TRAN
        START TRANSACTION;
        
		SET @depthLevel = 0;
        -- DEL ERRORMSG
        SET @errorMsg = '';
		-- THE SP CALLED FROM ANOTHER SP
    ELSEIF inDepth = 1
    THEN
		SET @depthLevel = @depthLevel + 1;
    END If;
        
    -- CHECK INCOMING PARAMS
    IF (1=2)
    THEN
		-- entity not found
        SIGNAL SQLSTATE '02000'
        SET MESSAGE_TEXT = 'entity not found';
    END IF;
    IF (1=2)
    THEN
		-- unhandled user-defined exception
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'unhandled user-defined exception';
    END IF;
    IF (1=2)
    THEN
		-- permission denied
        SIGNAL SQLSTATE '45001'
        SET MESSAGE_TEXT = 'permission denied';
    END IF;
    IF (1=2)
    THEN
		-- operation not allowed
        SIGNAL SQLSTATE '45002'
        SET MESSAGE_TEXT = 'operation not allowed';
    END IF;
    IF (1=2)
    THEN
		-- validation error
        SIGNAL SQLSTATE '45003'
        SET MESSAGE_TEXT = 'validation error';
    END IF;
    IF (1=2)
    THEN
		-- not implemented
        SIGNAL SQLSTATE '45100'
        SET MESSAGE_TEXT = 'not implemented';
    END IF;
    
    -- TEMP TABLE IF NEEDED
    DROP TEMPORARY TABLE IF EXISTS tmp_toRename;
    CREATE TEMPORARY TABLE tmp_toRename (id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY)
    ENGINE=MyISAM DEFAULT CHARSET=utf8;    
    
    -- 													@TODO LIST
    /*
		
    */
    
    -- 													BODY WORKING AREA
    
        
    IF type = 'analyze'
    THEN
		IF dropTempTableFirst IS TRUE THEN DROP TEMPORARY TABLE IF EXISTS tmp_contact_import_landing_zone; END IF;
		CREATE TEMPORARY TABLE IF NOT EXISTS `tmp_contact_import_landing_zone` (
		  `landing_zone_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
          `original_row` TINYINT(1) DEFAULT 1,
		  `status_type` varchar(50) DEFAULT NULL,
		  `status_msg` varchar(500) DEFAULT NULL,
		  `conflict_email` varchar(500) DEFAULT NULL,
		  `conflict_contact_id` mediumint(9) DEFAULT NULL,
		  `conflict_landing_zone_id` mediumint(9) DEFAULT NULL,
		  `conflict_additional_information` varchar(100) DEFAULT NULL,
		  `further_action` varchar(45) DEFAULT NULL,
		  `contact_id` mediumint(9) DEFAULT NULL,
		  `title` varchar(10) DEFAULT NULL,
		  `first_name` varchar(100) DEFAULT NULL,
		  `last_name` varchar(100) DEFAULT NULL,
          `tel` varchar(100) DEFAULT NULL,
		  `fax` varchar(100) DEFAULT NULL,
		  `webpage` varchar(200) DEFAULT NULL,
		  `email_primary` varchar(300) DEFAULT NULL,
		  `email_secondary` varchar(300) DEFAULT NULL,
		  `email_blacklisted` varchar(300) DEFAULT NULL,
		  `email_inactive` varchar(300) DEFAULT NULL,
		  `note` text DEFAULT NULL,
		  `country` varchar(45) DEFAULT NULL,
		  `organisation` varchar(150) DEFAULT NULL,
		  `address_locality` varchar(255) DEFAULT NULL,
		  `address_region` varchar(100) DEFAULT NULL,
		  `address_post_box` varchar(45) DEFAULT NULL,
		  `address_postal_code` varchar(10) DEFAULT NULL,
		  `address_street_name` varchar(100) DEFAULT NULL,
		  `address_street_type` varchar(45) DEFAULT NULL,
		  `address_street_number` varchar(10) DEFAULT NULL,
		  `address_building` varchar(10) DEFAULT NULL,
		  `address_staircase` varchar(5) DEFAULT NULL,
		  `address_door` varchar(5) DEFAULT NULL,
		  `address_floor` varchar(5) DEFAULT NULL,
		  PRIMARY KEY (`landing_zone_id`)
		) ENGINE=MyISAM DEFAULT CHARSET=utf8;
    ELSEIF type = 'process'
    THEN
		IF dropTempTableFirst IS TRUE THEN DROP TEMPORARY TABLE IF EXISTS tmp_contact_import_landing_zone; END IF;
		CREATE TEMPORARY TABLE IF NOT EXISTS `tmp_contact_import_landing_zone` (
		  `landing_zone_id` int(11) unsigned NOT NULL,
          `original_row` TINYINT(1) DEFAULT 1,
		  `status_type` varchar(50) DEFAULT NULL,
		  `status_msg` varchar(500) DEFAULT NULL,
		  `conflict_email` varchar(500) DEFAULT NULL,
		  `conflict_contact_id` mediumint(9) DEFAULT NULL,
		  `conflict_landing_zone_id` mediumint(9) DEFAULT NULL,
		  `conflict_additional_information` varchar(100) DEFAULT NULL,
		  `further_action` varchar(45) DEFAULT NULL,
		  `contact_id` mediumint(9) DEFAULT NULL,
		  `title` varchar(10) DEFAULT NULL,
		  `first_name` varchar(100) DEFAULT NULL,
		  `last_name` varchar(100) DEFAULT NULL,
          `tel` varchar(100) DEFAULT NULL,
		  `fax` varchar(100) DEFAULT NULL,
		  `webpage` varchar(200) DEFAULT NULL,
		  `email_primary` varchar(300) DEFAULT NULL,
		  `email_secondary` varchar(300) DEFAULT NULL,
		  `email_blacklisted` varchar(300) DEFAULT NULL,
		  `email_inactive` varchar(300) DEFAULT NULL,
		  `note` text DEFAULT NULL,
		  `country` varchar(45) DEFAULT NULL,
		  `organisation` varchar(150) DEFAULT NULL,
		  `address_locality` varchar(255) DEFAULT NULL,
		  `address_region` varchar(100) DEFAULT NULL,
		  `address_post_box` varchar(45) DEFAULT NULL,
		  `address_postal_code` varchar(10) DEFAULT NULL,
		  `address_street_name` varchar(100) DEFAULT NULL,
		  `address_street_type` varchar(45) DEFAULT NULL,
		  `address_street_number` varchar(10) DEFAULT NULL,
		  `address_building` varchar(10) DEFAULT NULL,
		  `address_staircase` varchar(5) DEFAULT NULL,
		  `address_door` varchar(5) DEFAULT NULL,
		  `address_floor` varchar(5) DEFAULT NULL
          
		) ENGINE=MyISAM DEFAULT CHARSET=utf8;
	ELSEIF type = 'tags'
    THEN
		IF dropTempTableFirst IS TRUE THEN DROP TEMPORARY TABLE IF EXISTS tmp_tag; END IF;
        CREATE TEMPORARY TABLE IF NOT EXISTS tmp_tag (tag_name VARCHAR(200)) ENGINE=MyISAM DEFAULT CHARSET=utf8;
	END IF; 
    
    -- RETURN RESULT
    IF returnResult = 1
    THEN
		SELECT * FROM tmp_toRename;
	END IF;
	
    -- DROP TEMP TABLE THAT IS NOT LOCALLY CREATED
    
    -- DROP LOCAL TEMP TABLES
    IF dropAllLocallyCreatedTempTable = 1
    THEN
		DROP TEMPORARY TABLE IF EXISTS tmp_toRename;
    END IF;
    -- SP RETURNS UP / FINISH -> SET depthLevel -= 1
    IF @depthLevel != 0
    THEN
		SET @depthLevel = @depthLevel - 1;
    END IF;
    IF IFNULL(inDepth,0) = 0
    THEN
		-- COMMIT TRAN
        IF rollbackIt != 1
        THEN
			COMMIT;
		ELSE
			ROLLBACK;
		END IF;
    END IF;
END$$
	DELIMITER ;
	
	INSERT INTO tmp_installLog (objectName,message) VALUES('wrk_contactCreateTempTable','Procedure created');
	
	;
	
	DROP procedure IF EXISTS `wrk_contactSynchronisation`;
DELIMITER $$
CREATE DEFINER=CURRENT_USER PROCEDURE `wrk_contactSynchronisation`(
		returnResult tinyint(4),
		dropAllLocallyCreatedTempTable tinyint(4),
		debugMode tinyint(4),
		rollbackIt tinyint(4),
		inDepth tinyint(4)
	)
	BEGIN
	DECLARE var VARCHAR(100) DEFAULT '';
	DECLARE errorMsg VARCHAR(4000) DEFAULT '';
    DECLARE customErrorMsg VARCHAR(200) DEFAULT '';
    DECLARE synchronisationType ENUM('insert_only', 'update_completely', 'update_value_only', 'insert_and_check_differencies');
    DECLARE baseSource ENUM('external', 'internal');
    DECLARE done BIT DEFAULT FALSE;
    DECLARE landingZoneID MEDIUMINT;
    DECLARE originalRow TINYINT(1);
    DECLARE statusType VARCHAR(50) DEFAULT NULL;
    DECLARE statusMsg VARCHAR(500) DEFAULT NULL;
    DECLARE conflictEmail VARCHAR(500) DEFAULT NULL;
    DECLARE	conflictContactID MEDIUMINT(9) DEFAULT NULL;
    DECLARE	conflictLandingZoneID MEDIUMINT(9) DEFAULT NULL;
    DECLARE conflictAdditionalInformation VARCHAR(100) DEFAULT NULL;
    DECLARE furtherAction VARCHAR(45) DEFAULT NULL;
	DECLARE	contactID MEDIUMINT(9) DEFAULT NULL;
	DECLARE	myTitle VARCHAR(10) DEFAULT NULL;
	DECLARE	firstName VARCHAR(100) DEFAULT NULL;
	DECLARE	lastName VARCHAR(100) DEFAULT NULL;
	DECLARE	emailPrimary VARCHAR(300) DEFAULT NULL;    
    DECLARE	myTel VARCHAR(100) DEFAULT NULL;
	DECLARE	myFax VARCHAR(100) DEFAULT NULL;
	DECLARE	myWebpage VARCHAR(200) DEFAULT NULL;    
	DECLARE	emailSecondary VARCHAR(300) DEFAULT NULL;
	DECLARE	emailBlacklisted VARCHAR(300) DEFAULT NULL;
	DECLARE	emailInactive VARCHAR(300) DEFAULT NULL;
	DECLARE	myNote text DEFAULT NULL;
	DECLARE	myCountry VARCHAR(45) DEFAULT NULL;
	DECLARE	myOrganisation VARCHAR(150) DEFAULT NULL;
	DECLARE	addressLocality VARCHAR(255) DEFAULT NULL;
	DECLARE	addressRegion VARCHAR(100) DEFAULT NULL;
	DECLARE	addressPostBox VARCHAR(45) DEFAULT NULL;
	DECLARE	addressPostalCode VARCHAR(10) DEFAULT NULL;
	DECLARE	addressStreetName VARCHAR(100) DEFAULT NULL;
	DECLARE	addressStreetType VARCHAR(45) DEFAULT NULL;
	DECLARE	addressStreetNumber VARCHAR(10) DEFAULT NULL;
	DECLARE	addressBuilding VARCHAR(10) DEFAULT NULL;
	DECLARE	addressStaircase VARCHAR(5) DEFAULT NULL;
	DECLARE addressDoor VARCHAR(5) DEFAULT NULL;
	DECLARE addressFloor VARCHAR(5) DEFAULT NULL;
    DECLARE tagName VARCHAR(200) DEFAULT NULL;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
		-- IF ZERO LEVEL THEN ROLLBACK
		IF IFNULL(inDepth,0) = 0
		THEN
			ROLLBACK;
        END IF;
		-- CALL IT FOR FORMATTED PARAMETERS TO errorMsg
			-- SELECT deployment.sysReturnIncomingParametersString(DATABASE(),'wrk_contactSynchronisation','PROCEDURE')
		SET errorMsg = 'FILL_IT_BY_FUNCT_ABOVE';
        
		SET @errorMsg = CONCAT('
        ERROR (SQL) happened in stored procedure [wrk_contactSynchronisation] on depth ',@depthLevel,'! Params:
        ',errorMsg,'
        ',IFNULL(@errorMsg,''));
        
        IF NOT debugMode AND @depthLevel = 0
        THEN
			-- tmp_log WITH NO RESTRICTIONS OF NUMBER OF ROWS ARE AVAILABLE IN sysErrorHandler
			DROP TEMPORARY TABLE IF EXISTS tmp_log;
			CREATE TEMPORARY TABLE tmp_log (id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY, col_name VARCHAR(200), col_value TEXT)
			ENGINE=MyISAM DEFAULT CHARSET=utf8;
            
            INSERT INTO tmp_log (col_name,col_value)
            VALUES
            ('error_msg',@errorMsg),
            ('cur_user',CURRENT_USER())
            ;
            IF EXISTS
            (
				SELECT 1 FROM information_schema.ROUTINES rout
				WHERE rout.ROUTINE_SCHEMA = DATABASE() AND ROUTINE_NAME = 'sysErrorHandler'
            )
            THEN
				CALL sysErrorHandler('error_log');
			END IF;
            
            DROP TEMPORARY TABLE IF EXISTS tmp_log;
        END IF;
        
        SET @depthLevel = GREATEST(@depthLevel - 1, 0);
        -- DROP TEMP TABLES
		DROP TEMPORARY TABLE IF EXISTS tmp_toRename;
        
        RESIGNAL;
    END;
       
    -- SET AND CHECK DEPTH
		-- NO DEPTH LEVEL SET YET
    IF IFNULL(inDepth,0) = 0
    THEN
		-- IF CALLED ON ZERO LEVEL START TRAN
        START TRANSACTION;
        
		SET @depthLevel = 0;
        -- DEL ERRORMSG
        SET @errorMsg = '';
		-- THE SP CALLED FROM ANOTHER SP
    ELSEIF inDepth = 1
    THEN
		SET @depthLevel = @depthLevel + 1;
    END If;
        
    -- CHECK INCOMING PARAMS
    IF (1=2)
    THEN
		-- entity not found
        SIGNAL SQLSTATE '02000'
        SET MESSAGE_TEXT = 'entity not found';
    END IF;
    IF (1=2)
    THEN
		-- unhandled user-defined exception
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'unhandled user-defined exception';
    END IF;
    IF (1=2)
    THEN
		-- permission denied
        SIGNAL SQLSTATE '45001'
        SET MESSAGE_TEXT = 'permission denied';
    END IF;
    IF (1=2)
    THEN
		-- operation not allowed
        SIGNAL SQLSTATE '45002'
        SET MESSAGE_TEXT = 'operation not allowed';
    END IF;
    IF (1=2)
    THEN
		-- validation error
        SIGNAL SQLSTATE '45003'
        SET MESSAGE_TEXT = 'validation error';
    END IF;
    IF (1=2)
    THEN
		-- not implemented
        SIGNAL SQLSTATE '45100'
        SET MESSAGE_TEXT = 'not implemented';
    END IF;
    -- TEMP TABLE IF NEEDED
    
    DROP TEMPORARY TABLE IF EXISTS tmp_contact_to_be_tagged;
    CREATE TEMPORARY TABLE tmp_contact_to_be_tagged (contact_id MEDIUMINT)
    ENGINE=MyISAM DEFAULT CHARSET=utf8;
    
    DROP TEMPORARY TABLE IF EXISTS tmp_all_email_to_check;
    CREATE TEMPORARY TABLE tmp_all_email_to_check (landing_zone_id INT, email VARCHAR(400), status VARCHAR(50))
    ENGINE=MyISAM DEFAULT CHARSET=utf8;

    DROP TEMPORARY TABLE IF EXISTS tmp_contact_import_landing_zone_container;
    CREATE TEMPORARY TABLE tmp_contact_import_landing_zone_container ENGINE=MyISAM AS
    (
		SELECT * FROM tmp_contact_import_landing_zone WHERE 1 = 2
	);
    
    -- DROP TEMPORARY TABLE IF EXISTS tmp_tag;
    -- IF TAGS EXISTS TEMP TABLE BELOW IS CREATED OUTSIDE OF THIS SP
    CREATE TEMPORARY TABLE IF NOT EXISTS tmp_tag (tag_name VARCHAR(200));
        
    DROP TEMPORARY TABLE IF EXISTS tmp_numbers;
    CREATE TEMPORARY TABLE tmp_numbers (n INT) ENGINE=MyISAM;
    INSERT INTO tmp_numbers (n)
    VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),(16),(17),(18),(19),(20),(21),(22),(23),(24),(25);
	
    DROP TEMPORARY TABLE IF EXISTS tmp_contact;
    CREATE TEMPORARY TABLE tmp_contact (contact_id MEDIUMINT) ENGINE=MyISAM;
    
    DROP TEMPORARY TABLE IF EXISTS tmp_retry_entity;
    CREATE TEMPORARY TABLE tmp_retry_entity (landing_zone_id MEDIUMINT) ENGINE=MyISAM;
    
    -- 													@TODO LIST
    /*
		
    */
    
    -- 													BODY WORKING AREA
    

    -- ALL INCOMING EMAIL TO CHECK
    INSERT INTO tmp_all_email_to_check (landing_zone_id,email,status)
    SELECT DISTINCT lz.landing_zone_id, SUBSTRING_INDEX(SUBSTRING_INDEX(lz.email_primary, ',', tn.n), ',', -1) as email, 'primary'
	FROM tmp_numbers tn
	INNER JOIN tmp_contact_import_landing_zone lz ON CHAR_LENGTH(lz.email_primary) - CHAR_LENGTH(REPLACE(lz.email_primary, ',', '')) >= tn.n - 1
    WHERE IFNULL(lz.email_primary,'') != '' AND lz.original_row = 1
	;
    
    INSERT INTO tmp_all_email_to_check (landing_zone_id,email,status)
    SELECT DISTINCT lz.landing_zone_id, SUBSTRING_INDEX(SUBSTRING_INDEX(lz.email_secondary, ',', tn.n), ',', -1) as email, 'secondary'
	FROM tmp_numbers tn
	INNER JOIN tmp_contact_import_landing_zone lz ON CHAR_LENGTH(lz.email_secondary) - CHAR_LENGTH(REPLACE(lz.email_secondary, ',', '')) >= tn.n - 1
    WHERE IFNULL(lz.email_secondary,'') != '' AND lz.original_row = 1
	;
    INSERT INTO tmp_all_email_to_check (landing_zone_id,email,status)
    SELECT DISTINCT lz.landing_zone_id, SUBSTRING_INDEX(SUBSTRING_INDEX(lz.email_blacklisted, ',', tn.n), ',', -1) as email, 'blacklisted'
	FROM tmp_numbers tn
	INNER JOIN tmp_contact_import_landing_zone lz ON CHAR_LENGTH(lz.email_blacklisted) - CHAR_LENGTH(REPLACE(lz.email_blacklisted, ',', '')) >= tn.n - 1
    WHERE IFNULL(lz.email_blacklisted,'') != '' AND lz.original_row = 1
	;
    INSERT INTO tmp_all_email_to_check (landing_zone_id,email,status)
    SELECT DISTINCT lz.landing_zone_id, SUBSTRING_INDEX(SUBSTRING_INDEX(lz.email_inactive, ',', tn.n), ',', -1) as email, 'inactive'
	FROM tmp_numbers tn
	INNER JOIN tmp_contact_import_landing_zone lz ON CHAR_LENGTH(lz.email_inactive) - CHAR_LENGTH(REPLACE(lz.email_inactive, ',', '')) >= tn.n - 1
    WHERE IFNULL(lz.email_inactive,'') != '' AND lz.original_row = 1
	;

    -- DUPLICATE EMAIL ADDRESS IN ONE ROW
    INSERT INTO tmp_contact_import_landing_zone_container
    SELECT
	t.landing_zone_id,
    1,
	'1 - Ignored',
    'Duplicate email address in contact!',
    '',
    '',
    '',
    '',
	'',
	t.contact_id,
	t.title,
	t.first_name,
	t.last_name,
    t.tel,
    t.fax,
    t.webpage,
	t.email_primary,
	t.email_secondary,
	t.email_blacklisted,
	t.email_inactive,
	t.note,
	t.country,
	t.organisation,
	t.address_locality,
	t.address_region,
	t.address_post_box,
	t.address_postal_code,
	t.address_street_name,
	t.address_street_type,
	t.address_street_number,
	t.address_building,
	t.address_staircase,
	t.address_door,
	t.address_floor
	FROM tmp_contact_import_landing_zone t
    INNER JOIN tmp_all_email_to_check c ON c.landing_zone_id = t.landing_zone_id
    WHERE t.further_action IN ('update','insert')
    GROUP BY c.landing_zone_id,c.email
    HAVING COUNT(1) > 1
    ;




/***************************/




/******************************/


	BEGIN
		DECLARE cur CURSOR FOR
		SELECT 
		REPLACE(LTRIM(RTRIM(t.landing_zone_id)),'	',' '),
        t.original_row,
		REPLACE(LTRIM(RTRIM(t.status_type)),'	',' '),
        REPLACE(LTRIM(RTRIM(t.status_msg)),'	',' '),
        REPLACE(LTRIM(RTRIM(t.conflict_email)),'	',' '),
        REPLACE(LTRIM(RTRIM(t.conflict_contact_id)),'	',' '),
        REPLACE(LTRIM(RTRIM(t.conflict_landing_zone_id)),'	',' '),
        REPLACE(LTRIM(RTRIM(t.conflict_additional_information)),'	',' '),
        REPLACE(LTRIM(RTRIM(t.further_action)),'	',' '),
		REPLACE(LTRIM(RTRIM(t.contact_id)),'	',' '),
		REPLACE(LTRIM(RTRIM(t.title)),'	',' '),
		REPLACE(LTRIM(RTRIM(t.first_name)),'	',' '),
		REPLACE(LTRIM(RTRIM(t.last_name)),'	',' '),
        REPLACE(LTRIM(RTRIM(t.tel)),'	',' '),
		REPLACE(LTRIM(RTRIM(t.fax)),'	',' '),
		REPLACE(LTRIM(RTRIM(t.webpage)),'	',' '),
		REPLACE(LTRIM(RTRIM(t.email_primary)),'	',' '),
		REPLACE(LTRIM(RTRIM(t.email_secondary)),'	',' '),
		REPLACE(LTRIM(RTRIM(t.email_blacklisted)),'	',' '),
		REPLACE(LTRIM(RTRIM(t.email_inactive)),'	',' '),
		REPLACE(LTRIM(RTRIM(t.note)),'	',' '),
		REPLACE(LTRIM(RTRIM(t.country)),'	',' '),
		REPLACE(LTRIM(RTRIM(t.organisation)),'	',' '),
		REPLACE(LTRIM(RTRIM(t.address_locality)),'	',' '),
		REPLACE(LTRIM(RTRIM(t.address_region)),'	',' '),
		REPLACE(LTRIM(RTRIM(t.address_post_box)),'	',' '),
		REPLACE(LTRIM(RTRIM(t.address_postal_code)),'	',' '),
		REPLACE(LTRIM(RTRIM(t.address_street_name)),'	',' '),
		REPLACE(LTRIM(RTRIM(t.address_street_type)),'	',' '),
		REPLACE(LTRIM(RTRIM(t.address_street_number)),'	',' '),
		REPLACE(LTRIM(RTRIM(t.address_building)),'	',' '),
		REPLACE(LTRIM(RTRIM(t.address_staircase)),'	',' '),
		REPLACE(LTRIM(RTRIM(t.address_door)),'	',' '),
		REPLACE(LTRIM(RTRIM(t.address_floor)),'	',' ')
		FROM tmp_contact_import_landing_zone t
        WHERE t.landing_zone_id NOT IN (SELECT tc.landing_zone_id FROM tmp_contact_import_landing_zone_container tc) AND
			t.further_action IN ('retry','update','insert','delete')
        ORDER BY t.landing_zone_id ASC;
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;		
		OPEN cur;    
		read_loop: LOOP
		FETCH cur INTO
		landingZoneID,
        originalRow,
        statusType,
        statusMsg,
        conflictEmail,
        conflictContactID,
        conflictLandingZoneID,
        conflictAdditionalInformation,
        furtherAction,
		contactID,
		myTitle,
		firstName,
		lastName,
        myTel,
        myFax,
        myWebpage,
		emailPrimary,
		emailSecondary,
		emailBlacklisted,
		emailInactive,
		myNote,
		myCountry,
		myOrganisation,
		addressLocality,
		addressRegion,
		addressPostBox,
		addressPostalCode,
		addressStreetName,
		addressStreetType,
		addressStreetNumber,
		addressBuilding,
		addressStaircase,
		addressDoor,
		addressFloor;

		IF done THEN
			LEAVE read_loop;
		END IF;

/*************************************/

/*************************************/
        /*
        OPTIONS:
        (A) 1 - Ignored -> retry/ignore
        (B) 2 - Conflict (from excel: conflict_landing_zone_id = 0 && conflict_contact_id = 0) -> insert/ignore
        (C) 2 - Conflict (from database: conflict_contact_id > 0) -> ignore/delete/update
        (D) 3 - Insert -> insert/ignore
        (E) 4 - Update -> update/ignore
        
        */
        
        -- OPTION A (retry/ignore)
        IF statusType = '1 - Ignored'
        THEN
			-- @TODO CALL sel_contactSynchronisationCheck
			IF furtherAction = 'retry'
            THEN
				INSERT INTO tmp_retry_entity (landing_zone_id) VALUES(landingZoneID);
			-- DO NOTHING
			ELSEIF furtherAction = 'ignore'
            THEN
				SET @fake = 1;
			END IF;
		END IF;

        -- OPTION B (insert/ignore)
        IF statusType = '2 - Conflict' AND conflictLandingZoneID = 0 AND conflictContactID = 0
        THEN
			IF furtherAction = 'insert'
            THEN
                SET @country_id = (SELECT gc.country_id FROM geography_country gc WHERE gc.name = LTRIM(RTRIM(myCountry)));
				IF IFNULL(myCountry,'') != ''
				THEN
					SET @outcomeMsg = IF (@country_id IS NULL,CONCAT('Missing: country (',myCountry,'); '),'');
				END IF;
							
				SET @address_id = NULL;
				IF IFNULL(addressLocality,'') != ''
				THEN
					INSERT INTO address (locality,region,post_box,postal_code,street_name,street_type,
						street_number,building,staircase,door,floor)
					SELECT addressLocality,addressRegion,addressPostBox,addressPostalCode,
						addressStreetName,(CASE WHEN addressStreetType = '' THEN NULL ELSE addressStreetType END),addressStreetNumber,addressBuilding,addressStaircase,addressDoor,addressFloor
					;
					SET @address_id = LAST_INSERT_ID();
				END IF;                  
				
				INSERT INTO contact (title,first_name,last_name,note,country_id,address_id,tel,fax,webpage)
				SELECT myTitle,firstName,lastName,myNote,@country_id,@address_id,myTel,myFax,myWebpage;
				SET @contact_id = LAST_INSERT_ID();
				
				INSERT INTO contact_email (email,contact_id,status)
				SELECT e.email,@contact_id,e.status FROM tmp_all_email_to_check e WHERE e.landing_zone_id = landingZoneID;
				
				SET @organisation_id = (SELECT o.organisation_id FROM organisation o WHERE o.name = LTRIM(RTRIM(myOrganisation)));
				IF IFNULL(myOrganisation,'') != ''
				THEN
					SET @outcomeMsg = CONCAT(@outcomeMsg,IF (@organisation_id IS NULL,CONCAT('New organisation (',myOrganisation,') registered; '),''));
					
					IF @organisation_id IS NOT NULL
					THEN
						INSERT INTO contact_in_organisation (contact_id,organisation_id,valid_from)
						VALUES(@contact_id,@organisation_id,NOW());
					ELSE
						INSERT INTO organisation (name) VALUES (LTRIM(RTRIM(myOrganisation)));
						INSERT INTO contact_in_organisation (contact_id,organisation_id,valid_from)
						VALUES(@contact_id,LAST_INSERT_ID(),NOW());
					END IF;
				END IF;
				INSERT INTO tmp_contact_to_be_tagged (contact_id) VALUES(@contact_id);
			-- DO NOTHING
			ELSEIF furtherAction = 'ignore'
            THEN
				SET @fake = 1;
			END IF;
		END IF;
        
        -- OPTION C (ignore/delete/update)
        IF statusType = '2 - Conflict' AND conflictContactID > 0
        THEN
			IF furtherAction = 'update'
            THEN
				SET @country_id = (SELECT gc.country_id FROM geography_country gc WHERE gc.name = LTRIM(RTRIM(myCountry)));
				IF IFNULL(myCountry,'') != ''
				THEN
					SET @outcomeMsg = IF (@country_id IS NULL,CONCAT('Missing: country (',myCountry,'); '),'');
				END IF;
				
                SET @organisation_id = (SELECT o.organisation_id FROM organisation o WHERE o.name = LTRIM(RTRIM(myOrganisation)));
				IF IFNULL(myOrganisation,'') != ''
				THEN
					SET @outcomeMsg = CONCAT(@outcomeMsg,IF (@organisation_id IS NULL,CONCAT('New organisation (',myOrganisation,') registered; '),''));
					IF @organisation_id IS NULL
					THEN				
						INSERT INTO organisation (name) VALUES (LTRIM(RTRIM(myOrganisation)));
						SET @organisation_id = LAST_INSERT_ID();
					END IF;
					UPDATE contact_in_organisation cio
					SET cio.valid_to = NOW()
					WHERE cio.contact_id = contactID AND cio.valid_to IS NULL
					;
					INSERT INTO contact_in_organisation (contact_id,organisation_id,valid_from)
					VALUES(contactID,@organisation_id,NOW());
				END IF;
                
                -- NO address_id
				SET @address_id = (SELECT address_id FROM contact WHERE contact_id = contactID);

				IF @address_id IS NULL
				THEN
					IF IFNULL(addressLocality,'') != ''
					THEN
						INSERT INTO address (locality,region,post_box,postal_code,street_name,street_type,
							street_number,building,staircase,door,floor)
						SELECT addressLocality,addressRegion,addressPostBox,addressPostalCode,
							addressStreetName,(CASE WHEN addressStreetType = '' THEN NULL ELSE addressStreetType END),addressStreetNumber,addressBuilding,addressStaircase,addressDoor,addressFloor
						;
						SET @address_id = LAST_INSERT_ID();
					END IF;
				ELSE
					SET @addressStreetTypeID = 
                    (
						CASE
						WHEN EXISTS (SELECT 1 FROM geography_street_type WHERE street_type = addressStreetType)
							THEN addressStreetType
						ELSE NULL
						END
                    );
					UPDATE address
                    SET locality = IF (IFNULL(addressLocality,'') = '', locality, addressLocality)
                    ,region = IF (IFNULL(addressRegion,'') = '', region, addressRegion)
                    ,post_box = IF (IFNULL(addressPostBox,'') = '', post_box, addressPostBox)
                    ,postal_code = IF (IFNULL(addressPostalCode,'') = '', postal_code, addressPostalCode)
                    ,street_name = IF (IFNULL(addressStreetName,'') = '', street_name, addressStreetName)
                    ,street_type = IF (@addressStreetTypeID IS NULL, street_type, addressStreetType)
                    ,street_number = IF (IFNULL(addressStreetNumber,'') = '', street_number, addressStreetNumber)
                    ,building = IF (IFNULL(addressBuilding,'') = '', building, addressBuilding)
                    ,staircase = IF (IFNULL(addressStaircase,'') = '', staircase, addressStaircase)
                    ,door = IF (IFNULL(addressDoor,'') = '', door, addressDoor)
                    ,floor = IF (IFNULL(addressFloor,'') = '', floor, addressFloor)          
                    WHERE address_id = @address_id
                    ;
				END IF;
                
                -- UPDATE PREVIOUS MAILS TO INACTIVE
				UPDATE contact_email ce
				SET ce.status = 'inactive'
				WHERE ce.contact_id = contactID AND ce.email NOT IN
				(
					SELECT e.email FROM tmp_all_email_to_check e WHERE e.landing_zone_id = landingZoneID
				)
				;
		  
				-- INSERT / UPDATE EXCEL MAILS
				INSERT INTO contact_email (email,contact_id,status)
				SELECT e.email,contactID,e.status
                FROM tmp_all_email_to_check e
                WHERE e.landing_zone_id = landingZoneID
					ON DUPLICATE KEY UPDATE status = e.status
				;
		   
				UPDATE contact c
				SET
				c.title = IF(IFNULL(myTitle,'') != '',myTitle,c.title),
				c.first_name = IF(IFNULL(firstName,'') != '',firstName,c.first_name),
				c.last_name = IF(IFNULL(lastName,'') != '',lastName,c.last_name),
				c.note = IF(IFNULL(myNote,'') != '', myNote, c.note),
				c.country_id = @country_id,
				c.address_id = @addAddress,
                c.tel = IF(IFNULL(myTel,'') != '',myTel,c.tel),
                c.fax = IF(IFNULL(myFax,'') != '',myFax,c.fax),
                c.webpage = IF(IFNULL(myWebpage,'') != '',myWebpage,c.webpage)
				WHERE c.contact_id = contactID
				;
				
				INSERT INTO tmp_contact_to_be_tagged (contact_id) VALUES(contactID);
			
            ELSEIF furtherAction = 'delete'
            THEN    
                select 'TODO';
			-- DO NOTHING
			ELSEIF furtherAction = 'ignore'
            THEN
				SET @fake = 1;
			END IF;
		END IF;
        
        -- OPTION D (insert/ignore)
        IF statusType = '3 - Insert'
        THEN
			IF furtherAction = 'insert'
            THEN
				SET @country_id = (SELECT gc.country_id FROM geography_country gc WHERE gc.name = LTRIM(RTRIM(myCountry)));
				IF IFNULL(myCountry,'') != ''
				THEN
					SET @outcomeMsg = IF (@country_id IS NULL,CONCAT('Missing: country (',myCountry,'); '),'');
				END IF;
							
				SET @address_id = NULL;
				IF IFNULL(addressLocality,'') != ''
				THEN
					INSERT INTO address (locality,region,post_box,postal_code,street_name,street_type,
						street_number,building,staircase,door,floor)
					SELECT addressLocality,addressRegion,addressPostBox,addressPostalCode,
						addressStreetName,(CASE WHEN addressStreetType = '' THEN NULL ELSE addressStreetType END),addressStreetNumber,addressBuilding,addressStaircase,addressDoor,addressFloor
					;
					SET @address_id = LAST_INSERT_ID();
				END IF;                  
				
				INSERT INTO contact (title,first_name,last_name,note,country_id,address_id,tel,fax,webpage)
				SELECT myTitle,firstName,lastName,myNote,@country_id,@address_id,myTel,myFax,myWebpage;
				SET @contact_id = LAST_INSERT_ID();
				
                -- @TODO emails
				INSERT INTO contact_email (email,contact_id,status)
				SELECT e.email,@contact_id,e.status FROM tmp_all_email_to_check e WHERE e.landing_zone_id = landingZoneID;
				
				SET @organisation_id = (SELECT o.organisation_id FROM organisation o WHERE o.name = LTRIM(RTRIM(myOrganisation)));
				IF IFNULL(myOrganisation,'') != ''
				THEN
					SET @outcomeMsg = CONCAT(@outcomeMsg,IF (@organisation_id IS NULL,CONCAT('New organisation (',myOrganisation,') registered; '),''));
					
					IF @organisation_id IS NOT NULL
					THEN
						INSERT INTO contact_in_organisation (contact_id,organisation_id,valid_from)
						VALUES(@contact_id,@organisation_id,NOW());
					ELSE
						INSERT INTO organisation (name) VALUES (LTRIM(RTRIM(myOrganisation)));
						INSERT INTO contact_in_organisation (contact_id,organisation_id,valid_from)
						VALUES(@contact_id,LAST_INSERT_ID(),NOW());
					END IF;
				END IF;
                INSERT INTO tmp_contact_to_be_tagged (contact_id) VALUES(@contact_id);
			-- DO NOTHING
			ELSEIF furtherAction = 'ignore'
            THEN
				SET @fake = 1;
			END IF;
		END IF;
        
         -- OPTION E (update/ignore/retry)
        IF statusType = '4 - Update'
        THEN
			IF furtherAction = 'update'
            THEN
				SET @country_id = (SELECT gc.country_id FROM geography_country gc WHERE gc.name = LTRIM(RTRIM(myCountry)));
				IF IFNULL(myCountry,'') != ''
				THEN
					SET @outcomeMsg = IF (@country_id IS NULL,CONCAT('Missing: country (',myCountry,'); '),'');
				END IF;
				
                SET @organisation_id = (SELECT o.organisation_id FROM organisation o WHERE o.name = LTRIM(RTRIM(myOrganisation)));
				IF IFNULL(myOrganisation,'') != ''
				THEN
					SET @outcomeMsg = CONCAT(@outcomeMsg,IF (@organisation_id IS NULL,CONCAT('New organisation (',myOrganisation,') registered; '),''));
					IF @organisation_id IS NULL
					THEN				
						INSERT INTO organisation (name) VALUES (LTRIM(RTRIM(myOrganisation)));
						SET @organisation_id = LAST_INSERT_ID();
					END IF;
					UPDATE contact_in_organisation cio
					SET cio.valid_to = NOW()
					WHERE cio.contact_id = contactID AND cio.valid_to IS NULL
					;
					INSERT INTO contact_in_organisation (contact_id,organisation_id,valid_from)
					VALUES(contactID,@organisation_id,NOW());
				END IF;
                
                -- NO address_id
				SET @address_id = (SELECT address_id FROM contact WHERE contact_id = contactID);
				IF @address_id IS NULL
				THEN
					IF IFNULL(addressLocality,'') != ''
					THEN
						INSERT INTO address (locality,region,post_box,postal_code,street_name,street_type,
							street_number,building,staircase,door,floor)
						SELECT addressLocality,addressRegion,addressPostBox,addressPostalCode,
							addressStreetName,(CASE WHEN addressStreetType = '' THEN NULL ELSE addressStreetType END),addressStreetNumber,addressBuilding,addressStaircase,addressDoor,addressFloor
						;
						SET @address_id = LAST_INSERT_ID();
					END IF;
				ELSE
					SET @addressStreetTypeID = 
                    (
						CASE
						WHEN EXISTS (SELECT 1 FROM geography_street_type WHERE street_type = addressStreetType)
							THEN addressStreetType
						ELSE NULL
						END
                    );
					UPDATE address
                    SET locality = IF (IFNULL(addressLocality,'') = '', locality, addressLocality)
                    ,region = IF (IFNULL(addressRegion,'') = '', region, addressRegion)
                    ,post_box = IF (IFNULL(addressPostBox,'') = '', post_box, addressPostBox)
                    ,postal_code = IF (IFNULL(addressPostalCode,'') = '', postal_code, addressPostalCode)
                    ,street_name = IF (IFNULL(addressStreetName,'') = '', street_name, addressStreetName)
                    ,street_type = IF (@addressStreetTypeID IS NULL, street_type, addressStreetType)
                    ,street_number = IF (IFNULL(addressStreetNumber,'') = '', street_number, addressStreetNumber)
                    ,building = IF (IFNULL(addressBuilding,'') = '', building, addressBuilding)
                    ,staircase = IF (IFNULL(addressStaircase,'') = '', staircase, addressStaircase)
                    ,door = IF (IFNULL(addressDoor,'') = '', door, addressDoor)
                    ,floor = IF (IFNULL(addressFloor,'') = '', floor, addressFloor)    
                    WHERE address_id = @address_id
                    ;
				END IF;
                
                -- UPDATE PREVIOUS MAILS TO INACTIVE
				UPDATE contact_email ce
				SET ce.status = 'inactive'
				WHERE ce.contact_id = contactID AND ce.email NOT IN
				(
					SELECT e.email FROM tmp_all_email_to_check e WHERE e.landing_zone_id = landingZoneID
				)
				;
		  
				-- INSERT / UPDATE EXCEL MAILS
				INSERT INTO contact_email (email,contact_id,status)
				SELECT e.email,contactID,e.status
                FROM tmp_all_email_to_check e
                WHERE e.landing_zone_id = landingZoneID
					ON DUPLICATE KEY UPDATE status = e.status
				;
		   
				UPDATE contact c
				SET
				c.title = IF(IFNULL(myTitle,'') != '',myTitle,c.title),
				c.first_name = IF(IFNULL(firstName,'') != '',firstName,c.first_name),
				c.last_name = IF(IFNULL(lastName,'') != '',lastName,c.last_name),
				c.note = IF(IFNULL(myNote,'') != '', myNote, c.note),
				c.country_id = @country_id,
				c.address_id = @address_id,
                c.tel = IF(IFNULL(myTel,'') != '',myTel,c.tel),
                c.fax = IF(IFNULL(myFax,'') != '',myFax,c.fax),
                c.webpage = IF(IFNULL(myWebpage,'') != '',myWebpage,c.webpage)
				WHERE c.contact_id = contactID
				;
				
				INSERT INTO tmp_contact_to_be_tagged (contact_id) VALUES(contactID);
			ELSEIF furtherAction = 'retry'
            THEN
				INSERT INTO tmp_retry_entity (landing_zone_id) VALUES(landingZoneID);
			-- DO NOTHING
			ELSEIF furtherAction = 'ignore'
            THEN
				SET @fake = 1;
			END IF;
		END IF;
        
		END LOOP;
		CLOSE cur;
	END;
    
    -- HANDLE TAGS
    SET done = FALSE;
    BEGIN			
		DECLARE cur CURSOR FOR
			SELECT t.tag_name FROM tmp_tag t;
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;		
		OPEN cur;    
		read_loop: LOOP
			FETCH cur INTO tagName;

			IF done THEN
				LEAVE read_loop;
			END IF;
            
            SET @tagID = (SELECT t.tag_id FROM tag_content t WHERE t.label = tagName);
            IF @tagID IS NULL
            THEN
				INSERT INTO tag (tag_id) VALUES (NULL);
                SET @tagID = LAST_INSERT_ID();
                
                UPDATE tag_content t SET t.label = tagName
                WHERE t.tag_id = @tagID AND t.alpha_3 = 'eng'
                ;                
            END IF;
            -- ADD TAG WHOM UPDATED OR INSERTED
            -- CONTACT TAG
            INSERT INTO tag_in_master (tag_id,master_uuid,table_name)
            SELECT @tagID,c.uuid,'contact'
            FROM contact c
            INNER JOIN tmp_contact_to_be_tagged tbt ON tbt.contact_id = c.contact_id
            WHERE NOT EXISTS
            (
				SELECT 1 FROM tag_in_master tim WHERE tim.tag_id = @tagID AND tim.master_uuid = c.uuid
            )
            ;
            -- CONTACT MAIL TAG
            INSERT INTO tag_in_master (tag_id,master_uuid,table_name)
            SELECT @tagID,ce.uuid,'contact_email'
            FROM contact c
            INNER JOIN contact_email ce on ce.contact_id = c.contact_id
            INNER JOIN tmp_contact_to_be_tagged tbt ON tbt.contact_id = c.contact_id
            WHERE NOT EXISTS
            (
				SELECT 1 FROM tag_in_master tim WHERE tim.tag_id = @tagID AND tim.master_uuid = ce.uuid
            )
            ;
			
            
		END LOOP;
		CLOSE cur;
	END;
    
    -- RETURN RESULT
    IF returnResult = 1
    THEN
		-- HANDLE RETRY ENTITIES tmp_retry_entity
		-- FILL tmp_contact_import_landing_zone AGAIN
        DROP TEMPORARY TABLE IF EXISTS tmp_contact_import_landing_zone_retry_entity;
        CREATE TEMPORARY TABLE tmp_contact_import_landing_zone_retry_entity ENGINE=MyISAM AS
        (
			SELECT lz.* FROM tmp_contact_import_landing_zone lz
            INNER JOIN tmp_retry_entity re on re.landing_zone_id = lz.landing_zone_id AND lz.further_action = 'retry'
        );

		CALL wrk_contactCreateTempTable('analyze', TRUE, 0, 0, debugMode,rollbackIt, 1);
		INSERT INTO tmp_contact_import_landing_zone SELECT * FROM tmp_contact_import_landing_zone_retry_entity;
        DROP TEMPORARY TABLE IF EXISTS tmp_contact_import_landing_zone_retry_entity;
    
        CALL sel_contactSynchronisationCheck(1, 0, debugMode,1);
	END IF;
	
    -- DROP TEMP TABLE THAT IS NOT LOCALLY CREATED
    
    -- DROP LOCAL TEMP TABLES 
    IF dropAllLocallyCreatedTempTable = 1
    THEN
		DROP TEMPORARY TABLE IF EXISTS tmp_email;
        DROP TEMPORARY TABLE IF EXISTS tmp_numbers;
        DROP TEMPORARY TABLE IF EXISTS tmp_all_email_to_check;
		DROP TEMPORARY TABLE IF EXISTS tmp_contact;
        DROP TEMPORARY TABLE IF EXISTS tmp_contact_import_landing_zone_conflict;
        DROP TEMPORARY TABLE IF EXISTS tmp_tag;
        DROP TEMPORARY TABLE IF EXISTS tmp_contact_to_be_tagged;
        DROP TEMPORARY TABLE IF EXISTS tmp_retry_entity;
    END IF;
    -- SP RETURNS UP / FINISH -> SET depthLevel -= 1
    IF @depthLevel != 0
    THEN
		SET @depthLevel = @depthLevel - 1;
    END IF;
    IF IFNULL(inDepth,0) = 0
    THEN
		-- COMMIT TRAN
        IF rollbackIt != 1
        THEN
			COMMIT;
		ELSE
			ROLLBACK;
		END IF;
    END IF;
END$$
	DELIMITER ;
	
	INSERT INTO tmp_installLog (objectName,message) VALUES('wrk_contactSynchronisation','Procedure created');
	
	;
	
	DROP procedure IF EXISTS `sel_contactSynchronisationCheck`;
DELIMITER $$
CREATE DEFINER=CURRENT_USER PROCEDURE `sel_contactSynchronisationCheck`(
		returnResult tinyint(4),
		dropAllLocallyCreatedTempTable tinyint(4),
		debugMode tinyint(4),
		inDepth tinyint(4)
	)
	BEGIN
	DECLARE var VARCHAR(100) DEFAULT '';
	DECLARE errorMsg VARCHAR(4000) DEFAULT '';
    DECLARE customErrorMsg VARCHAR(200) DEFAULT '';
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		-- CALL IT FOR FORMATTED PARAMETERS TO errorMsg
			-- SELECT deployment.sysReturnIncomingParametersString(DATABASE(),'sel_contactSynchronisationCheck','PROCEDURE')
		SET errorMsg = 'FILL_IT_BY_FUNCT_ABOVE';
        
		SET @errorMsg = CONCAT('
        ERROR (SQL) happened in stored procedure [sel_contactSynchronisationCheck] on depth ',@depthLevel,'! Params:
        ',errorMsg,'
        ',IFNULL(@errorMsg,''));
        
        IF NOT debugMode AND @depthLevel = 0
        THEN
			-- tmp_log WITH NO RESTRICTIONS OF NUMBER OF ROWS ARE AVAILABLE IN sysErrorHandler
			DROP TEMPORARY TABLE IF EXISTS tmp_log;
			CREATE TEMPORARY TABLE tmp_log (id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY, col_name VARCHAR(200), col_value TEXT)
			ENGINE=MyISAM DEFAULT CHARSET=utf8;
            
            INSERT INTO tmp_log (col_name,col_value)
            VALUES
            ('error_msg',@errorMsg),
            ('cur_user',CURRENT_USER())
            ;
            IF EXISTS
            (
				SELECT 1 FROM information_schema.ROUTINES rout
				WHERE rout.ROUTINE_SCHEMA = DATABASE() AND ROUTINE_NAME = 'sysErrorHandler'
            )
            THEN
				CALL sysErrorHandler('error_log');
			END IF;
            
            DROP TEMPORARY TABLE IF EXISTS tmp_log;
        END IF;
        
        SET @depthLevel = GREATEST(@depthLevel - 1, 0);
        -- DROP TEMP TABLES
		DROP TEMPORARY TABLE IF EXISTS tmp_toRename;
        
        RESIGNAL;
    END;
    -- SET AND CHECK DEPTH
		-- NO DEPTH LEVEL SET YET
    IF IFNULL(inDepth,0) = 0
    THEN
		SET @depthLevel = 0;
        -- DEL ERRORMSG
        SET @errorMsg = '';
		-- THE SP CALLED FROM ANOTHER SP
    ELSEIF inDepth = 1
    THEN
		SET @depthLevel = @depthLevel + 1;
    END If;
        
    -- CHECK INCOMING PARAMS
    IF (1=2)
    THEN
		-- entity not found
        SIGNAL SQLSTATE '02000'
        SET MESSAGE_TEXT = 'entity not found';
    END IF;
    IF (1=2)
    THEN
		-- unhandled user-defined exception
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'unhandled user-defined exception';
    END IF;
    IF (1=2)
    THEN
		-- permission denied
        SIGNAL SQLSTATE '45001'
        SET MESSAGE_TEXT = 'permission denied';
    END IF;
    IF (1=2)
    THEN
		-- operation not allowed
        SIGNAL SQLSTATE '45002'
        SET MESSAGE_TEXT = 'operation not allowed';
    END IF;
    IF (1=2)
    THEN
		-- validation error
        SIGNAL SQLSTATE '45003'
        SET MESSAGE_TEXT = 'validation error';
    END IF;
    IF (1=2)
    THEN
		-- not implemented
        SIGNAL SQLSTATE '45100'
        SET MESSAGE_TEXT = 'not implemented';
    END IF;
    
    -- TEMP TABLE IF NEEDED
    DROP TEMPORARY TABLE IF EXISTS tmp_numbers;
    CREATE TEMPORARY TABLE tmp_numbers (n INT) ENGINE=MyISAM;
    INSERT INTO tmp_numbers (n)
    VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),(16),(17),(18),(19),(20),(21),(22),(23),(24),(25);
	
    DROP TEMPORARY TABLE IF EXISTS tmp_all_email_to_check;
    CREATE TEMPORARY TABLE tmp_all_email_to_check (landing_zone_id INT, email VARCHAR(400), status VARCHAR(50))
    ENGINE=MyISAM DEFAULT CHARSET=utf8;
    
    DROP TEMPORARY TABLE IF EXISTS tmp_contact_import_landing_zone_container;
    CREATE TEMPORARY TABLE tmp_contact_import_landing_zone_container ENGINE=MyISAM AS
    (
		SELECT * FROM tmp_contact_import_landing_zone WHERE 1 = 2
	);
    
    DROP TEMPORARY TABLE IF EXISTS tmp_existing_contact;
    CREATE TEMPORARY TABLE tmp_existing_contact (contact_id MEDIUMINT,landing_zone_id MEDIUMINT, email VARCHAR(500)) ENGINE=MyISAM;
    
    DROP TEMPORARY TABLE IF EXISTS tmp_conflicting_contact;
    CREATE TEMPORARY TABLE tmp_conflicting_contact (contact_id MEDIUMINT, landing_zone_id MEDIUMINT) ENGINE=MyISAM;
    
    DROP TEMPORARY TABLE IF EXISTS tmp_conflict_in_incoming_data;
    CREATE TEMPORARY TABLE tmp_conflict_in_incoming_data (landing_zone_id_a MEDIUMINT,landing_zone_id_b MEDIUMINT, email VARCHAR(500)) ENGINE=MyISAM;
    
    -- 													@TODO LIST
    /*
		
    */
    
    -- 													BODY WORKING AREA
    
    /*
    MANUAL:
    1 - FILL tmp_contact_import_landing_zone WITH EXCEL DATA
    2 - THIS SP RETURNS ANALIZED DATA
    3 - ANALIZED DATA EXCEL EXPORT / PROCESS AS IT IS
    4 - (EXCEL IMPORT AGAIN INTO) tmp_contact_import_landing_zone (NEEDS TO BE RECREATED WITHOUT AI AND PK !)
    5 - RUN wrk_contactSynchronisation -> PROCESS DATA AND RETURNS ANALYZED DATA ON IGNORED ENTITIES -> COULD BE RESTARTED ON 3.   
    */
    
    -- ALL INCOMING EMAIL TO CHECK
    INSERT INTO tmp_all_email_to_check (landing_zone_id,email,status)
    SELECT lz.landing_zone_id, SUBSTRING_INDEX(SUBSTRING_INDEX(lz.email_primary, ',', tn.n), ',', -1) as email, 'primary'
	FROM tmp_numbers tn
	INNER JOIN tmp_contact_import_landing_zone lz ON CHAR_LENGTH(lz.email_primary) - CHAR_LENGTH(REPLACE(lz.email_primary, ',', '')) >= tn.n - 1
    WHERE IFNULL(lz.email_primary,'') != ''
	;
    INSERT INTO tmp_all_email_to_check (landing_zone_id,email,status)
    SELECT lz.landing_zone_id, SUBSTRING_INDEX(SUBSTRING_INDEX(lz.email_secondary, ',', tn.n), ',', -1) as email, 'secondary'
	FROM tmp_numbers tn
	INNER JOIN tmp_contact_import_landing_zone lz ON CHAR_LENGTH(lz.email_secondary) - CHAR_LENGTH(REPLACE(lz.email_secondary, ',', '')) >= tn.n - 1
    WHERE IFNULL(lz.email_secondary,'') != ''
	;
    INSERT INTO tmp_all_email_to_check (landing_zone_id,email,status)
    SELECT lz.landing_zone_id, SUBSTRING_INDEX(SUBSTRING_INDEX(lz.email_blacklisted, ',', tn.n), ',', -1) as email, 'blacklisted'
	FROM tmp_numbers tn
	INNER JOIN tmp_contact_import_landing_zone lz ON CHAR_LENGTH(lz.email_blacklisted) - CHAR_LENGTH(REPLACE(lz.email_blacklisted, ',', '')) >= tn.n - 1
    WHERE IFNULL(lz.email_blacklisted,'') != ''
	;
    INSERT INTO tmp_all_email_to_check (landing_zone_id,email,status)
    SELECT lz.landing_zone_id, SUBSTRING_INDEX(SUBSTRING_INDEX(lz.email_inactive, ',', tn.n), ',', -1) as email, 'inactive'
	FROM tmp_numbers tn
	INNER JOIN tmp_contact_import_landing_zone lz ON CHAR_LENGTH(lz.email_inactive) - CHAR_LENGTH(REPLACE(lz.email_inactive, ',', '')) >= tn.n - 1
    WHERE IFNULL(lz.email_inactive,'') != ''
	;
    
    DROP TEMPORARY TABLE IF EXISTS tmp_ignored_landing_zone_id_container;
    CREATE TEMPORARY TABLE tmp_ignored_landing_zone_id_container (landing_zone_id MEDIUMINT) ENGINE=MyISAM;
    
    INSERT INTO tmp_ignored_landing_zone_id_container (landing_zone_id)
    SELECT t.landing_zone_id
    FROM tmp_contact_import_landing_zone t
    INNER JOIN tmp_all_email_to_check c ON c.landing_zone_id = t.landing_zone_id
    GROUP BY c.landing_zone_id,c.email
    HAVING COUNT(1) > 1
    ;
    
    -- DUPLICATE EMAIL ADDRESS IN ONE ROW
    INSERT INTO tmp_contact_import_landing_zone_container
    SELECT 
	t.landing_zone_id,
    1,
	'1 - Ignored',
    'Duplicate email address in contact!',
    '',
    '',
    '',
    '',
	'retry', -- retry/ignore
	t.contact_id,
	t.title,
	t.first_name,
	t.last_name,
    t.tel,
    t.fax,
    t.webpage,
	t.email_primary,
	t.email_secondary,
	t.email_blacklisted,
	t.email_inactive,
	t.note,
	t.country,
	t.organisation,
	t.address_locality,
	t.address_region,
	t.address_post_box,
	t.address_postal_code,
	t.address_street_name,
	t.address_street_type,
	t.address_street_number,
	t.address_building,
	t.address_staircase,
	t.address_door,
	t.address_floor
	FROM tmp_contact_import_landing_zone t
    INNER JOIN tmp_ignored_landing_zone_id_container c ON c.landing_zone_id = t.landing_zone_id
    ;
    
    -- DELETE IGNORED EMAILS
    DELETE FROM tmp_all_email_to_check
    WHERE landing_zone_id IN
    (
		SELECT landing_zone_id FROM tmp_ignored_landing_zone_id_container
    );
       
    DROP TEMPORARY TABLE IF EXISTS tmp_all_email_to_check_helper_1;
    CREATE TEMPORARY TABLE tmp_all_email_to_check_helper_1 ENGINE=MyISAM AS
    (
		SELECT * FROM tmp_all_email_to_check
    );
    
    -- EXISTING CONTACTS BY EMAIL (INCLUDE 1-1 (UPDATE) AND 1-n (CONFLICT) CONNCETIONS)
    INSERT INTO tmp_existing_contact (contact_id,landing_zone_id,email)
	SELECT ce.contact_id, e.landing_zone_id, GROUP_CONCAT(ce.email SEPARATOR ', ')
    FROM contact_email ce
    INNER JOIN tmp_all_email_to_check e ON e.email = ce.email AND e.status = ce.status
    GROUP BY ce.contact_id-- , e.landing_zone_id
	;

    DROP TEMPORARY TABLE IF EXISTS tmp_existing_contact_helper_1;
    CREATE TEMPORARY TABLE tmp_existing_contact_helper_1 ENGINE=MyISAM AS
    (
		SELECT * FROM tmp_existing_contact
    );

    -- CONFLICTING CONTACTS ONLY-> BY EMAIL, DATA FROM LANDING ZONE EXISTS IN MULTIPLE CONTACT
    INSERT INTO tmp_conflicting_contact (contact_id,landing_zone_id)
    SELECT DISTINCT contact_id, landing_zone_id
    FROM tmp_existing_contact 
    WHERE landing_zone_id IN
    (
		SELECT landing_zone_id
		FROM tmp_existing_contact_helper_1
		GROUP BY landing_zone_id
		HAVING COUNT(1) > 1
	);

    -- CONFLICT IN INCOMING DATA BY EMAIL
    INSERT INTO tmp_conflict_in_incoming_data (landing_zone_id_a,landing_zone_id_b, email)
    SELECT a.landing_zone_id, b.landing_zone_id, GROUP_CONCAT(a.email SEPARATOR ', ')
    FROM tmp_all_email_to_check a
    INNER JOIN tmp_all_email_to_check_helper_1 b ON b.email = a.email AND a.landing_zone_id != b.landing_zone_id
    GROUP BY a.landing_zone_id,b.landing_zone_id
    ;
 
    DROP TEMPORARY TABLE IF EXISTS tmp_all_conflict;
    CREATE TEMPORARY TABLE tmp_all_conflict ENGINE=MyISAM AS
    (
		SELECT * FROM
		(
			SELECT c.landing_zone_id,c.contact_id as existing_contact_id, NULL as new_incoming_contact,c.email
			FROM tmp_conflicting_contact conf
			INNER JOIN tmp_existing_contact c USING(landing_zone_id,contact_id)
			UNION ALL
			SELECT landing_zone_id_a,NULL, landing_zone_id_b,email
			FROM tmp_conflict_in_incoming_data
		) as sub
		ORDER BY sub.landing_zone_id
	);

    -- EACH ENTITY OF SOURCE
    INSERT INTO tmp_contact_import_landing_zone_container
    SELECT 
	t.landing_zone_id,
    1,
	'2 - Conflict',
    'Conflicts are listed below',
    '',
    '',
    '',
    '',
	'insert', -- insert/ignore
	t.contact_id,
	t.title,
	t.first_name,
	t.last_name,
    t.tel,
    t.fax,
    t.webpage,
	t.email_primary,
	t.email_secondary,
	t.email_blacklisted,
	t.email_inactive,
	t.note,
	t.country,
	t.organisation,
	t.address_locality,
	t.address_region,
	t.address_post_box,
	t.address_postal_code,
	t.address_street_name,
	t.address_street_type,
	t.address_street_number,
	t.address_building,
	t.address_staircase,
	t.address_door,
	t.address_floor
	FROM tmp_contact_import_landing_zone t
    WHERE t.landing_zone_id IN
    (
		SELECT landing_zone_id FROM tmp_all_conflict
    );
    
    -- EACH SOURCE EMAIL CONFLICT
    INSERT INTO tmp_contact_import_landing_zone_container
    SELECT 
	conf.landing_zone_id,
    0,
	'2 - Conflict',
    'Same e-mail in source',
    conf.email,
    conf.existing_contact_id,
    conf.new_incoming_contact,
    '',
	'N/A',
	t.contact_id,
	t.title,
	t.first_name,
	t.last_name,
    t.tel,
    t.fax,
    t.webpage,
	t.email_primary,
	t.email_secondary,
	t.email_blacklisted,
	t.email_inactive,
	t.note,
	t.country,
	t.organisation,
	t.address_locality,
	t.address_region,
	t.address_post_box,
	t.address_postal_code,
	t.address_street_name,
	t.address_street_type,
	t.address_street_number,
	t.address_building,
	t.address_staircase,
	t.address_door,
	t.address_floor
	FROM tmp_contact_import_landing_zone t
    INNER JOIN tmp_all_conflict conf on conf.new_incoming_contact = t.landing_zone_id
    ;

    -- EXISTING CONTACTS DATA
    INSERT INTO tmp_contact_import_landing_zone_container
	SELECT
	conf.landing_zone_id,
    0,
	'2 - Conflict',
	'Existing multiple contacts with same e-mail',
    conf.email,
    conf.existing_contact_id,
    '',
    '',
	'ignore', -- ignore/delete/update
	c.`contact_id`,
	c.`title`,
	c.`first_name`,
	c.`last_name`,
    c.tel,
    c.fax,
    c.webpage,
	GROUP_CONCAT(DISTINCT (CASE WHEN ce.status = 'primary' THEN ce.email ELSE NULL END) SEPARATOR ',') as `email_primary`,
	GROUP_CONCAT(DISTINCT (CASE WHEN ce.status = 'secondary' THEN ce.email ELSE NULL END) SEPARATOR ',') as `email_secondary`,
	GROUP_CONCAT(DISTINCT (CASE WHEN ce.status = 'blacklisted' THEN ce.email ELSE NULL END) SEPARATOR ',') as `email_blacklisted`,
	GROUP_CONCAT(DISTINCT (CASE WHEN ce.status = 'inactive' THEN ce.email ELSE NULL END) SEPARATOR ',') as `email_inactive`,
	c.`note`,
	gc.name as `country`,
	o.name as `organisation`,
	ad.locality as `address_locality`,
	ad.region as `address_region`,
	ad.post_box as `address_post_box`,
	ad.postal_code as `address_postal_code`,
	ad.street_name as `address_street_name`,
	ad.street_type as `address_street_type`,
	ad.street_number as `address_street_number`,
	ad.building as `address_building`,
	ad.staircase as `address_staircase`,
	ad.door as `address_door`,
	ad.floor as `address_floor`
	FROM tmp_all_conflict conf
    INNER JOIN contact c ON c.contact_id = conf.existing_contact_id
    INNER JOIN contact_email ce on ce.contact_id = c.contact_id
	LEFT JOIN address ad on ad.address_id = c.address_id
	LEFT JOIN geography_country gc on gc.country_id = c.country_id
	LEFT JOIN contact_in_organisation cio on cio.contact_id = c.contact_id AND cio.valid_to IS NULL
	LEFT JOIN organisation o on o.organisation_id = cio.organisation_id
	GROUP BY ce.contact_id
    -- GROUP BY conf.landing_zone_id
    -- HAVING COUNT(1) > 1
	;

    -- INSERT SIMPLE UPDATES (EXISTING 1-1 CONTACTS)
    INSERT INTO tmp_contact_import_landing_zone_container
	SELECT
	t.landing_zone_id,
    0,
	'4 - Update',
	'Existing contact details',
    '',
    '',
    '',
    '',
	'N/A',
	c.`contact_id`,
	c.`title`,
	c.`first_name`,
	c.`last_name`,
    c.tel,
    c.fax,
    c.webpage,
	GROUP_CONCAT(DISTINCT (CASE WHEN ce.status = 'primary' THEN ce.email ELSE NULL END) SEPARATOR ',') as `email_primary`,
	GROUP_CONCAT(DISTINCT (CASE WHEN ce.status = 'secondary' THEN ce.email ELSE NULL END) SEPARATOR ',') as `email_secondary`,
	GROUP_CONCAT(DISTINCT (CASE WHEN ce.status = 'blacklisted' THEN ce.email ELSE NULL END) SEPARATOR ',') as `email_blacklisted`,
	GROUP_CONCAT(DISTINCT (CASE WHEN ce.status = 'inactive' THEN ce.email ELSE NULL END) SEPARATOR ',') as `email_inactive`,
	c.`note`,
	gc.name as `country`,
	o.name as `organisation`,
	ad.locality as `address_locality`,
	ad.region as `address_region`,
	ad.post_box as `address_post_box`,
	ad.postal_code as `address_postal_code`,
	ad.street_name as `address_street_name`,
	ad.street_type as `address_street_type`,
	ad.street_number as `address_street_number`,
	ad.building as `address_building`,
	ad.staircase as `address_staircase`,
	ad.door as `address_door`,
	ad.floor as `address_floor`
	FROM tmp_contact_import_landing_zone t
    INNER JOIN tmp_all_email_to_check temail ON temail.landing_zone_id = t.landing_zone_id
    INNER JOIN tmp_existing_contact ex ON ex.landing_zone_id = t.landing_zone_id
    INNER JOIN contact c ON c.contact_id = ex.contact_id
    INNER JOIN contact_email ce on ce.contact_id = c.contact_id AND ce.status = temail.status
	LEFT JOIN address ad on ad.address_id = c.address_id
	LEFT JOIN geography_country gc on gc.country_id = c.country_id
	LEFT JOIN contact_in_organisation cio on cio.contact_id = c.contact_id AND cio.valid_to IS NULL
	LEFT JOIN organisation o on o.organisation_id = cio.organisation_id
    WHERE ex.landing_zone_id NOT IN
    (
		SELECT landing_zone_id FROM tmp_conflicting_contact
    )
	GROUP BY ce.contact_id
	;
    
    INSERT INTO tmp_contact_import_landing_zone_container
	SELECT
	t.landing_zone_id,
    1,
	'4 - Update',
	'Contact details after update',
    '',
    '',
    '',
    '',
	'update', -- update/ignore
	c.`contact_id`,
	CASE WHEN IFNULL(t.title,'') != '' THEN t.title ELSE c.`title` END,
	CASE WHEN IFNULL(t.first_name,'') != '' THEN t.first_name ELSE c.`first_name` END,
	CASE WHEN IFNULL(t.last_name,'') != '' THEN t.last_name ELSE c.`last_name` END,
    CASE WHEN IFNULL(t.tel,'') != '' THEN t.tel ELSE c.`tel` END,
    CASE WHEN IFNULL(t.fax,'') != '' THEN t.fax ELSE c.`fax` END,
    CASE WHEN IFNULL(t.webpage,'') != '' THEN t.webpage ELSE c.`webpage` END,    
	CASE WHEN IFNULL(t.email_primary,'') != '' THEN t.email_primary ELSE GROUP_CONCAT(DISTINCT (CASE WHEN ce.status = 'primary' THEN ce.email ELSE NULL END) SEPARATOR ',') END as `email_primary`,
	CASE WHEN IFNULL(t.email_secondary,'') != '' THEN t.email_secondary ELSE GROUP_CONCAT(DISTINCT (CASE WHEN ce.status = 'secondary' THEN ce.email ELSE NULL END) SEPARATOR ',') END as `email_secondary`,
	CASE WHEN IFNULL(t.email_blacklisted,'') != '' THEN t.email_blacklisted ELSE GROUP_CONCAT(DISTINCT (CASE WHEN ce.status = 'blacklisted' THEN ce.email ELSE NULL END) SEPARATOR ',') END as `email_blacklisted`,
	CASE WHEN IFNULL(t.email_inactive,'') != '' THEN t.email_inactive ELSE GROUP_CONCAT(DISTINCT (CASE WHEN ce.status = 'inactive' THEN ce.email ELSE NULL END) SEPARATOR ',') END as `email_inactive`,
	CASE WHEN IFNULL(t.note,'') != '' THEN t.note ELSE c.`note` END,
	CASE WHEN IFNULL(t.country,'') != '' THEN t.country ELSE gc.`name` END as `country`,
	CASE WHEN IFNULL(t.organisation,'') != '' THEN t.organisation ELSE o.name END as `organisation`,
	CASE WHEN IFNULL(t.address_locality,'') != '' THEN t.address_locality ELSE ad.locality END as `address_locality`,
	CASE WHEN IFNULL(t.address_region,'') != '' THEN t.address_region ELSE ad.region END as `address_region`,
	CASE WHEN IFNULL(t.address_post_box,'') != '' THEN t.address_post_box ELSE ad.post_box END as `address_post_box`,
	CASE WHEN IFNULL(t.address_postal_code,'') != '' THEN t.address_postal_code ELSE ad.postal_code END as `address_postal_code`,
	CASE WHEN IFNULL(t.address_street_name,'') != '' THEN t.address_street_name ELSE ad.street_name END as `address_street_name`,
	CASE WHEN IFNULL(t.address_street_type,'') != '' THEN t.address_street_type ELSE ad.street_type END as `address_street_type`,
	CASE WHEN IFNULL(t.address_street_number,'') != '' THEN t.address_street_number ELSE ad.street_number END as `address_street_number`,
	CASE WHEN IFNULL(t.address_building,'') != '' THEN t.address_building ELSE ad.building END as `address_building`,
	CASE WHEN IFNULL(t.address_staircase,'') != '' THEN t.address_staircase ELSE ad.staircase END as `address_staircase`,
	CASE WHEN IFNULL(t.address_door,'') != '' THEN t.address_door ELSE ad.door END as `address_door`,
	CASE WHEN IFNULL(t.address_floor,'') != '' THEN t.address_floor ELSE ad.floor END as `address_floor`
	FROM tmp_contact_import_landing_zone t
    INNER JOIN tmp_all_email_to_check temail ON temail.landing_zone_id = t.landing_zone_id
    INNER JOIN tmp_existing_contact ex ON ex.landing_zone_id = t.landing_zone_id
    INNER JOIN contact c ON c.contact_id = ex.contact_id
    INNER JOIN contact_email ce on ce.contact_id = c.contact_id AND ce.status = temail.status
	LEFT JOIN address ad on ad.address_id = c.address_id
	LEFT JOIN geography_country gc on gc.country_id = c.country_id
	LEFT JOIN contact_in_organisation cio on cio.contact_id = c.contact_id AND cio.valid_to IS NULL
	LEFT JOIN organisation o on o.organisation_id = cio.organisation_id
    WHERE ex.landing_zone_id NOT IN
    (
		SELECT landing_zone_id FROM tmp_conflicting_contact
    )
	GROUP BY ce.contact_id
    -- HAVING COUNT(1) = 1
	;
    
    
    -- SIMPLE INSERTS (EMAIL NOT FOUND IN EXISTING CONTACTS)
    DROP TEMPORARY TABLE IF EXISTS tmp_contact_import_landing_zone_container_helper_1;
    CREATE TEMPORARY TABLE tmp_contact_import_landing_zone_container_helper_1 ENGINE=MyISAM AS
    (
		SELECT * FROM tmp_contact_import_landing_zone_container
    );
    
    INSERT INTO tmp_contact_import_landing_zone_container
    SELECT 
	t.landing_zone_id,
    1,
	'3 - Insert',
    'New contact',
    '',
    '',
    '',
    '',
	'insert' AS further_action, -- insert/ignore
	t.contact_id,
	t.title,
	t.first_name,
	t.last_name,
    t.tel,
    t.fax,
    t.webpage,
	t.email_primary,
	t.email_secondary,
	t.email_blacklisted,
	t.email_inactive,
	t.note,
	t.country,
	t.organisation,
	t.address_locality,
	t.address_region,
	t.address_post_box,
	t.address_postal_code,
	t.address_street_name,
	t.address_street_type,
	t.address_street_number,
	t.address_building,
	t.address_staircase,
	t.address_door,
	t.address_floor
	FROM tmp_contact_import_landing_zone t
    WHERE t.landing_zone_id NOT IN (SELECT tc.landing_zone_id FROM tmp_contact_import_landing_zone_container_helper_1 tc)
    ;
    
    -- FILL ADDITIONAL INFORMATION -> EXISTING CONTACT CONFLICTS WITH MULTIPLE SOURCE CONTACT
    UPDATE tmp_contact_import_landing_zone_container
    SET conflict_additional_information = '(Existing contact) conflict occurs multiple times!'
    WHERE conflict_contact_id IN
    (
		SELECT conflict_contact_id
        FROM tmp_contact_import_landing_zone_container_helper_1
        WHERE IFNULL(conflict_contact_id,0) > 0
        GROUP BY conflict_contact_id
        HAVING COUNT(1) > 1
    );
    
    -- FILL ADDITIONAL INFORMATION -> SOURCE CONTACT CONFLICTS WITH MULTIPLE SOURCE CONTACT
    UPDATE tmp_contact_import_landing_zone_container
    SET conflict_additional_information = '(Source) conflict occurs multiple times!'
    WHERE conflict_landing_zone_id IN
    (
		SELECT conflict_landing_zone_id
        FROM tmp_contact_import_landing_zone_container_helper_1
        WHERE IFNULL(conflict_landing_zone_id,0) > 0
        GROUP BY conflict_landing_zone_id
        HAVING COUNT(1) > 1
    );
    
    -- RETURN RESULT
    IF returnResult = 1
    THEN
		-- FINAL SELECT
		SELECT *
		FROM tmp_contact_import_landing_zone_container
		ORDER BY status_type, landing_zone_id;
	END IF;
	
    -- DROP TEMP TABLE THAT IS NOT LOCALLY CREATED
    
    -- DROP LOCAL TEMP TABLES
    IF dropAllLocallyCreatedTempTable = 1
    THEN
		DROP TEMPORARY TABLE IF EXISTS tmp_toRename;
        DROP TEMPORARY TABLE IF EXISTS tmp_contact_helper_1;
        DROP TEMPORARY TABLE IF EXISTS tmp_all_email_to_check_helper_1;
        DROP TEMPORARY TABLE IF EXISTS tmp_all_conflict;
        DROP TEMPORARY TABLE IF EXISTS tmp_contact_import_landing_zone_container_helper_1;
        DROP TEMPORARY TABLE IF EXISTS tmp_ignored_landing_zone_id_container;
    END IF;
    -- SP RETURNS UP / FINISH -> SET depthLevel -= 1
    IF @depthLevel != 0
    THEN
		SET @depthLevel = @depthLevel - 1;
    END IF;
END$$
	DELIMITER ;
	
	INSERT INTO tmp_installLog (objectName,message) VALUES('sel_contactSynchronisationCheck','Procedure created');
	
	;
	
	DROP procedure IF EXISTS `sel_contactGetHistory`;
DELIMITER $$
CREATE DEFINER=CURRENT_USER PROCEDURE `sel_contactGetHistory`(
		contactId mediumint(8),
		skip mediumint(8),
		take mediumint(8),
		returnResult tinyint(4),
		dropAllLocallyCreatedTempTable tinyint(4),
		debugMode tinyint(4),
		inDepth tinyint(4)
	)
	BEGIN
    DECLARE var VARCHAR(100) DEFAULT '';
    DECLARE errorMsg VARCHAR(4000) DEFAULT '';
    DECLARE customErrorMsg VARCHAR(200) DEFAULT '';
    DECLARE totalCount mediumint(8) DEFAULT 0;


    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        -- CALL IT FOR FORMATTED PARAMETERS TO errorMsg
            -- SELECT deployment.sysReturnIncomingParametersString(DATABASE(),'sel_contactGetHistory','PROCEDURE')
        SET errorMsg = 'FILL_IT_BY_FUNCT_ABOVE';

        SET @errorMsg = CONCAT('
        ERROR (SQL) happened in stored procedure [sel_contactGetHistory] on depth ',@depthLevel,'! Params:
        ',errorMsg,'
        ',IFNULL(@errorMsg,''));

        IF NOT debugMode AND @depthLevel = 0
        THEN
            -- tmp_log WITH NO RESTRICTIONS OF NUMBER OF ROWS ARE AVAILABLE IN sysErrorHandler
            DROP TEMPORARY TABLE IF EXISTS tmp_log;
            CREATE TEMPORARY TABLE tmp_log (id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY, col_name VARCHAR(200), col_value TEXT)
            ENGINE=MyISAM DEFAULT CHARSET=utf8;

            INSERT INTO tmp_log (col_name,col_value)
            VALUES
            ('error_msg',@errorMsg),
            ('cur_user',CURRENT_USER())
            ;
            IF EXISTS
            (
                SELECT 1 FROM information_schema.ROUTINES rout
                WHERE rout.ROUTINE_SCHEMA = DATABASE() AND ROUTINE_NAME = 'sysErrorHandler'
            )
            THEN
                CALL sysErrorHandler('error_log');
            END IF;

            DROP TEMPORARY TABLE IF EXISTS tmp_log;
        END IF;

        SET @depthLevel = GREATEST(@depthLevel - 1, 0);
        -- DROP TEMP TABLES
        DROP TEMPORARY TABLE IF EXISTS tmp_toRename;

        RESIGNAL;
    END;
    -- SET AND CHECK DEPTH
        -- NO DEPTH LEVEL SET YET
    IF IFNULL(inDepth,0) = 0
    THEN
        SET @depthLevel = 0;
        -- DEL ERRORMSG
        SET @errorMsg = '';
        -- THE SP CALLED FROM ANOTHER SP
    ELSEIF inDepth = 1
    THEN
        SET @depthLevel = @depthLevel + 1;
    END If;

    -- CHECK INCOMING PARAMS
    IF (1=2)
    THEN
        -- entity not found
        SIGNAL SQLSTATE '02000'
        SET MESSAGE_TEXT = 'entity not found';
    END IF;
    IF (1=2)
    THEN
        -- unhandled user-defined exception
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'unhandled user-defined exception';
    END IF;
    IF (1=2)
    THEN
        -- permission denied
        SIGNAL SQLSTATE '45001'
        SET MESSAGE_TEXT = 'permission denied';
    END IF;
    IF (1=2)
    THEN
        -- operation not allowed
        SIGNAL SQLSTATE '45002'
        SET MESSAGE_TEXT = 'operation not allowed';
    END IF;
    IF (1=2)
    THEN
        -- validation error
        SIGNAL SQLSTATE '45003'
        SET MESSAGE_TEXT = 'validation error';
    END IF;
    IF (1=2)
    THEN
        -- not implemented
        SIGNAL SQLSTATE '45100'
        SET MESSAGE_TEXT = 'not implemented';
    END IF;

    -- TEMP TABLE IF NEEDED
    DROP TEMPORARY TABLE IF EXISTS tmp_toRename;
    CREATE TEMPORARY TABLE tmp_toRename (id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY)
    ENGINE=MyISAM DEFAULT CHARSET=utf8;

    --                                                     @TODO LIST
    /*

    */

    --                                                     BODY WORKING AREA

    drop temporary table if exists tmp_history;
    drop temporary table if exists tmp_email_to_history;

    create temporary table tmp_history engine=MyISAM as
    select sql_calc_found_rows
        distinct ceh.*
    FROM
        contact_email ce
        join
        contact_email_address cea using (email)
        join
        contact_in_email_address_header ceah using (contact_email_address_id)
        join
        contact_email_header ceh using (contact_email_header_id)
    where ce.contact_id = contactId
    order by ceh.mail_date desc
    limit take offset skip;


    set @totalCount = (select found_rows());

    select * from tmp_history;

    create temporary table tmp_email_to_history engine=MyISAM as
    select
        h.contact_email_header_id,
        ceah.role,
        cea.*
    from
        tmp_history h
        join
        contact_in_email_address_header ceah using (contact_email_header_id)
        join
        contact_email_address cea using (contact_email_address_id);

    select * from tmp_email_to_history where role = 'from';
    select * from tmp_email_to_history where role = 'to';
    select * from tmp_email_to_history where role = 'cc';
    select * from tmp_email_to_history where role = 'reply_to';
    select * from tmp_email_to_history where role = 'sender';
    select * from tmp_email_to_history where role = 'delivered_to';

    select @totalCount as totalCount;

    drop table if exists tmp_history;
    drop table if exists tmp_email_to_history;





    -- RETURN RESULT
    IF returnResult = 1 AND 1 = 2
    THEN
        SELECT * FROM tmp_toRename;
    END IF;

    -- DROP TEMP TABLE THAT IS NOT LOCALLY CREATED

    -- DROP LOCAL TEMP TABLES
    IF dropAllLocallyCreatedTempTable = 1
    THEN
        DROP TEMPORARY TABLE IF EXISTS tmp_toRename;
    END IF;
    -- SP RETURNS UP / FINISH -> SET depthLevel -= 1
    IF @depthLevel != 0
    THEN
        SET @depthLevel = @depthLevel - 1;
    END IF;
END$$
	DELIMITER ;
	
	INSERT INTO tmp_installLog (objectName,message) VALUES('sel_contactGetHistory','Procedure created');
	
	;
	
	DROP procedure IF EXISTS `sel_contact`;
DELIMITER $$
CREATE DEFINER=CURRENT_USER PROCEDURE `sel_contact`(
		json varchar(4000),
		returnResult tinyint(4),
		dropAllLocallyCreatedTempTable tinyint(4),
		debugMode tinyint(4),
		inDepth tinyint(4)
	)
	BEGIN
	DECLARE var VARCHAR(100) DEFAULT '';
	DECLARE errorMsg VARCHAR(4000) DEFAULT '';
    DECLARE customErrorMsg VARCHAR(200) DEFAULT '';
    
    DECLARE tagIncludeExists TINYINT DEFAULT NULL;
    DECLARE tagExcludeExists TINYINT DEFAULT NULL;
    DECLARE countryID SMALLINT DEFAULT NULL;
    DECLARE myKeyword VARCHAR(500) DEFAULT NULL;
    DECLARE searchType VARCHAR(50) DEFAULT NULL;
    DECLARE emailSearchApplied TINYINT DEFAULT NULL;
    DECLARE gatheredContactApplied TINYINT DEFAULT NULL;
    
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
		-- CALL IT FOR FORMATTED PARAMETERS TO errorMsg
			-- SELECT deployment.sysReturnIncomingParametersString(DATABASE(),'sel_contact','PROCEDURE')
		SET errorMsg = 'FILL_IT_BY_FUNCT_ABOVE';
        
		SET @errorMsg = CONCAT('
        ERROR (SQL) happened in stored procedure [sel_contact] on depth ',@depthLevel,'! Params:
        ',errorMsg,'
        ',IFNULL(@errorMsg,''));
        
        IF NOT debugMode AND @depthLevel = 0
        THEN
			-- tmp_log WITH NO RESTRICTIONS OF NUMBER OF ROWS ARE AVAILABLE IN sysErrorHandler
			DROP TEMPORARY TABLE IF EXISTS tmp_log;
			CREATE TEMPORARY TABLE tmp_log (id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY, col_name VARCHAR(200), col_value TEXT)
			ENGINE=MyISAM DEFAULT CHARSET=utf8;
            
            INSERT INTO tmp_log (col_name,col_value)
            VALUES
            ('error_msg',@errorMsg),
            ('cur_user',CURRENT_USER())
            ;
            IF EXISTS
            (
				SELECT 1 FROM information_schema.ROUTINES rout
				WHERE rout.ROUTINE_SCHEMA = DATABASE() AND ROUTINE_NAME = 'sysErrorHandler'
            )
            THEN
				CALL sysErrorHandler('error_log');
			END IF;
            
            DROP TEMPORARY TABLE IF EXISTS tmp_log;
        END IF;
        
        SET @depthLevel = GREATEST(@depthLevel - 1, 0);
        -- DROP TEMP TABLES
		DROP TEMPORARY TABLE IF EXISTS tmp_toRename;
        
        RESIGNAL;
    END;
    -- SET AND CHECK DEPTH
		-- NO DEPTH LEVEL SET YET
    IF IFNULL(inDepth,0) = 0
    THEN
		SET @depthLevel = 0;
        -- DEL ERRORMSG
        SET @errorMsg = '';
		-- THE SP CALLED FROM ANOTHER SP
    ELSEIF inDepth = 1
    THEN
		SET @depthLevel = @depthLevel + 1;
    END If;
        
    -- CHECK INCOMING PARAMS
    IF (1=2)
    THEN
		-- entity not found
        SIGNAL SQLSTATE '02000'
        SET MESSAGE_TEXT = 'entity not found';
    END IF;
    IF (1=2)
    THEN
		-- unhandled user-defined exception
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'unhandled user-defined exception';
    END IF;
    IF (1=2)
    THEN
		-- permission denied
        SIGNAL SQLSTATE '45001'
        SET MESSAGE_TEXT = 'permission denied';
    END IF;
    IF (1=2)
    THEN
		-- operation not allowed
        SIGNAL SQLSTATE '45002'
        SET MESSAGE_TEXT = 'operation not allowed';
    END IF;
    IF (1=2)
    THEN
		-- validation error
        SIGNAL SQLSTATE '45003'
        SET MESSAGE_TEXT = 'validation error';
    END IF;
    IF (1=2)
    THEN
		-- not implemented
        SIGNAL SQLSTATE '45100'
        SET MESSAGE_TEXT = 'not implemented';
    END IF;
    
    -- TEMP TABLE IF NEEDED
    DROP TEMPORARY TABLE IF EXISTS tmp_toRename;
    CREATE TEMPORARY TABLE tmp_toRename (id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY)
    ENGINE=MyISAM DEFAULT CHARSET=utf8;    
    
    -- 													@TODO LIST
    /*
		
    */
    
    -- 													BODY WORKING AREA
    
    -- GET PARAMS
		-- MULTI: tag_include,tag_exclude
        -- search_type: note,first_name,last_name,email,organisation(name),all(empty)
    SET @sqlToRun = '';
    CALL wrk_handleParameterExtended('tag_include,tag_exclude,country_id,keyword,search_type', json, 0, 1, debugMode, 0, 1);
    
	IF EXISTS
    (
		SELECT 1 FROM tmp_json_content WHERE variable_name = 'tag_include'
    )
    THEN
		SET tagIncludeExists = 1;
	END IF;
    
    IF EXISTS
    (
		SELECT 1 FROM tmp_json_content WHERE variable_name = 'tag_exclude'
    )
    THEN
		SET tagExcludeExists = 1;
	END IF;
    
    SET countryID = (SELECT variable_value FROM tmp_json_content WHERE variable_name = 'country_id');
    SET myKeyword = (SELECT variable_value FROM tmp_json_content WHERE variable_name = 'keyword');
    SET myKeyword = LTRIM(RTRIM(REPLACE(REPLACE(myKeyword,'	',' '),'  ',' ')));
    SET searchType = (SELECT variable_value FROM tmp_json_content WHERE variable_name = 'search_type');

    -- TAG
    IF tagIncludeExists = 1 OR tagExcludeExists = 1
    THEN		        
        DROP TEMPORARY TABLE IF EXISTS tmp_uuid_to_ignore;
        CREATE TEMPORARY TABLE tmp_uuid_to_ignore ENGINE=MyISAM AS
        (
			SELECT tim.master_uuid
            FROM tag_in_master tim
            INNER JOIN tmp_json_content tjc ON tjc.variable_value AND tjc.variable_name = 'tag_exclude' AND tjc.variable_value = tim.tag_id
        );
        
        SET @allIncludedTagNum = (SELECT COUNT(1) FROM tmp_json_content WHERE variable_name = 'tag_include');
        
        DROP TEMPORARY TABLE IF EXISTS tmp_tag_contact;
        IF @allIncludedTagNum = 0
        THEN
			CREATE TEMPORARY TABLE tmp_tag_contact ENGINE=MyISAM AS
			(
				SELECT c.contact_id
				FROM tag_in_master tim
				INNER JOIN contact c ON c.uuid = tim.master_uuid
				WHERE tim.master_uuid NOT IN
				(SELECT master_uuid FROM tmp_uuid_to_ignore)
			);
		ELSE
			CREATE TEMPORARY TABLE tmp_tag_contact ENGINE=MyISAM AS
			(
				SELECT c.contact_id
				FROM tag_in_master tim
				INNER JOIN tmp_json_content inc ON inc.variable_name = 'tag_include' AND inc.variable_value = tim.tag_id
				INNER JOIN contact c ON c.uuid = tim.master_uuid
				WHERE tim.master_uuid NOT IN
				(SELECT master_uuid FROM tmp_uuid_to_ignore)
				GROUP BY tim.master_uuid
				HAVING COUNT(1) = @allIncludedTagNum
			);
        END IF;
        
    END IF;
        
    -- NO KEYWORD (TAGS + COUNTRY)
    IF IFNULL(myKeyword,'') = ''
    THEN
		SET @sqlToRun =
		CONCAT(
		'
		SELECT
		c.`contact_id`,
		c.`title`,
		c.`first_name`,
		c.`last_name`,
		c.`note`,
		gc.name as `country`,
		c.`country_id`,
		o.name as `organisation`,
		o.`organisation_id`
		FROM contact c
		',CASE WHEN tagIncludeExists = 1 OR tagExcludeExists = 1 THEN 'INNER JOIN tmp_tag_contact ttc ON ttc.contact_id = c.contact_id' ELSE '' END,'
		LEFT JOIN geography_country gc on gc.country_id = c.country_id
		LEFT JOIN contact_in_organisation cio on cio.contact_id = c.contact_id
		LEFT JOIN organisation o on o.organisation_id = cio.organisation_id
		WHERE 1 = 1
		',CASE WHEN countryID IS NOT NULL THEN CONCAT(' AND gc.country_id = ',countryID) ELSE '' END		
		);
    -- KEYWORD APPLIED
    ELSE
		-- search_type: note,first_name,last_name,email,organisation(name),all(empty)
        -- SEARCH IN ALL
        IF IFNULL(searchType,'') = ''
        THEN
			-- IF EMAIL
            -- (.+)@(.+)\.(.{2,4})
            -- REGEXP '^[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$'
            IF myKeyword REGEXP '^[A-Z0-9._%-]+@[A-Z0-9.-]+.[A-Z]{2,4}$'
            THEN
                SET emailSearchApplied = 1;
			ELSE
				SET gatheredContactApplied = 1;
				-- TRY IT ON ORGANISATION
                DROP TEMPORARY TABLE IF EXISTS tmp_gathered_contact;
                CREATE TEMPORARY TABLE tmp_gathered_contact (contact_id MEDIUMINT) ENGINE=MyISAM AS
                (
					SELECT cio.contact_id
                    FROM organisation o
                    INNER JOIN contact_in_organisation cio on cio.organisation_id = o.organisation_id
                    WHERE o.name LIKE CONCAT('%',myKeyword,'%')
                );
                
                -- TRY IT ON NOTES
                INSERT INTO tmp_gathered_contact (contact_id)
                SELECT contact_id FROM contact WHERE note LIKE CONCAT('%',myKeyword,'%');
                
                -- TRY IT ON NAMES
                SET @spaceCount = CHAR_LENGTH(myKeyword) - CHAR_LENGTH(REPLACE(myKeyword,' ',''));
                IF @spaceCount = 0
                THEN
					INSERT INTO tmp_gathered_contact (contact_id)
					SELECT contact_id FROM contact WHERE first_name LIKE CONCAT('%',myKeyword,'%') OR last_name LIKE CONCAT('%',myKeyword,'%');
				ELSEIF @spaceCount = 1
                THEN
					SET @part1 = SUBSTRING_INDEX(myKeyword,' ',1);
                    SET @part2 = SUBSTRING_INDEX(myKeyword,' ',-1);
					INSERT INTO tmp_gathered_contact (contact_id)
					SELECT contact_id FROM contact
                    WHERE (first_name LIKE CONCAT('%',@part1,'%') AND last_name LIKE CONCAT('%',@part2,'%')) OR
						(first_name LIKE CONCAT('%',@part2,'%') AND last_name LIKE CONCAT('%',@part1,'%'))
                    ;
				ELSEIF @spaceCount = 2
                THEN
					-- jakab béla józsi
					-- OPTION A: FIRST WORD FIRST NAME, REST IS LAST NAME jakab - béla józsi
                    -- OPTION B: LAST WORD FIRST NAME, REST IS LAST NAME józsi - jakab béla
                    -- OPTION C: FIRST TWO WORD FIRST NAME, LAST IS LAST NAME jakab béla - józsi
                    -- OPTION D: LAST TWO FIRST NAME, FIRST LAST NAME béla józsi - jakab
                    SET @p1 = SUBSTRING_INDEX(myKeyword,' ',1);
                    SET @p2 = LTRIM(RTRIM(REPLACE(SUBSTRING_INDEX(myKeyword,' ',2),@p1,'')));
                    SET @p3 = SUBSTRING_INDEX(myKeyword,' ',-1);       
                    
					SET @partA1 = SUBSTRING_INDEX(myKeyword,' ',1);
                    SET @partA2 = SUBSTRING_INDEX(myKeyword,' ',-2);
                    SET @partB1 = SUBSTRING_INDEX(myKeyword,' ',-1);
                    SET @partB2 = SUBSTRING_INDEX(myKeyword,' ',2);
                    SET @partC1 = SUBSTRING_INDEX(myKeyword,' ',2);
                    SET @partC2 = SUBSTRING_INDEX(myKeyword,' ',-1);
                    SET @partD1 = SUBSTRING_INDEX(myKeyword,' ',-2);
                    SET @partD2 = SUBSTRING_INDEX(myKeyword,' ',1);

					INSERT INTO tmp_gathered_contact (contact_id)
					SELECT contact_id FROM contact
                    WHERE (first_name LIKE CONCAT('%',@p1,'%') AND last_name LIKE CONCAT('%',@p2,'%',@p3,'%')) OR
						(first_name LIKE CONCAT('%',@p3,'%') AND last_name LIKE CONCAT('%',@p1,'%',@p2,'%')) OR
                        (first_name LIKE CONCAT('%',@p1,'%',@p2,'%') AND last_name LIKE CONCAT('%',@p3,'%')) OR
                        (first_name LIKE CONCAT('%',@p2,'%',@p3,'%') AND last_name LIKE CONCAT('%',@p1,'%'))
                    ;
				ELSEIF @spaceCount = 3
                THEN
					-- jakab béla józsi feri
					-- OPTION A: FIRST WORD FIRST NAME, REST IS LAST NAME jakab - béla józsi feri
                    -- OPTION B: LAST WORD FIRST NAME, REST IS LAST NAME feri - jakab béla józsi
                    -- OPTION C: FIRST TWO WORD FIRST NAME, LAST TWO LAST NAME jakab béla - józsi feri
                    -- OPTION D: LAST TWO FIRST NAME, FIRST TWO LAST NAME józsi feri - jakab béla
                    SET @p1 = SUBSTRING_INDEX(myKeyword,' ',1);
                    SET @p2 = LTRIM(RTRIM(REPLACE(SUBSTRING_INDEX(myKeyword,' ',2),@p1,'')));
                    SET @p4 = SUBSTRING_INDEX(myKeyword,' ',-1);
                    SET @p3 = LTRIM(RTRIM(REPLACE(SUBSTRING_INDEX(myKeyword,' ',-2),@p4,'')));              
                    
                    INSERT INTO tmp_gathered_contact (contact_id)
					SELECT contact_id FROM contact
                    WHERE (first_name LIKE CONCAT('%',@p1,'%') AND last_name LIKE CONCAT('%',@p2,'%',@p3,'%',@p4)) OR
						(first_name LIKE CONCAT('%',@p4,'%') AND last_name LIKE CONCAT('%',@p1,'%',@p2,'%',@p3)) OR
                        (first_name LIKE CONCAT('%',@p1,'%',@p2,'%') AND last_name LIKE CONCAT('%',@p3,'%',@p4,'%')) OR
                        (first_name LIKE CONCAT('%',@p3,'%',@p4,'%') AND last_name LIKE CONCAT('%',@p1,'%',@p2,'%'))
                    ;
                    /*
					SET @partA1 = SUBSTRING_INDEX(myKeyword,' ',1);
                    SET @partA2 = SUBSTRING_INDEX(myKeyword,' ',-3);
                    SET @partB1 = SUBSTRING_INDEX(myKeyword,' ',-2);
                    SET @partB2 = SUBSTRING_INDEX(myKeyword,' ',2);
                    SET @partC1 = SUBSTRING_INDEX(myKeyword,' ',2);
                    SET @partC2 = SUBSTRING_INDEX(myKeyword,' ',-2);
                    SET @partD1 = SUBSTRING_INDEX(myKeyword,' ',-2);
                    SET @partD2 = SUBSTRING_INDEX(myKeyword,' ',2);

					INSERT INTO tmp_gathered_contact (contact_id)
					SELECT contact_id FROM contact
                    WHERE (first_name LIKE CONCAT('%',@partA1,'%') AND last_name LIKE CONCAT('%',@partA2,'%')) OR
						(first_name LIKE CONCAT('%',@partB1,'%') AND last_name LIKE CONCAT('%',@partB2,'%')) OR
                        (first_name LIKE CONCAT('%',@partC1,'%') AND last_name LIKE CONCAT('%',@partC2,'%')) OR
                        (first_name LIKE CONCAT('%',@partD1,'%') AND last_name LIKE CONCAT('%',@partD2,'%'))
                    ;*/
                END IF;
                
            END IF;
		END IF;
        
		SET @sqlToRun =
		CONCAT(
		'
		SELECT
		c.`contact_id`,
		c.`title`,
		c.`first_name`,
		c.`last_name`,
		c.`note`,
		gc.name as `country`,
		c.`country_id`,
		o.name as `organisation`,
		o.`organisation_id`
		FROM contact c
		',CASE WHEN tagIncludeExists = 1 OR tagExcludeExists = 1 THEN 'INNER JOIN tmp_tag_contact ttc ON ttc.contact_id = c.contact_id' ELSE '' END,'
		',CASE WHEN searchType = 'email' OR emailSearchApplied = 1 THEN CONCAT('INNER JOIN contact_email ce on ce.contact_id = c.contact_id AND ce.email LIKE '%',myKeyword,'%'')
		ELSE '' END, '
        ',CASE WHEN gatheredContactApplied = 1 THEN 'INNER JOIN tmp_gathered_contact tgc on tgc.contact_id = c.contact_id' ELSE '' END,'
		LEFT JOIN geography_country gc on gc.country_id = c.country_id
		LEFT JOIN contact_in_organisation cio on cio.contact_id = c.contact_id
		LEFT JOIN organisation o on o.organisation_id = cio.organisation_id
		WHERE 1 = 1
		',CASE WHEN searchType = 'organisation' THEN CONCAT(' AND o.name LIKE '%',myKeyword,'%'') ELSE '' END,'
		',CASE WHEN countryID IS NOT NULL THEN CONCAT(' AND gc.country_id = ',countryID) ELSE '' END,'
		',CASE WHEN searchType = 'first_name' THEN CONCAT(' AND c.first_name LIKE '%',myKeyword,'%'') ELSE '' END,'
		',CASE WHEN searchType = 'last_name' THEN CONCAT(' AND c.last_name LIKE '%',myKeyword,'%'') ELSE '' END,'
		',CASE WHEN searchType = 'note' THEN CONCAT(' AND c.note LIKE '%',myKeyword,'%'') ELSE '' END,'
		',CASE WHEN searchType = 'email' THEN 'GROUP BY c.contact_id' ELSE '' END,'
		'
		);
            
		
    END IF;
    

	PREPARE stmt FROM @sqlToRun;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;
    
   
    
    -- RETURN RESULT
    IF returnResult = 1
    THEN
		SELECT * FROM tmp_toRename;
	END IF;
	
    -- DROP TEMP TABLE THAT IS NOT LOCALLY CREATED
    
    -- DROP LOCAL TEMP TABLES
    IF dropAllLocallyCreatedTempTable = 1
    THEN
		DROP TEMPORARY TABLE IF EXISTS tmp_toRename;
    END IF;
    -- SP RETURNS UP / FINISH -> SET depthLevel -= 1
    IF @depthLevel != 0
    THEN
		SET @depthLevel = @depthLevel - 1;
    END IF;
END$$
	DELIMITER ;
	
	INSERT INTO tmp_installLog (objectName,message) VALUES('sel_contact','Procedure created');
	
	;

                
ALTER TABLE `contact` 
		ADD CONSTRAINT `fk_contact_address_id` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`) ON DELETE SET NULL ON UPDATE CASCADE;                
ALTER TABLE `contact` 
		ADD CONSTRAINT `fk_contact_country_id` FOREIGN KEY (`country_id`) REFERENCES `geography_country` (`country_id`) ON DELETE SET NULL ON UPDATE CASCADE;                
ALTER TABLE `contact_email` 
		ADD CONSTRAINT `fk_contact_in_email_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`contact_id`) ON DELETE CASCADE ON UPDATE CASCADE;                
ALTER TABLE `contact_in_organisation` 
		ADD CONSTRAINT `fk_contact_in_organisation_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`contact_id`) ON DELETE CASCADE ON UPDATE CASCADE;                
ALTER TABLE `contact_in_organisation` 
		ADD CONSTRAINT `fk_contact_in_organisation_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `organisation` (`organisation_id`) ON DELETE CASCADE ON UPDATE CASCADE;                
ALTER TABLE `contact_in_email_address_header` 
		ADD CONSTRAINT `fk_contact_email_address_id` FOREIGN KEY (`contact_email_address_id`) REFERENCES `contact_email_address` (`contact_email_address_id`) ON DELETE NO ACTION ON UPDATE CASCADE;                
ALTER TABLE `contact_in_email_address_header` 
		ADD CONSTRAINT `fk_contact_email_header_id` FOREIGN KEY (`contact_email_header_id`) REFERENCES `contact_email_header` (`contact_email_header_id`) ON DELETE CASCADE ON UPDATE CASCADE;                
ALTER TABLE `contact_imap_last_sync` 
		ADD CONSTRAINT `fk_imap_contact_imap_last_sync` FOREIGN KEY (`imap_id`) REFERENCES `imap` (`imap_id`) ON DELETE CASCADE ON UPDATE CASCADE;


		
		SET foreign_key_checks = 1;

		DELETE FROM application_module WHERE NAME = 'Contact';
		INSERT INTO tmp_installLog (objectName,message) VALUES('Contact','Module record delete ran on application_module table');
		INSERT INTO application_module (name, label, description, version)
		VALUES ('Contact', 'Contact', NULL,  '0.0.0.0')
		on duplicate key
			update name = values(name), description = values(description), version = values(version), label = values(label);
		INSERT INTO tmp_installLog (objectName,message) VALUES('Contact','Module record inserted into application_module table');
	







SELECT * FROM tmp_installLog;
DROP TABLE IF EXISTS tmp_installLog;
DROP TABLE IF EXISTS tmp_objectToCreateContainer;

    