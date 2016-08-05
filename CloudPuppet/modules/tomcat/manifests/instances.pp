class tomcat::instances {
        create_resources('tomcat::instance',hiera('instances'))
}
