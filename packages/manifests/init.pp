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
	package { 'openssh': ensure => 'installed'}
	package { 'apache': }
	package { 'mysql-client': }
	package { 'mysql-server': }
	package { 'vncserver': }
	package { 'tmux': }
	package { 'dia2code': }
	package { 'lynx': }
	package { 'gcc': }
	package { 'gdb': }
	package { 'cgdb': }
	package { 'vim': }
	package { 'emacs': }
	package { 'sshfs': }
}

