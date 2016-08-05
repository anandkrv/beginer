# == Class: snoopy::configure
#
# Base class of snoopy module which configures snoopy called from init
#
# === Parameters
#
#  [*username*]
#    If you want to include username in logs. Value: undefined
#
#  [*userid*]
#    If you want to include userid in logs. Value: undefined
#
#  [*groupid*]
#    If you want to include groupid in logs. Value: undefined
#
#  [*superid*]
#    If you want to include superuser id in logs. Value: undefined
#
#  [*terminal*]
#    If you want to include terminal type in logs. Value: undefined
#
#  [*currect_directory*]
#    If you want to include the directory from where the command is issued in logs. Value: undefined
#
#  [*processid*]
#    If you want to include processid of the command executed in logs. Value: undefined
#
#  [*filename*]
#    If you want to include the path of the binary that is called when command is executed in logs. Value: undefined
#
#  [*logfile*]
#    If you want to change the location of snoopy logs. Value: undefined
#
#  [*log_path*]
#    If logfile is set to undefined, then set the path of the log file. Value: undefined
#
#  [*datetime*]
#    If you want to include datetime when the command is executed in logs. Value: undefined
#
# === Example
#
#   class {'snoopy::configure':
#       username => true,
#	userid => true,
#	groupid => false,
#	superid => false,
#	terminal => true,
#	current_directory => true,
#	processid => false,
#	filename => true,
#	logfile => true,
#	log_path => '/val/log/snoopy.log',
#	datetime => true,
#   }
#
class snoopy::configure(
$username = undef,
$userid = undef,
$groupid = undef,
$superid = undef,
$terminal = undef,
$current_directory = undef,
$processid = undef,
$filename = undef,
$logfile = undef,
$log_path = undef,
$datetime = undef
){
	# Create snoopy configuration file to generate appropriate logs
	file{'/etc/snoopy.ini':
		content => template('snoopy/snoopy.ini.erb'),
		owner => 'root',
		group => 'root',
		mode => '644',
	}
}
