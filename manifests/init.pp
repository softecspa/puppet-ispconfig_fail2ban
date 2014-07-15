# == Class ispconfig_fail2ban
#
# this class is a wrapper of puppet-fail2ban module. It configure default values for an IspConfig environment
#
# === Parameters
# [*mailto*]
#   Addition mail destination used by fail2ban for notification
#
# [*whitelist*]
#   Additional IPs or network or fqdn to add to the whitelist
#
# [*default_mailto*]
#   Default mailto to add in mail destination. Default: global variable $::notifyemail
#
# [*default_whitelist*]
#   Default addresses added in whitelist. Default: global variable $::subnet_softec
#
# [*findtime*]
#   Findtime parameter of fail2ban. Default: 3600
#
# [*bantime*]
#   Duration of ban. Default: 86400 (1 day)
#
# [*maxretry*]
#   Max number of retry before ban addess. Default: 3
#
# [*backend*]
#   Backend fail2ban parameter. Default: polling
#
# [*apache2*]
#   If true, enable apache jail. Default: true
#
# [*ssh*]
#   If true, enable ssh jail. Default: true
#
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

  fail2ban::filter {'apache-lamp':
    filterfailregex => '[[]client <HOST>[]] (File does not exist|script not found or unable to stat): .*/(admin|zencart|ZenCart|Admin|sql|phpmyadmin|phpMyAdmin|file:|PMA|PMA2006|pma2006|sqlmanager|mysqlmanager|PMA2005|phpmyadmin-old|phpmyadminold|pma2005|phpmanager|mysql|myadmin|webadmin|sqlweb|websql|webdb|mysqladmin|mysql-admin|phpmyadmin2|phpMyAdmin2|phpMyAdmin-2|php-my-admin|b0ard|wbb1|wbb3|wbblite|directforum|WBB|WBB2|phpkit|phpkit_1.6.1|myadmin|webmin|webadmin|sqlweb|websql|webdb|mysqladmin|mysql-admin|phpmyadmin2|php-my-admin|phpMyAdmin-2.2.3|phpMyAdmin-2.2.6|phpMyAdmin-2.5.1|phpMyAdmin-2.5.4|phpMyAdmin-2.5.6|phpMyAdmin-2.6.0|phpMyAdmin-2.6.0-pl1|phpMyAdmin-2.6.2-rc1|phpMyAdmin-2.6.3|phpMyAdmin-2.6.3-pl1|phpMyAdmin-2.6.3-rc1|padmin|datenbank|database|horde|horde2|horde3|horde-3.0.9|Horde|horde-3.0.9|xmlrpc|xmlsrv|drupal|appserver|roundcube|roundcubemail|webmail2|webmail|bin|roundcubemail-0.1|roundcubemail-0.2|roundcube-0.1|roundcube-0.2|wp-login.php|ucp.php|\.asp|\.dll|\.exe|\.pl)'
  }

  fail2ban::jail {'apache-lamp':
    enable    => $ispconfig_fail2ban::apache2,
    jailname  => 'apache-lamp',
    port      => 'http',
    logpath   => '/var/log/apache2/web*-error.log',
  }

  fail2ban::jail {'ssh':
    enable    => $ispconfig_fail2ban::ssh,
    port      => 'ssh',
    filter    => 'sshd',
    logpath   => '/var/log/auth.log',
    maxretry  => 6
  }
}
