# Internal: Install the powerdns package
#
# Example:
#
#    include powerdns::package
#
class powerdns::package(
    $package = $powerdns::params::package,
    $ensure = 'present',
    $source = '',
    $provider = ''
) inherits powerdns::params {

    $package_source = $source ? {
        ''      => undef,
        default => $source
    }

    $package_provider = $provider ? {
        ''      => undef,
        default => $powerdns::params::package_provider
    }

    package { $powerdns::params::packag:
        name     => $package
        ensure   => $ensure,
        source   => $package_source,
        provider => $package_provider
    }

    file {'/etc/powerdns/pdns.d':
        require => Package[$package],
        ensure  => directory
    }
    file {"/etc/powerdns/pdns.conf":
        ensure  => file,
        content => template('powerdns/pdns.conf.erb'),
        require => [File['/etc/powerdns/pdns.d'],Package[$package]],
        notify  => Class['powerdns::service'],
    }
}
