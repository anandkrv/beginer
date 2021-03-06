# Class for installing a MongoDB tools (CLI).
#
# == Parameters
#
# [ensure] Desired ensure state of the package. Optional.
#   Defaults to 'true'
#
# [package_name] Name of the package to install the client from. Default
#   is repository dependent.
#
class mongodb::tools (
  $ensure       = $mongodb::params::package_ensure_tools,
  $package_name = $mongodb::params::tools_package_name,
) inherits mongodb::params {
  class { '::mongodb::tools::install': }
}
