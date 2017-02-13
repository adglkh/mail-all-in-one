-- --------------------------------------------------------------------
-- This file is part of iRedMail, which is an open source mail server
-- solution for Red Hat(R) Enterprise Linux, CentOS, Debian and Ubuntu.
--
-- iRedMail is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- iRedMail is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with iRedMail.  If not, see <http://www.gnu.org/licenses/>.
-- --------------------------------------------------------------------

--
-- Based on original postfixadmin template.
-- http://postfixadmin.sf.net
--

USE vmailadmin;

--
-- Table structure for table admin
--
CREATE TABLE IF NOT EXISTS admin (
    username VARCHAR(255) NOT NULL DEFAULT '',
    password VARCHAR(255) NOT NULL DEFAULT '',
    name VARCHAR(255) NOT NULL DEFAULT '',
    language VARCHAR(5) NOT NULL DEFAULT '',
    passwordlastchange DATETIME NOT NULL DEFAULT '1970-01-01 01:01:01',
    -- Store per-admin settings. Used in iRedAdmin-Pro.
    settings TEXT,
    created DATETIME NOT NULL DEFAULT '1970-01-01 01:01:01',
    modified DATETIME NOT NULL DEFAULT '1970-01-01 01:01:01',
    expired DATETIME NOT NULL DEFAULT '9999-12-31 00:00:00',
    active TINYINT(1) NOT NULL DEFAULT 1,
    PRIMARY KEY (username),
    INDEX (passwordlastchange),
    INDEX (expired),
    INDEX (active)
) ENGINE=InnoDB;

--
-- Table structure for table alias
--
CREATE TABLE IF NOT EXISTS alias (
    address VARCHAR(255) NOT NULL DEFAULT '',
    goto TEXT,
    name VARCHAR(255) NOT NULL DEFAULT '',
    moderators TEXT,
    accesspolicy VARCHAR(30) NOT NULL DEFAULT '',
    domain VARCHAR(255) NOT NULL DEFAULT '',
    -- Mark this record as a mail list/alias account
    islist TINYINT(1) NOT NULL DEFAULT 0,
    -- Mark this record as a per-account alias account
    is_alias TINYINT(1) NOT NULL DEFAULT 0,
    -- Required by per-account alias account (`is_alias=1`), used for indexed
    -- searching (`goto` is not good for searching). Its value must be same as
    -- `goto`.
    alias_to VARCHAR(255) NOT NULL DEFAULT '',
    created DATETIME NOT NULL DEFAULT '1970-01-01 01:01:01',
    modified DATETIME NOT NULL DEFAULT '1970-01-01 01:01:01',
    expired DATETIME NOT NULL DEFAULT '9999-12-31 00:00:00',
    active TINYINT(1) NOT NULL DEFAULT 1,
    PRIMARY KEY (address),
    INDEX (domain),
    INDEX (islist),
    INDEX (is_alias),
    INDEX (alias_to),
    INDEX (expired),
    INDEX (active)
) ENGINE=InnoDB;

--
-- Table structure for table domain
--
CREATE TABLE IF NOT EXISTS domain (
    -- mail domain name. e.g. iredmail.org.
    domain VARCHAR(255) NOT NULL DEFAULT '',
    description TEXT,
    -- Disclaimer text. Used by Amavisd + AlterMIME.
    disclaimer TEXT,
    -- Max alias accounts in this domain. e.g. 10.
    aliases INT(10) NOT NULL DEFAULT 0,
    -- Max mail accounts in this domain. e.g. 100.
    mailboxes INT(10) NOT NULL DEFAULT 0,
    -- Max mailbox quota in this domain. e.g. 1073741824 (1GB).
    maxquota BIGINT(20) NOT NULL DEFAULT 0,
    -- Not used. Historical.
    quota BIGINT(20) NOT NULL DEFAULT 0,
    -- Per-domain transport. e.g. dovecot, smtp:[192.168.1.1]:25
    transport VARCHAR(255) NOT NULL DEFAULT 'dovecot',
    backupmx TINYINT(1) NOT NULL DEFAULT 0,
    -- Store per-domain settings. Used in iRedAdmin-Pro.
    settings TEXT,
    created DATETIME NOT NULL DEFAULT '1970-01-01 01:01:01',
    modified DATETIME NOT NULL DEFAULT '1970-01-01 01:01:01',
    expired DATETIME NOT NULL DEFAULT '9999-12-31 00:00:00',
    active TINYINT(1) NOT NULL DEFAULT 1,
    PRIMARY KEY (domain),
    INDEX (backupmx),
    INDEX (expired),
    INDEX (active)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `alias_domain` (
    alias_domain VARCHAR(255) NOT NULL,
    target_domain VARCHAR(255) NOT NULL,
    created DATETIME NOT NULL DEFAULT '1970-01-01 01:01:01',
    modified DATETIME NOT NULL DEFAULT '1970-01-01 01:01:01',
    active TINYINT(1) NOT NULL DEFAULT 1,
    PRIMARY KEY (alias_domain),
    INDEX (target_domain),
    INDEX (active)
) ENGINE=InnoDB;

--
-- Table structure for table domain_admins
--
CREATE TABLE IF NOT EXISTS domain_admins (
    username VARCHAR(255) CHARACTER SET ascii NOT NULL DEFAULT '',
    domain VARCHAR(255) CHARACTER SET ascii NOT NULL DEFAULT '',
    created DATETIME NOT NULL DEFAULT '1970-01-01 01:01:01',
    modified DATETIME NOT NULL DEFAULT '1970-01-01 01:01:01',
    expired DATETIME NOT NULL DEFAULT '9999-12-31 00:00:00',
    active TINYINT(1) NOT NULL DEFAULT 1,
    PRIMARY KEY (username,domain),
    INDEX (username),
    INDEX (domain),
    INDEX (active)
) ENGINE=InnoDB;

--
-- Table structure for table mailbox
--
CREATE TABLE IF NOT EXISTS mailbox (
    username VARCHAR(255) NOT NULL DEFAULT '',
    password VARCHAR(255) NOT NULL DEFAULT '',
    name VARCHAR(255) NOT NULL DEFAULT '',
    language VARCHAR(5) NOT NULL DEFAULT '',
    storagebasedirectory VARCHAR(255) NOT NULL DEFAULT '',
    storagenode VARCHAR(255) NOT NULL DEFAULT '',
    maildir VARCHAR(255) NOT NULL DEFAULT '',
    quota BIGINT(20) NOT NULL DEFAULT 0, -- Total mail quota size
    domain VARCHAR(255) NOT NULL DEFAULT '',
    transport VARCHAR(255) NOT NULL DEFAULT '',
    department VARCHAR(255) NOT NULL DEFAULT '',
    rank VARCHAR(255) NOT NULL DEFAULT 'normal',
    employeeid VARCHAR(255) DEFAULT '',
    isadmin TINYINT(1) NOT NULL DEFAULT 0,
    isglobaladmin TINYINT(1) NOT NULL DEFAULT 0,
    enablesmtp TINYINT(1) NOT NULL DEFAULT 1,
    enablesmtpsecured TINYINT(1) NOT NULL DEFAULT 1,
    enablepop3 TINYINT(1) NOT NULL DEFAULT 1,
    enablepop3secured TINYINT(1) NOT NULL DEFAULT 1,
    enableimap TINYINT(1) NOT NULL DEFAULT 1,
    enableimapsecured TINYINT(1) NOT NULL DEFAULT 1,
    enabledeliver TINYINT(1) NOT NULL DEFAULT 1,
    enablelda TINYINT(1) NOT NULL DEFAULT 1,
    enablemanagesieve TINYINT(1) NOT NULL DEFAULT 1,
    enablemanagesievesecured TINYINT(1) NOT NULL DEFAULT 1,
    enablesieve TINYINT(1) NOT NULL DEFAULT 1,
    enablesievesecured TINYINT(1) NOT NULL DEFAULT 1,
    enableinternal TINYINT(1) NOT NULL DEFAULT 1,
    enabledoveadm TINYINT(1) NOT NULL DEFAULT 1,
    `enablelib-storage` TINYINT(1) NOT NULL DEFAULT 1,
    `enableindexer-worker` TINYINT(1) NOT NULL DEFAULT 1,
    enablelmtp TINYINT(1) NOT NULL DEFAULT 1,
    enabledsync TINYINT(1) NOT NULL DEFAULT 1,
    enablesogo TINYINT(1) NOT NULL DEFAULT 1,
    -- Must be set to NULL if it's not restricted.
    allow_nets TEXT DEFAULT NULL,
    lastlogindate DATETIME NOT NULL DEFAULT '1970-01-01 01:01:01',
    lastloginipv4 INT(4) UNSIGNED NOT NULL DEFAULT 0,
    lastloginprotocol CHAR(255) NOT NULL DEFAULT '',
    disclaimer TEXT,
    -- Below 4 columns are deprecated and will be removed in future release.
    -- Don't use them.
    allowedsenders TEXT,
    rejectedsenders TEXT,
    allowedrecipients TEXT,
    rejectedrecipients TEXT,
    -- Store per-user settings. Used in iRedAdmin-Pro.
    settings TEXT,
    passwordlastchange DATETIME NOT NULL DEFAULT '1970-01-01 01:01:01',
    created DATETIME NOT NULL DEFAULT '1970-01-01 01:01:01',
    modified DATETIME NOT NULL DEFAULT '1970-01-01 01:01:01',
    expired DATETIME NOT NULL DEFAULT '9999-12-31 00:00:00',
    active TINYINT(1) NOT NULL DEFAULT 1,
    -- Required by PostfixAdmin
    local_part VARCHAR(255) NOT NULL DEFAULT '',
    PRIMARY KEY (username),
    INDEX (domain),
    INDEX (department),
    INDEX (employeeid),
    INDEX (isadmin),
    INDEX (isglobaladmin),
    INDEX (enablesmtp),
    INDEX (enablesmtpsecured),
    INDEX (enablepop3),
    INDEX (enablepop3secured),
    INDEX (enableimap),
    INDEX (enableimapsecured),
    INDEX (enabledeliver),
    INDEX (enablelda),
    INDEX (enablemanagesieve),
    INDEX (enablemanagesievesecured),
    INDEX (enablesieve),
    INDEX (enablesievesecured),
    INDEX (enablelmtp),
    INDEX (enableinternal),
    INDEX (enabledoveadm),
    INDEX (`enablelib-storage`),
    INDEX (`enableindexer-worker`),
    INDEX (enabledsync),
    INDEX (enablesogo),
    INDEX (passwordlastchange),
    INDEX (expired),
    INDEX (active)
) ENGINE=InnoDB;

--
-- Table structure for table sender_bcc_domain
-- TODO Merge into table 'domain' (domain.sender_bcc)
--
CREATE TABLE IF NOT EXISTS sender_bcc_domain (
    domain VARCHAR(255) NOT NULL DEFAULT '',
    bcc_address VARCHAR(255) NOT NULL DEFAULT '',
    created DATETIME NOT NULL DEFAULT '1970-01-01 01:01:01',
    modified DATETIME NOT NULL DEFAULT '1970-01-01 01:01:01',
    expired DATETIME NOT NULL DEFAULT '9999-12-31 00:00:00',
    active TINYINT(1) NOT NULL DEFAULT 1,
    PRIMARY KEY (domain),
    INDEX (bcc_address),
    INDEX (expired),
    INDEX (active)
) ENGINE=InnoDB;

--
-- Table structure for table recipient_bcc_domain
-- TODO Merge into table 'domain' (domain.recipient_bcc)
--
CREATE TABLE IF NOT EXISTS recipient_bcc_domain (
    domain VARCHAR(255) NOT NULL DEFAULT '',
    bcc_address VARCHAR(255) NOT NULL DEFAULT '',
    created DATETIME NOT NULL DEFAULT '1970-01-01 01:01:01',
    modified DATETIME NOT NULL DEFAULT '1970-01-01 01:01:01',
    expired DATETIME NOT NULL DEFAULT '9999-12-31 00:00:00',
    active TINYINT(1) NOT NULL DEFAULT 1,
    PRIMARY KEY (domain),
    INDEX (bcc_address),
    INDEX (expired),
    INDEX (active)
) ENGINE=InnoDB;

--
-- Table structure for table sender_bcc_user
-- TODO Merge into table 'mailbox' (mailbox.sender_bcc)
--
CREATE TABLE IF NOT EXISTS sender_bcc_user (
    username VARCHAR(255) NOT NULL DEFAULT '',
    bcc_address VARCHAR(255) NOT NULL DEFAULT '',
    domain VARCHAR(255) NOT NULL DEFAULT '',
    created DATETIME NOT NULL DEFAULT '1970-01-01 01:01:01',
    modified DATETIME NOT NULL DEFAULT '1970-01-01 01:01:01',
    expired DATETIME NOT NULL DEFAULT '9999-12-31 00:00:00',
    active TINYINT(1) NOT NULL DEFAULT 1,
    PRIMARY KEY (username),
    INDEX (bcc_address),
    INDEX (domain),
    INDEX (expired),
    INDEX (active)
) ENGINE=InnoDB;

--
-- Table structure for table recipient_bcc_user
-- TODO Merge into table 'mailbox' (mailbox.recipient_bcc)
--
CREATE TABLE IF NOT EXISTS recipient_bcc_user (
    username VARCHAR(255) NOT NULL DEFAULT '',
    bcc_address VARCHAR(255) NOT NULL DEFAULT '',
    domain VARCHAR(255) NOT NULL DEFAULT '',
    created DATETIME NOT NULL DEFAULT '1970-01-01 01:01:01',
    modified DATETIME NOT NULL DEFAULT '1970-01-01 01:01:01',
    expired DATETIME NOT NULL DEFAULT '9999-12-31 00:00:00',
    active TINYINT(1) NOT NULL DEFAULT 1,
    PRIMARY KEY (username),
    INDEX (bcc_address),
    INDEX (expired),
    INDEX (active)
) ENGINE=InnoDB;

-- Sender dependent relayhost.
--  - per-user: account='user@domain.com'
--  - per-domain: account='@domain.com'
-- References:
--  - http://www.postfix.org/postconf.5.html#sender_dependent_relayhost_maps
--  - http://www.postfix.org/transport.5.html
CREATE TABLE IF NOT EXISTS sender_relayhost (
    id BIGINT(20) UNSIGNED AUTO_INCREMENT,
    account VARCHAR(255) NOT NULL DEFAULT '',
    relayhost VARCHAR(255) NOT NULL DEFAULT '',
    PRIMARY KEY (id),
    UNIQUE INDEX (account)
) ENGINE=InnoDB;

-- Used to store basic info of deleted mailboxes.
CREATE TABLE IF NOT EXISTS deleted_mailboxes (
    id BIGINT(20) UNSIGNED AUTO_INCREMENT,
    timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    -- Email address of deleted user
    username VARCHAR(255) NOT NULL DEFAULT '',
    -- Domain part of username
    domain VARCHAR(255) NOT NULL DEFAULT '',
    -- Absolute path of user's mailbox
    maildir VARCHAR(255) NOT NULL DEFAULT '',
    -- Deleted by which domain admin
    admin VARCHAR(255) NOT NULL DEFAULT '',
    -- The time scheduled to delete this mailbox.
    -- NOTE: it requires cron job + script to actually delete the mailbox.
    delete_date DATE DEFAULT NULL,

    KEY id (id),
    INDEX (timestamp),
    INDEX (username),
    INDEX (domain),
    INDEX (admin),
    INDEX (delete_date)
) ENGINE=InnoDB;

--
-- IMAP shared folders. User 'from_user' shares folders to user 'to_user'.
-- WARNING: Works only with Dovecot 1.2+.
--
CREATE TABLE IF NOT EXISTS share_folder (
    from_user VARCHAR(255) CHARACTER SET ascii NOT NULL,
    to_user VARCHAR(255) CHARACTER SET ascii NOT NULL,
    dummy CHAR(1),
    PRIMARY KEY (from_user, to_user),
    INDEX (from_user),
    INDEX (to_user)
);

CREATE TABLE IF NOT EXISTS anyone_shares (
    from_user VARCHAR(255) NOT NULL,
    dummy CHAR(1) DEFAULT '1',
    PRIMARY KEY (from_user)
);

-- used_quota
-- Used to store realtime mailbox quota in Dovecot.
-- WARNING: Works only with Dovecot 1.2+.
--
-- Note: Don't touch this table, it will be updated by Dovecot automatically.
CREATE TABLE IF NOT EXISTS `used_quota` (
    `username` VARCHAR(255) NOT NULL,
    `bytes` BIGINT NOT NULL DEFAULT 0,
    `messages` BIGINT NOT NULL DEFAULT 0,
    `domain` VARCHAR(255) NOT NULL DEFAULT '',
    PRIMARY KEY (`username`),
    INDEX (domain)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Trigger `used_quota_before_insert` is used to set `used_quota.domain`.
-- NOTE: `used_quota.domain` is not used by Dovecot, but used in iRedAdmin to
--       get better SQL query performance while calculating per-domain used
--       quota.
DELIMITER $$
CREATE TRIGGER `used_quota_before_insert`
    BEFORE INSERT ON `used_quota` FOR EACH ROW
    BEGIN
        SET NEW.domain = SUBSTRING_INDEX(NEW.username, '@', -1);
    END;
$$
DELIMITER ;
