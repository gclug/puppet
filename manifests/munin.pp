import "line.pp"

class munin::server {
	package { "munin": ensure => present }
}

class munin::allow {
	file { "/etc/munin/munin-node.conf": ensure => present, }

	line { allow:
		file => "/etc/munin/munin-node.conf",
		     line => "allow ^54\\.252\\.87\\.123$",
		     notify => Service["munin-node"],
	}
}

class munin::service {
	service { "munin-node":
		ensure  => "running",
			enable  => "true",
			require => Package["munin-node"],
			subscribe => [File['/etc/munin/plugins/mysql'],File['/etc/munin/plugins/mysql_queries'], File['/etc/munin/munin-node.conf']],
	}
}

class munin::node {
	package { "munin-node": ensure => present }
	package { "munin-plugins-extra": ensure => present }
}

class munin::dbnode {

	include munin::node
		include munin::service
		include munin::allow

		file { '/etc/munin/plugins/mysql':
			ensure => 'link',
			       target => '/usr/share/munin/plugins/mysql_',
			       require => Package["munin-node"],
		}
	file { '/etc/munin/plugins/mysql_queries':
		ensure => 'link',
		       target => '/usr/share/munin/plugins/mysql_queries',
		       require => Package["munin-node"],
	}

}

class munin::webnode {

	include munin::node
		include munin::service
		include munin::allow

		file { '/etc/munin/plugins/nginx_status':
			ensure => 'link',
			       target => '/usr/share/munin/plugins/nginx_status',
			       require => Package["munin-node"],
		}
	file { '/etc/munin/plugins/nginx_request':
		ensure => 'link',
		       target => '/usr/share/munin/plugins/nginx_request',
		       require => Package["munin-node"],
	}

}
