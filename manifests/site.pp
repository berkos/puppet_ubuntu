Exec {
  path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
}

node "staging" {

  $rails_env = "staging"
  $user = "ubuntu"
  $hostname = "YOURHOSTNAME"

  $mysql_root_password = 'supersecret_password'
  $mysql_normal_user      = 'normal_user'
  $mysql_normal_password  = 'supersecret_password'
  $mysql_database_name = 'database_staging'


  include users
  include common
  include mysql
  include rvm
}

node "production" {

  $rails_env = "production"
  $user = "ubuntu"
  $hostname = "YOURHOSTNAME"

  $mysql_root_password = 'supersecret_password'
  $mysql_normal_user      = 'normal_user'
  $mysql_normal_password  = 'supersecret_password'
  $mysql_database_name = 'production_staging'


  include users
  include common
  include mysql
  include rvm
}
