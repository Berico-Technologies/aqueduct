#!/bin/bash

##########################################################################
#Aqueduct - Compliance Remediation Content
#Copyright (C) 2011,2012  
#  Vincent C. Passaro (vincent.passaro@gmail.com)
#  Shannon Mitchell (shannon.mitchell@fusiontechnology-llc.com)
#
#This program is free software; you can redistribute it and/or
#modify it under the terms of the GNU General Public License
#as published by the Free Software Foundation; either version 2
#of the License, or (at your option) any later version.
#
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with this program; if not, write to the Free Software
#Foundation, Inc., 51 Franklin Street, Fifth Floor,
#Boston, MA  02110-1301, USA.
##########################################################################

###################### Fotis Networks LLC ###############################
# By Vincent C. Passaro                                                 #
# Fotis Networks LLC	                                                #
# Vincent[.]Passaro[@]fotisnetworks[.]com                               #
# www.fotisnetworks.com	                                                #
###################### Fotis Networks LLC ###############################
#
#  _____________________________________________________________________
# |  Version |   Change Information  |      Author        |    Date    |
# |__________|_______________________|____________________|____________|
# |    1.0   |   Initial Script      | Vincent C. Passaro | 1-Aug-2012 |
# |          |   Creation            |                    |            |
# |__________|_______________________|____________________|____________|
#	                                                                  
   
	
#######################DISA INFORMATION##################################
# Group ID (Vulid): V-22508
# Group Title: GEN006571
# Rule ID: SV-37753r1_rule
# Severity: low
# Rule Version (STIG-ID): GEN006571
# Rule Title: The file integrity tool must be configured to verify 
# extended attributes.
#
# Vulnerability Discussion: Extended attributes in file systems are used 
# to contain arbitrary data and file metadata with security implications.
#
# Responsibility: System Administrator
# IAControls: ECAT-1
#
# Check Content:
#
# If using an Advanced Intrusion Detection Environment (AIDE), verify the 
# configuration contains the "xattrs" option for all monitored files and 
# directories.

# Procedure:
# Check for the default location /etc/aide/aide.conf
# or:
# find / -name aide.conf

# egrep "[+]?xattrs" <aide.conf file>
# If the option is not present. This is a finding.
# If using a different file integrity tool, check the configuration per 
# tool documentation.


#
# Fix Text: 
#
# If using AIDE, edit the configuration and add the "xattrs" option for 
# all monitored files and directories.

# If using a different file integrity tool, configure extended attributes 
# checking per the tool's documentation.     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN006571
	
# Start-Lockdown

#Think this is on by default...but not 100% since the check isn't very specific 
rpm -q aide > /dev/null
if [ $? -ne 0 ]
then
  yum install aide -y
fi

# AIDE uses group when setting the permissions.  By default xattrs are turned on
# for most, but just incase this is run after changes were made lets make sure 
# xattrs are there.
#
# If a rule has 'R', 'L', '>' or 'xattrs' then xattrs are included in the check.
#
# Start out by getting all file check definitions(line starting with a /)
# to get a list of used check groups.
if [ -e /etc/aide.conf ]
then
  for GROUP in `awk '/^\//{print $2}' /etc/aide.conf | sort | uniq`
  do
    CONFLINE=`awk "/^${GROUP}/{print \\$3}" /etc/aide.conf`
    if [[ "$CONFLINE" != *xattrs* ]] && [[ "$CONFLINE" != *R* ]]  && [[ "$CONFLINE" != *L* ]]  && [[ "$CONFLINE" != *\>* ]]
    then
      NEWCONFLINE="${CONFLINE}+xattrs"
      sed -i -e "s/^${GROUP}.*/${GROUP} = $NEWCONFLINE/g" /etc/aide.conf
    fi
  done
fi
