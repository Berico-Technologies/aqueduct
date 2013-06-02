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
# Group ID (Vulid): RHEL-06-000059
# Group Title: SRG-OS-000070
# Rule ID: RHEL-06-000059_rule
# Severity: low
# Rule Version (STIG-ID): RHEL-06-000059
# Rule Title: The system must require passwords to contain at least one 
# lowercase alphabetic character.
#
# Vulnerability Discussion: Requiring a minimum number of lowercase 
# characters makes password guessing attacks more difficult by ensuring a 
# larger search space.
#
# Responsibility: 
# IAControls: 
#
# Check Content:
#
# To check how many lowercase characters are required in a password, run 
# the following command: 

# $ grep pam_cracklib /etc/pam.d/system-auth

# The "lcredit" parameter (as a negative number) will indicate how many 
# special characters are required. The DoD requires at least one lowercase 
# character in a password. This would appear as "lcredit=-1". 
# If lcredit is not found or not set to the required value, this is a 
# finding.
#
# Fix Text: 
#
# The pam_cracklib module's "lcredit=" parameter controls requirements 
# for usage of lowercase letters in a password. When set to a negative 
# number, any password will be required to contain that many lowercase 
# characters. When set to a positive number, pam_cracklib will grant +1 
# additional length credit for each lowercase character. Add "lcredit=-1" 
# after pam_cracklib.so to require use of a lowercase character in 
# passwords.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=RHEL-06-000059
	
# Start-Lockdown

