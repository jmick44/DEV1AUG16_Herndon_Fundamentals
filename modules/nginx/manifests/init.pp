class nginx (
  $message  = 'Puppet is awesome!',
  $package  = $nginx::params::package,
  $owner    = $nginx::params::owner,
  $group    = $nginx::params::group,
  $docroot  = $nginx::params::docroot,
  $confdir  = $nginx::params::confdir,
  $blockdir = $nginx::params::blockdir,
  $logdir   = $nginx::params::logdir,
  $service  = $nginx::params::service,
  $user     = $nginx::params::user,
) inherits nginx::params {

  notify { "$message": }

  File {
    owner => $owner,
    group => $group,
    mode  => '0664',
  }

  package { $package:
    ensure => installed,
    before => File["${blockdir}/default.conf"],
  }

  file { $docroot:
    ensure => directory,
    #owner  => 'root',
    #group  => 'root',
    mode   => '0775',
  }

  file { 'create_indexfile':
    ensure  => file,
    path    => "${docroot}/index.html",
    #owner  => 'root',
    #group  => 'root',
    #mode   => '0664',
    #source => 'puppet:///modules/nginx/index.html', 
    content => template('nginx/index.html.erb'),
  }

  file { "${confdir}/nginx.conf":
    ensure  => file,
    #owner   => 'root',
    #group   => 'root',
    #mode    => '0664',
    source  => 'puppet:///modules/nginx/nginx.conf',
    notify  => Service[$service],
    require => Package[$package],
  }

  file { "${blockdir}/default.conf":
    ensure => file,
    #owner  => 'root',
    #group  => 'root',
    #mode   => '0664',
    source => 'puppet:///modules/nginx/default.conf',

  }

  service { $service:
    ensure    => running,
    enable    => true,
    subscribe => File["${blockdir}/default.conf"],
  }
}
