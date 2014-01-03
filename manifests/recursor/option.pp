define powerdns::recursor::option ($value, $key = $name, $ensure = 'present') {
  
  if($ensure == 'present') {
    ini_setting { $key:
      setting => $key,
      value   => $value,
      require  => Service['pdns-recursor'],
    }
  }
}