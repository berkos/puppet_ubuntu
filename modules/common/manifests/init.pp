class common {

  group {
    $user:
      ensure => present
  }

  group {
    "admin":
      ensure => present
  }

  exec { "update_package_list":
    user    => "ubuntu",
    command => "/usr/bin/sudo /usr/bin/apt-get update",
  }

  package {
    [ "ntp", "git-core", "nodejs" ] :
      ensure => present
  }

  # rvm::install {
  #   #for user
  #   'ubuntu' : ;
  # }

  # file {
  #   ["/home/ubuntu/apps", 
  #    "/home/ubuntu/apps/app_devops/", 
  #    "/home/ubuntu/apps/app/"]:
  #     ensure => directory,
  #     owner  => ubuntu,
  #     mode   => 775
  # }

  package { "nginx":
    ensure => installed
  }

  package {
    "tree":
      ensure => present
  }

  package {
    "htop":
      ensure => present
  }

  package {
    "vim":
      ensure => present
  }

  package {
    "libxslt-dev":
      ensure => present
  }

  package {
    "libxml2-dev":
      ensure => present
  }

  package {
    "mysql-client":
      ensure => present
  }

  package {
    "libmysqlclient-dev":
      ensure => installed
  }


  package {
    "npm":
      ensure => installed
  }

  package {
    "imagemagick":
      ensure => present
  }

  service { "nginx":
    require => Package["nginx"],
    ensure => running,
    enable => true
  }

  file {
      "/etc/hostname":
        mode    => 640,
        owner   => root,
        group   => root,
        alias   => 'hostname',
        content => template('common/hostname.erb')
  }

  file {
      "/etc/hosts":
        mode    => 640,
        owner   => root,
        group   => root,
        alias   => 'hosts',
        content => template('common/hosts.erb')
  }

  file {
    ["/home/ubuntu/apps",
     "/home/ubuntu/apps/${hostname}",
     "/home/ubuntu/apps/${hostname}/shared",
     "/home/ubuntu/apps/${hostname}/shared/config",
     "/home/ubuntu/apps/${hostname}/shared/log",
     "/home/ubuntu/apps/${hostname}/shared/tmp",
     "/home/ubuntu/apps/${hostname}/backup",
     "/home/ubuntu/apps/${hostname}/backup/db",
     "/home/${user}/Backup/log",
     "/home/${user}/Backup"]:
      ensure => directory,
      owner  => $user,
      group  => $user,
      mode   => 755
  }

  file {
    "/etc/nginx/sites-enabled/${hostname}":
      mode    => 644,
      owner   => root,
      group   => root,
      notify  => Service["nginx"],
      before  => Service["nginx"],
      content => template('common/app.conf.erb')
  }

  file { "/etc/nginx/sites-enabled/default":
    ensure  => absent,
  }

  file {
    "/home/ubuntu/apps/${hostname}/shared/config/database.yml":
      mode    => 600,
      owner   => $user,
      group   => $user,
      content => template('hubs/database.yml.erb')
  }



}