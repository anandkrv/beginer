# == Class: nagios::command_serviceperformance
#
# This class will create a nagios command which will bulk process nagios service
# performance data using pnp4nagios
#
# === Authors
#
# Christopher Johnson - cjohn@ceh.ac.uk
#
class nagios::command_serviceperformance {
  nagios_command { 'process-service-perfdata-bulk':
    command_line => '/usr/lib/pnp4nagios/libexec/process_perfdata.pl --bulk=/tmp/service-perfdata',
  }
}