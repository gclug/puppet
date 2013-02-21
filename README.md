Puppet
======

Puppet manifests for gclug servers

Bootstrapping
=============

Before we begin with puppet we need to bootstrap a few things:

	wget http://apt.puppetlabs.com/puppetlabs-release-precise.deb
	sudo dpkg -i puppetlabs-release-precise.deb
	sudo apt-get update
	sudo apt-get install puppet rubygems
	sudo puppet module install puppetlabs/apt
	git clone https://github.com/gclug/puppet.git
