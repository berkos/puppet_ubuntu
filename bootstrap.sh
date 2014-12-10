echo "----------------------------"
echo "update repos"
echo "----------------------------"
sudo apt-get -y update

echo "-----------------"
echo "Installing puppet"
echo "-----------------"
sudo apt-get install puppet-common

echo "-----------------"
echo "Installing modules for puppet"
echo "-----------------"
puppet module install maestrodev/rvm --force --target-dir=modules
puppet module install puppetlabs-stdlib  --force --target-dir=modules

echo "-----------------"
echo "How to run Puppet"
echo "-----------------"
echo "NOW run  --> $ sudo puppet apply --debug --modulepath modules manifests/site.pp"