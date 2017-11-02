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
        #name => "becca", # Needed?
        ensure => present,
        home => "/home/becca",
        groups => ["sysadmin", "cars"],
        #managepassword => true,
        #encrypted password ??
        uid => 10017699,
        shell => "/bin/bash"
    }
    user { "fred":
        #name => "fred", # Needed?
        ensure => present,
        home => "/home/fred",
        groups => ["cars", "trucks"],
        #managepassword => true,
        #encrypted password ??
        #uid => 10027699, # Required??
        shell => "/bin/csh"
    }
    user { "wilma":
        #name => "wilma", # Needed?
        ensure => present,
        home => "/home/wilma",
        groups => ["cars", "trucks", "ambulances"],
        #managepassword => true, # Syntax??
        #encrypted password ??
        uid => 10037699,
        shell => "/bin/csh"
        #puppet managed ssh key ????
    }
}
