############################################################
# DO NOT TOUCH BELOW LINE.
#
from libs.default_settings import *
import os

############################################################
# General settings.
#
# Site webmaster's mail address.
webmaster = 'zhb@iredmail.org'

# Default language.
default_language = 'en_US'

# Database backend: mysql.
backend = 'mysql'

# Base directory used to store all mail data.
# iRedMail uses '/var/vmail/vmail1' as default storage directory.
# Tip: You can set a per-domain storage directory in domain profile page.
storage_base_directory = os.getenv('SNAP_DATA') + '/var/vmail/vmail1'

# Default mta transport.
# iRedMail uses 'dovecot' as defualt transport.
# Tip: You can set a per-domain or per-user transport in domain or user
#      profile page.
default_mta_transport = 'dovecot'

# Min/Max admin password length.
#   - min_passwd_length: 0 means unlimited, but at least 1 character
#                        is required.
#   - max_passwd_length: 0 means unlimited.
# User password length is controlled in domain profile.
min_passwd_length = 8
max_passwd_length = 0

#####################################################################
# Database used to store iRedAdmin data. e.g. sessions, log.
#
iredadmin_db_host = 'localhost'
iredadmin_db_port = 3306
iredadmin_db_name = 'iredadmin'
iredadmin_db_user = 'iredadmin'

iredadmin_unix_socket = os.getenv('SNAP_DATA') + '/mysql/mysql.sock'

iredadmin_password_file=os.getenv('SNAP_DATA') + '/mysql/iredadmin_password'
with open(iredadmin_password_file, 'r') as iredpasswd_file:
    iredadmin_db_password = iredpasswd_file.read().replace('\n', '')


############################################
# Database used to store mail accounts.
#
vmail_db_host = 'localhost'
vmail_db_port = 3306
vmail_db_name = 'vmailadmin'
vmail_db_user = 'vmailadmin'

vmail_unix_socket = os.getenv('SNAP_DATA') + '/mysql/mysql.sock'


vmailadmin_password_file=os.getenv('SNAP_DATA') + '/mysql/vmailadmin_password'
with open(vmailadmin_password_file, 'r') as vmailpasswd_file:
    vmail_db_password = vmailpasswd_file.read().replace('\n', '')

##############################################################################
# Settings used for Amavisd-new integration. Provides spam/virus quaranting,
# releasing, etc.
#
# Log basic info of in/out emails into SQL (@storage_sql_dsn): True, False.
# It's @storage_sql_dsn setting in amavisd. You can find this setting
# in amavisd-new config files:
#   - On RHEL/CentOS:   /etc/amavisd.conf or /etc/amavisd/amavisd.conf
#   - On Debian/Ubuntu: /etc/amavis/conf.d/50-user.conf
#   - On FreeBSD:       /usr/local/etc/amavisd.conf
# Reference:
# http://www.iredmail.org/wiki/index.php?title=IRedMail/FAQ/Integrate.MySQL.in.Amavisd

amavisd_enable_logging = True

amavisd_db_host = '127.0.0.1'
amavisd_db_port = 3306
amavisd_db_name = 'amavisd'
amavisd_db_user = 'amavisd'
amavisd_db_password = 'password'

# #### Quarantining ####
# Release quarantined SPAM/Virus mails: True, False.
# iRedAdmin-Pro will connect to @quarantine_server to release quarantined mails.
# How to enable quarantining in Amavisd-new:
# http://www.iredmail.org/wiki/index.php?title=IRedMail/FAQ/Quarantining.SPAM
amavisd_enable_quarantine = False

# Port of Amavisd protocol 'AM.PDP-INET'. Default is 9998.
amavisd_quarantine_port = 9998

# Enable per-recipient spam policy, white/blacklist.
amavisd_enable_policy_lookup = True

##############################################################################
# Settings used for iRedAPD integration: throttling and more.
#
# Enable iRedAPD integration.
iredapd_enabled = False

# SQL server/port and credential used to connect to iRedAPD SQL database.
iredapd_db_host = '127.0.0.1'
iredapd_db_port = 3306
iredapd_db_name = 'iredapd'
iredapd_db_user = 'iredapd'
iredapd_db_password = 'password'

##############################################################################
# Place your custom settings below, you can override all settings in this file
# and libs/default_settings.py here.
#
