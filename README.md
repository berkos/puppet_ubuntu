puppet_devops ubuntu
===========

Puppet Modules
basic configuration for a UBUNTU environment with ruby on rails, mysql, imagemagick

How to run Puppet on a clean 14.04 server.

  ssh to the server and consider you are on the home directory

    sudo apt-get install git

  set temporary hostname of your choice usually ```staging.example.com``` OR ```production.example.com```
  puppet will set this after it runs itself.
  
    sudo hostname #desired_host_name

  get repo cloned and run the setup script

    git@github.com:berkos/puppet_ubuntu.git

    cd puppet_ubuntu

    ./bootstrap.sh

  then run the puppet

    sudo puppet apply --debug --modulepath modules manifests/site.pp



  keep in mind that if you wnat to use rvm immediately you have to exit ssh and ssh again to the server.

### Dependancies
- they are installed automatically

modules ->  maestrodev/rvm & maestrodev/rvm
