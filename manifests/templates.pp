class baseclass {
	package { "nmap": ensure => present }
	package { "git": ensure => present }
	package { "tmux": ensure => present }
	package { "screen": ensure => present }
	package { "wget": ensure => present }
	package { "curl": ensure => present }
	package { "vim-ruby": ensure => present }
}

node default {
	include baseclass
}

class dbserver {
	include baseclass
		include mariadb
		include munin::dbnode
}

class webserver {
	include baseclass
		include nginx
		include munin::webnode
}

class monitor {
	include baseclass
		include munin::server
}
