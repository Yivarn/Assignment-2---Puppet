class users
{
    # Group Config:
    group{ "cars":
        ensure => present
    }
    group{ "trucks":
        ensure => present
    }
    group{ "ambulances":
        ensure => present
    }
    group{ "sysadmin":
        ensure => present
    }
    
    # User Config:
    user { "becca":
        name => "becca",
	comment => "becca's account",
        ensure => present,
        home => "/home/becca",
        groups => ["sysadmin", "cars"],
	managehome => true,
        uid => 10017699,
        shell => "/bin/bash",
    }
    user { "fred":
        name => "fred",
        ensure => present,
        home => "/home/fred",
        groups => ["cars", "trucks"],
        #encrypted password ??
        #uid => 10027699, # Required??
	managehome => true,
        shell => "/bin/csh"
    }
    user { "wilma":
        name => "wilma", # Needed?
        ensure => present,
        home => "/home/wilma",
        groups => ["cars", "trucks", "ambulances"],
        #encrypted password ??
        uid => 10037699,
	managehome => true,
        shell => "/bin/csh"
        #puppet managed ssh key ????
    }
}
