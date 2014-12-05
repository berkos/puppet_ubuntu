class users {

  user { "ubuntu":
    ensure => "present",
    shell => "/bin/bash",
    managehome => true,
  }

}