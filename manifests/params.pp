class ispconfig_fail2ban::params {
  $mailto             = []
  $whitelist          = []
  $findtime           = '3600'
  $bantime            = '864000'
  $maxretry           = '3'
  $backend            = 'polling'

  $softec_whitelist   = split($::subnet_softec,' ')
  $private_whitelist  = [ '127.0.0.0/8', '172.16.33.0/24', '10.0.0.0/8', '77.238.6.0/23' ]
  $default_whitelist  = [ $private_whitelist , $softec_whitelist ]

  $default_mailto     = [ $::notifyemail ]

  $apache2            = true
  $ssh                = true

}
