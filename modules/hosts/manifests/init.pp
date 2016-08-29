class hosts {
  host { 'manage_test_host':
    name   => 'testing.puppetlabs.vm',
    ensure => present,
    ip     => '127.0.0.1',
  }
}
