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

##################### Fusion Technology LLC #############################
# By Shannon Mitchell                                                   #
# Fusion Technology LLC                                                 #
# Shannon[.]Mitchell[@]fusiontechnology-llc[.]com                       #
# www.fusiontechnology-llc.com                                          #
##################### Fusion Technology LLC #############################
#
#  _____________________________________________________________________
# |  Version |   Change Information  |      Author        |    Date    |
# |__________|_______________________|____________________|____________|
# |    1.0   |   Initial Script      | Shannon Mitchell   | 15-jul-2012|
# |          |   Creation            |                    |            |
# |__________|_______________________|____________________|____________|
#	                                                                  
   
	
#######################DISA INFORMATION##################################
# Group ID (Vulid): V-22305
# Group Title: GEN000610
# Rule ID: SV-26321r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN000610
# Rule Title: The system must require passwords contain at least one 
# lowercase alphabetic character.
#
# Vulnerability Discussion: To enforce the use of complex passwords, 
# minimum numbers of characters of different classes are mandated.  The use 
# of complex passwords reduces the ability of attackers to successfully 
# obtain valid passwords using guessing or exhaustive search techniques.  
# Complexity requirements increase the password search space by requiring 
# users to construct passwords from a larger character set than they may 
# otherwise use.
#
# Responsibility: System Administrator
# IAControls: IAIA-1, IAIA-2
#
# Check Content:
#
# Check /etc/pam.d/system-auth for lcredit setting.

# Procedure:
# Check the password lcredit option
# grep pam_cracklib.so /etc/pam.d/system-auth

# Confirm the lcredit option is set to -1 as in the example:

# password required pam_cracklib.so lcredit=-1

# There may be other options on the line. If no such line is found, or the 
# lcredit is not -1 this is a finding. 
#
# Fix Text: 
#
#  Edit "/etc/pam.d/system-auth" to include the line:

# password required pam_cracklib.so lcredit=-1

# prior to the "password include system-auth-ac" line.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000610
	
# Start-Lockdown

#####################################################################
# Set up custom config files if needed. This section will be appended
# to each script making pam config changes just in case.
#####################################################################

for PFPREFIX in system password smartcard fingerprint
do
  if [ -e "/etc/pam.d/${PFPREFIX}-auth-ac" ]
  then
    if [ ! -e "/etc/pam.d/${PFPREFIX}-auth-local" ]
    then
    
      cat <<EOF > /etc/pam.d/${PFPREFIX}-auth-local
auth          include       ${PFPREFIX}-auth-ac
account       include       ${PFPREFIX}-auth-ac
password      include       ${PFPREFIX}-auth-ac
session       include       ${PFPREFIX}-auth-ac
EOF

      ln -f -s /etc/pam.d/${PFPREFIX}-auth-local /etc/pam.d/${PFPREFIX}-auth
      chown root:root /etc/pam.d/${PFPREFIX}-auth-local
      chmod 644 /etc/pam.d/${PFPREFIX}-auth-local
      chcon system_u:object_r:etc_t /etc/pam.d/${PFPREFIX}-auth-local

    fi
  fi
done


# Comment out the original pam_craclkib from system-auth-ac as it overrides
# the one in the system-auth-local file after throwning errors.
for PFPREFIX in system password smartcard fingerprint
do
  if [ -e "/etc/pam.d/${PFPREFIX}-auth-local" ]
  then
    grep '^password    requisite     pam_cracklib.so try_first_pass retry=3' /etc/pam.d/${PFPREFIX}-auth-ac > /dev/null
    if [ $? -eq 0 ]
    then
      sed -i -e 's/password    requisite     pam_cracklib.so try_first_pass retry=3/#&/g' /etc/pam.d/${PFPREFIX}-auth-ac
    fi
  fi
done



# password required pam_cracklib.so lcredit=-1
# Run the fix
for PFPREFIX in system password smartcard fingerprint
do
  if [ -e "/etc/pam.d/${PFPREFIX}-auth-local" ]
  then

    # Fix the password line
    egrep '^[^#]?password.*pam_cracklib.*' /etc/pam.d/${PFPREFIX}-auth-local > /dev/null
    if [ $? != 0 ]
    then
      # Add the new entry if the line does not exist
      sed -i -e 's/\(^password.*-auth-ac\)/password      required      pam_cracklib.so lcredit=-1\n\1/' /etc/pam.d/${PFPREFIX}-auth-local
    else
      #Add the new argument if the line exists and the config does not
      egrep '^[^#]?password.*pam_cracklib' /etc/pam.d/${PFPREFIX}-auth-local | grep lcredit=-1 > /dev/null
      if [ $? != 0 ]
      then
        sed -i -e 's/\(^password.*pam_cracklib.*$\)/\1 lcredit=-1/' /etc/pam.d/${PFPREFIX}-auth-local
      fi
    fi
  fi
done
