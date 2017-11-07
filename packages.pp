class packages {
	Package{ ensure => 'installed' } 
	package { 'openssh': }
	#package { 'mysql-client': }
	#package { 'mysql-server': }
	#package { 'tmux': }
	#package { 'dia2code': }
	package { 'gcc': }
	package { 'gdb': }
	#package { 'cgdb': }
	package { 'vim': }
	package { 'emacs': }
	#package { 'sshfs': }
}

