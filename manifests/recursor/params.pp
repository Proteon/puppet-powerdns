class powerdns::recursor::params {
  
  $allow_from = "${::network_eth0}/24"
  $local_address = $::ipaddress_eth0
  $local_port = 53
  $setgid = 'pdns'
  $setuid = 'pdns'
  $quiet = 'yes'
}