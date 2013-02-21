import "mariadb_create"

node 'basenode' {
}

node 'www' inherits basenode {
	$web_fqdn = 'www.goldcoastlinux.com'
		include dbserver
		include webserver
}

