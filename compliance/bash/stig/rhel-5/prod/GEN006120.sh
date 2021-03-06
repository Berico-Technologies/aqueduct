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
# Group ID (Vulid): V-1056
# Group Title: GEN006120
# Rule ID: SV-37873r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN006120
# Rule Title: The /etc/smb.conf file must be group-owned by root, bin, 
# sys, or system.
#
# Vulnerability Discussion: If the group owner of the "smb.conf" file is 
# not root or a system group, the file may be maliciously modified and the 
# Samba configuration could be compromised.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the group ownership of the "smb.conf" file.

# Procedure:
# ls -lL /etc/samba/smb.conf

# If the "smb.conf" file is not group-owned by root, bin, sys, or system, 
# this is a finding.


#
# Fix Text: 
#
# Change the group owner of the smb.conf file.

# Procedure:
# chgrp root smb.conf     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN006120
	
# Start-Lockdown

if [ -a "/etc/samba/smb.conf" ]
then
  CURGROUP=`stat -c %G /etc/samba/smb.conf`;
  if [  "$CURGROUP" != "root" -a "$CURGROUP" != "bin" -a "$CURGROUP" != "sys" -a "$CURGROUP" != "system" ]
  then
      chgrp root /etc/samba/smb.conf
  fi
fi

