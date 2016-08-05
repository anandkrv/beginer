class pip::installs {
	create_resources('pip::install',hiera('pip_installs'))
}
