puppet-ispconfig\_fail2ban
=========================

wrapper of module fail2ban with some customization for IspConfig2 environment

####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with [Modulename]](#setup)
 * [Setup requirements](#setup-requirements)
4. [Usage - Configuration options and additional functionality](#usage)

##Overview
this module is a wrapper of puppet-fail2ban module. It configure fail2ban for a IspConfig2 environment

##Module Description
Module add in default whitelist ip and network address taken from global variables. Also it add in same way a default mailto

##Setup
    include ispconfig_fail2ban

If you want to add IPs or network in whitelist, or another email address:

    class {'ispconfig_fail2ban':
      mailto    => 'another@emailaddress.com',
      whitelist => [
        'x.x.x.x,
        'y.y.y.y/zz',
        'example.com',
      ]
    }

###Setup Requirements

 * softecspa/puppet-fail2ban module

By default module uses this two global variables to set default whitelist and mailto:

 * $::subnet\_softec
 * $::notifyemail

##Usage
Actually only apache2 and ssh jails are managed by this module. By default both jails are enabled. If you want to disable one or more jails:

    class {'ispconfig_fail2ban':
      apache2 => false,
    }
