############################################################
# Class: iptables
#
# Description:
#
# Variables:
#	shared::dnsserver
#	shared::ftpserver
#	shared::krbserver
#	shared::ldapserver
#	shared::mailserver
#	shared::nfsserver
#	shared::puppetserver
#	shared::syslogserver
#	shared::webserver
#
# Facts:
#       None
#
# Files:
#	aqueduct/files/iptables/iptables-config
#
# Templates:
#	aqueduct/templates/iptables/iptables.erb
#
# Dependencies:
#       None
############################################################
class iptables {
	file {
		"/etc/sysconfig/iptables":
			owner   => root,
			group   => root,
			mode    => 600,
			notify  => Service["iptables"],
			content => template("aqueduct/iptables/iptables.erb");
		# To enable ip6tables, uncomment this section and the service section below
		#"/etc/sysconfig/ip6tables":
		#	owner   => root,
		#	group   => root,
		#	mode    => 600,
		#	notify  => Service["ip6tables"],
		#	content => template("aqueduct/iptables/ip6tables.erb");
		"/etc/sysconfig/iptables-config":
			owner  => root,
			group  => root,
			mode   => 600,
			notify  => Service["iptables"],
			source => "puppet:///modules/aqueduct/iptables/iptables-config";
	}

	service {
		"iptables":
			ensure => true,
			enable => true,
			hasstatus => true;
		#"ip6tables":
		#	ensure => true,
		#	enable => true,
		#	hasstatus => true;
	}
}
