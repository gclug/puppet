import "templates"
import "nodes"

filebucket { main: server => puppet }

# global defaults
File { backup => main }
Exec { path => "/usr/bin:/usr/sbin/:/bin:/sbin" }

Package {
    provider => $operatingsystem ? {
        Ubuntu => aptitude,
        debian => aptitude
    }
}

$mysql_root_password = "password"

