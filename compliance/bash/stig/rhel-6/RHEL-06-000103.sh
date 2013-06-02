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
# Group ID (Vulid): RHEL-06-000103
# Group Title: SRG-OS-000152
# Rule ID: RHEL-06-000103_rule
# Severity: medium
# Rule Version (STIG-ID): RHEL-06-000103
# Rule Title: The system must employ a local IPv6 firewall.
#
# Vulnerability Discussion: The "ip6tables" service provides the system's 
# host-based firewalling capability for IPv6 and ICMPv6.
#
# Responsibility: 
# IAControls: 
#
# Check Content:
#
# If IPv6 is disabled, this is not applicable.

# Run the following command to determine the current status of the 
# "ip6tables" service: 

# service ip6tables status

# If the service is enabled, it should return the following: 

# ip6tables is running...


# If the service is not running, this is a finding.
#
# Fix Text: 
#
# The "ip6tables" service can be enabled with the following command: 

# chkconfig ip6tables on

  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=RHEL-06-000103
	
# Start-Lockdown

