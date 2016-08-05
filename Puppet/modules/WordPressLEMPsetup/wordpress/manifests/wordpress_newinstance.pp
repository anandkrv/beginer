class wordpress::wordpress_newinstance {
      create_resources('wordpress::instance',hiera('wordpress_newinstance'))
}      




