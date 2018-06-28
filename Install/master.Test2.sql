
USE deployment;
DROP TABLE IF EXISTS tmp_objectToCreate;
DROP TABLE IF EXISTS tmp_dependenciesToCheck;
DROP TABLE IF EXISTS tmp_dependency;

CREATE TEMPORARY TABLE IF NOT EXISTS tmp_objectToCreate
(id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY, objectName VARCHAR(1000), objectType VARCHAR(100), dropTableIfExists CHAR(1) DEFAULT '1',createAuditTable CHAR(1) DEFAULT '0', addDummyData CHAR(1) DEFAULT '0') ENGINE=MyISAM;
CREATE TEMPORARY TABLE IF NOT EXISTS tmp_dependenciesToCheck
(id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY, objectName VARCHAR(1000), objectType VARCHAR(100),existance CHAR(1) DEFAULT '1') ENGINE=MyISAM;
CREATE TEMPORARY TABLE IF NOT EXISTS tmp_dependency
(id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY, objectName VARCHAR(1000), objectType VARCHAR(100), dependencyPassed BIT, message VARCHAR(1000)) ENGINE=MyISAM;

-- *********************************PARAMETERS TO FILL*********************************
SET @templateDataBase = 'nJinn-modules';
SET @sysModuleName = 'Contact';
SET @sysModuleLabel = 'Contact';
SET @sysModuleDescription = NULL; -- UPDATED BY COMPOSER BY THE APPROPRIATE TAG VERSION
SET @sysModuleVersion = '0.0.0.0'; -- UPDATED BY COMPOSER BY THE APPROPRIATE TAG VERSION

SET @addExtraSQLStringAtTheEndOfScriptAsItIs = '';
SET @applyModuleRelatedQueries = '1'; -- TURN OF FOR NJINN INSTALLER OR TO IMPORT TO NJINN-MODULES DB
SET @addSysErrorLogHandler = '0'; -- CREATE error_log TABLE AND ERROR LOG HANDLER STORED PROCEDURE sysErrorHandler

-- BEST POSSIBLE ORDER: TABLE-FUNCTION-PROCEDURE-VIEW

INSERT INTO tmp_objectToCreate (objectName,objectType,dropTableIfExists,createAuditTable,addDummyData) VALUES
('contact', 'TABLE', '1', '0', '1'),
('contact_email', 'TABLE', '1', '0', '1'),
('contact_in_organisation', 'TABLE', '1', '0', '1'),
('contact_email_address', 'TABLE', '1', '0', '1'),
('contact_email_header', 'TABLE', '1', '0', '1'),
('contact_in_email_address_header', 'TABLE', '1', '0', '1'),
('contact_imap_last_sync', 'TABLE', '1', '0', '1'),
('wrk_contactCreateTempTable', 'PROCEDURE','','',''),
('wrk_contactSynchronisation', 'PROCEDURE','','',''),
('sel_contactSynchronisationCheck', 'PROCEDURE','','',''),
('sel_contactGetHistory', 'PROCEDURE','','',''),
('sel_contact', 'PROCEDURE','','','')
;


-- *********************************////////////////////*********************************

CALL sysCreateInstallScript(@sysModuleName,@sysModuleLabel,@sysModuleDescription,@sysModuleVersion);
