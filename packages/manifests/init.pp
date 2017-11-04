# Class: packages
# ===========================
#
# This class manages the instalation of required packages.
#
# Author
# ------
#
# Yivarn Norman <s362769@student.rmit.edu.au>
#
class packages {
	Package{ ensure => 'installed' } 

	package { 'openssh': }

	# apache
	#package { 'httpd': }

	#package { 'mysql-client': }
	#package { 'mysql-server': }

	# vnc-server
	package { 'tigervnc-server': }

	package { 'tmux': }
	#package { 'dia2code': }

	# yum-config-manager --enable rhui-REGION-rhel-server-extras rhui-REGION-rhel-server-optional 
	package { 'lynx': }

	package { 'gcc': }
	package { 'gdb': }
	
	#package { 'cgdb': }
	
	package { 'vim': }
	package { 'emacs': }

	#package { 'sshfs': }
}

