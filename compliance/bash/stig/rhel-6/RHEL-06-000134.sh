#!/bin/bash

##########################################################################
#Red Hat Enterprise Linux 6 - DISA STIG Compliance Remediation Content
#Copyright (C) 2013 
#Vincent C. Passaro (vince@buddhalabs.com)
#
##########################################################################

######################  Buddha Labs LLC  ################################
# By Vincent C. Passaro                                                 #
# Buddha Labs LLC.                                                      #
# vince[@]buddhalabs[.]com                                              #
# www.buddhalabs.com	                                                #
######################  Buddha Labs LLC  ################################
#_________________________________________________________________________
#    Version |   Change Information     |      Author        |    Date    
#-------------------------------------------------------------------------
#    1.0     |  Initial Script Creation |  Vincent Passaro   | 1-JUNE-2013
#	                                                                  
   
	
#######################DISA INFORMATION##################################
# Group ID (Vulid): RHEL-06-000134
# Group Title: SRG-OS-000206
# Rule ID: RHEL-06-000134_rule
# Severity: medium
# Rule Version (STIG-ID): RHEL-06-000134
# Rule Title: All rsyslog-generated log files must be group-owned by root.
#
# Vulnerability Discussion: The log files generated by rsyslog contain 
# valuable information regarding system configuration, user authentication, 
# and other such information. Log files should be protected from 
# unauthorized access.
#
# Responsibility: 
# IAControls: 
#
# Check Content:
#
# The group-owner of all log files written by "rsyslog" should be root. 
# These log files are determined by the second part of each Rule line in 
# "/etc/rsyslog.conf" and typically all appear in "/var/log". For each log 
# file [LOGFILE] referenced in "/etc/rsyslog.conf", run the following 
# command to inspect the file's group owner: 

# $ ls -l [LOGFILE]

# If the group-owner is not root, this is a finding.
#
# Fix Text: 
#
# The group-owner of all log files written by "rsyslog" should be root. 
# These log files are determined by the second part of each Rule line in 
# "/etc/rsyslog.conf" and typically all appear in "/var/log". For each log 
# file [LOGFILE] referenced in "/etc/rsyslog.conf", run the following 
# command to inspect the file's group owner:

# $ ls -l [LOGFILE]

# If the owner is not "root", run the following command to correct this:

# chgrp root [LOGFILE]

  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=RHEL-06-000134
	
# Start-Lockdown

