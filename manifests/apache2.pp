class ispconfig_fail2ban::apache2 {

  fail2ban::filter {'apache-lamp':
    filterfailregex => '[[]client <HOST>[]] (File does not exist|script not found or unable to stat): .*/(admin|zencart|ZenCart|Admin|sql|phpmyadmin|phpMyAdmin|file:|PMA|PMA2006|pma2006|sqlmanager|mysqlmanager|PMA2005|phpmyadmin-old|phpmyadminold|pma2005|phpmanager|mysql|myadmin|webadmin|sqlweb|websql|webdb|mysqladmin|mysql-admin|phpmyadmin2|phpMyAdmin2|phpMyAdmin-2|php-my-admin|b0ard|wbb1|wbb3|wbblite|directforum|WBB|WBB2|phpkit|phpkit_1.6.1|myadmin|webmin|webadmin|sqlweb|websql|webdb|mysqladmin|mysql-admin|phpmyadmin2|php-my-admin|phpMyAdmin-2.2.3|phpMyAdmin-2.2.6|phpMyAdmin-2.5.1|phpMyAdmin-2.5.4|phpMyAdmin-2.5.6|phpMyAdmin-2.6.0|phpMyAdmin-2.6.0-pl1|phpMyAdmin-2.6.2-rc1|phpMyAdmin-2.6.3|phpMyAdmin-2.6.3-pl1|phpMyAdmin-2.6.3-rc1|padmin|datenbank|database|horde|horde2|horde3|horde-3.0.9|Horde|horde-3.0.9|xmlrpc|xmlsrv|drupal|appserver|roundcube|roundcubemail|webmail2|webmail|bin|roundcubemail-0.1|roundcubemail-0.2|roundcube-0.1|roundcube-0.2|wp-login.php|ucp.php|\.asp|\.dll|\.exe|\.pl)'
  }

  fail2ban::jail {'apache-lamp':
    jailname  => 'apache-lamp',
    port      => 'http',
    logpath   => '/var/log/apache2/web*-error.log',
  }
}
