class mysql::dbs {
	create_resources('mysql::db', hiera('mysql_db'))
}
