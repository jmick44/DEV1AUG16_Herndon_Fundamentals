define nginx::vhost (
  $media_dir = 'media',
  $script_dir = 'cgi-bin',
  $asset_dir = 'assets',
) {
  include nginx

  file { "${nginx::docroot}/${title}":
    ensure => directory,
  }

  file { "${nginx::docroot}/${title}/${media_dir}":
    ensure => directory,
  }

  file { "${nginx::docroot}/${title}/${script_dir}":
    ensure => directory,
  }

  file { "${nginx::docroot}/${title}/${asset_dir}":
    ensure => directory,
  }
}
