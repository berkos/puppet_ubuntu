class mysql {

  $normal_user_command = "create user \'${mysql_normal_user}\'@\'localhost\' identified by \'${mysql_normal_password}\';"
  $normal_grant_command = "grant all privileges on ${mysql_database_name}.* to \'${mysql_normal_user}\'@\'localhost\'"

  package {
    "mysql-server":
      ensure => installed
  }

  service {
    "mysql":
      ensure    => running,
      subscribe => File["/etc/mysql/my.cnf"],
      require   => [Package["mysql-server"], Package["mysql-client"], Package["libmysqlclient-dev"]]
  }

  file {
    "/etc/mysql/my.cnf":
      owner  => root,
      group  => root,
      mode   => 644,
      source => "puppet:///modules/mysql/my.cnf"
  }

  exec {
    "mysql_root_password":
      unless  => "mysqladmin -uroot -p${mysql_root_password} status",
      command => "mysqladmin -uroot password ${mysql_root_password}",
      require => Service[mysql];
    "normal_user":
      unless  => "mysqladmin -u${mysql_normal_user} -p${mysql_normal_password} status",
      command => "mysql -uroot -p${mysql_root_password} -e \"${normal_user_command}\"",
      require => [Service[mysql], Exec["normal_db"]];
    "normal_db":
      unless  => "mysql -uroot -p${mysql_root_password} ${mysql_database_name}",
      command => "mysql -uroot -p${mysql_root_password} -e 'create database ${mysql_database_name}'",
      require => Exec["mysql_root_password"];
    "normal_permissions":
      unless  => "mysql -u${mysql_normal_user} -p${mysql_normal_password} ${mysql_database_name}",
      command => "mysql -uroot -p${mysql_root_password} -e \"${normal_grant_command}\"",
      require => Exec["normal_user"];
  }

}