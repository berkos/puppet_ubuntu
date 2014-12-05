class rvm_app {

  class { 'rvm': version => '1.25.24' }

  rvm::system_user { 'ubuntu': }

  rvm_system_ruby {
  'ruby-2.1.5':
    ensure => 'present',
    default_use => true;

  }

  rvm_gemset {
  "ruby-2.1.5@default":
    ensure => present,
    require => Rvm_system_ruby['ruby-2.1.5'];
  }

  rvm_gem {
    'ruby-2.1.5@default/bundler':
      require => Rvm_gemset['ruby-2.1.5@default'];
  }
}