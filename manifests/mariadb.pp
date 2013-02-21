include apt

class mariadb {

	apt::source { "mariadb":
		location => "http://mirror.aarnet.edu.au/pub/MariaDB/repo/5.5/ubuntu",
			 release => "$lsbdistcodename",
			 repos => "main",
			 key => '1BB943DB'
	}

	package { "mariadb-client": ensure => installed }
	package { "mariadb-server": ensure => installed }
	package { "mariadb-common": ensure => installed }

	exec { "Set MySQL server root password":
		subscribe => [ Package["mariadb-server"], Package["mariadb-client"], Package["mariadb-common"] ],
			  refreshonly => true,
			  unless => "mysqladmin -uroot -p$mysql_root_password status",
			  path => "/bin:/usr/bin",
			  command => "mysqladmin -uroot password $mysql_root_password",
	}

	service { "mysql":
		enable => true,
		       ensure => running,
		       require => Package["mariadb-server"],
	}

}

