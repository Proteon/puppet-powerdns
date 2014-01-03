#
# See http://doc.powerdns.com/html/built-in-recursor.html for configuration options
#
class powerdns::recursor (
  $allow_from    = $powerdns::recursor::params::allow_from,
  $local_address = $powerdns::recursor::params::local_address,
  $local_port    = $powerdns::recursor::params::local_port,
  $setgid        = $powerdns::recursor::params::setgid,
  $setuid        = $powerdns::recursor::params::setuid,
  $quiet         = $powerdns::recursor::params::quiet,
  $ensure        = 'present') inherits powerdns::recursor::params {
  include powerdns

  package { 'pdns-recursor':
    
    ensure => $ensure ? {
      'present' => held,
      'absent'  => purged,
      default   => held,
    },  
    provider  => 'aptitude',
  }

  if ($ensure == 'present') {
    
    Ini_setting {
      path    => "/etc/powerdns/recursor.conf",
      section => '',
    }

    powerdns::recursor::option { 'allow-from': value => $allow_from }

    powerdns::recursor::option { 'local-address': value => $local_address }

    powerdns::recursor::option { 'local-port': value => $local_port }

    powerdns::recursor::option { 'setgid': value => $setgid }

    powerdns::recursor::option { 'setuid': value => $setuid }

    powerdns::recursor::option { 'quiet': value => $quiet }

    service { 'pdns-recursor':
      enable     => true,
      ensure     => true,
      hasrestart => true,
      hasstatus  => false,
      pattern    => '/usr/sbin/pdns_recursor',
      provider   => 'upstart',
      require    => Package['pdns-recursor'],
    }
  }
}