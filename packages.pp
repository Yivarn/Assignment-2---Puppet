class packages {
	Package{ ensure => 'installed' } 
	package { 'openssh': }
	package { 'tmux': }
	package { 'gcc': }
	package { 'gdb': }
	package { 'vim': }
	package { 'emacs': }
	package { 'csh': }
}

