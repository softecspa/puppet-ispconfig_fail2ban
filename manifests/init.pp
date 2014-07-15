class ispconfig_fail2ban (
  $mailto             = params_lookup( 'mailto' ),
  $whitelist          = params_lookup( 'whitelist' ),
  $default_mailto     = params_lookup ( 'default_mailto' ),
  $default_whitelist  = params_lookup( 'default_whitelist' ),
  $findtime           = params_lookup( 'findtime' ),
  $bantime            = params_lookup( 'bantime' ),
  $maxretry           = params_lookup( 'maxretry' ),
  $backend            = params_lookup( 'backend' ),
  $apache2            = params_lookup( 'apache2' ),
  $ssh                = params_lookup( 'ssh' ),

) inherits ispconfig_fail2ban::params {

  $array_whitelist = is_array($whitelist)? {
    true  => $whitelist,
    false => [ $whitelist ]
  }

  $array_mailto = is_array($mailto)? {
    true  => $mailto,
    false => [ $mailto ]
  }

  $fail2ban_whitelist = [ $default_whitelist , $array_whitelist ]
  $fail2ban_mailto    = [ $default_mailto , $array_mailto ]


  class {'fail2ban':
    jails_config  => 'concat',
    ignoreip      => $fail2ban_whitelist,
    bantime       => $ispconfig_fail2ban::bantime,
    maxretry      => $ispconfig_fail2ban::maxretry,
    findtime      => $ispconfig_fail2ban::findtime,
    backend       => $ispconfig_fail2ban::backend,
    mailto        => join($fail2ban_mailto, ' '),
  }

  if $apache2 {
    include ispconfig_fail2ban::apache2
  }


}
