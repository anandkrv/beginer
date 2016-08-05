# == Class: snoopy
#
# Base class of snoopy module which calls install and configure modules for installation and configuration of snoopy.
#
# === Parameters
#
#  [*username*]
#    If you want to include username in logs. Default: true
#
#  [*userid*]
#    If you want to include userid in logs. Default: true
#
#  [*groupid*]
#    If you want to include groupid in logs. Default: false
#
#  [*superid*]
#    If you want to include superuser id in logs. Default: false
#
#  [*terminal*]
#    If you want to include terminal type in logs. Default: true
#
#  [*currect_directory*]
#    If you want to include the directory from where the command is issued in logs. Default: true
#
#  [*processid*]
#    If you want to include processid of the command executed in logs. Default: false
#
#  [*filename*]
#    If you want to include the path of the binary that is called when command is executed in logs. Default: true
#
#  [*logfile*]
#    If you want to change the location of snoopy logs. Default: true
#
#  [*log_path*]
#    If logfile is set to true, then set the path of the log file. Default: /var/log/snoopy.log
#
#  [*datetime*]
#    If you want to include datetime when the command is executed in logs. Default: false
# === Example
#
#   class {'snoopy':}
#
class snoopy(
$username = $::snoopy::params::username,
$userid = $::snoopy::params::userid,
$groupid = $::snoopy::params::groupid,
$superid = $::snoopy::params::superid,
$terminal = $::snoopy::params::terminal,
$current_directory = $::snoopy::params::current_directory,
$processid = $::snoopy::params::processid,
$filename = $::snoopy::params::filename,
$logfile = $::snoopy::params::logfile,
$log_path = $::snoopy::params::log_path,
$datetime = $::snoopy::params::datetime
)inherits snoopy::params{
	# Install snoopy
	class {'snoopy::install':}
	# Configure snoopy logs
	class {'snoopy::configure':
		username => $username,
		userid => $userid,
		groupid => $groupid,
		superid => $superid,
		terminal => $terminal,
		current_directory => $current_directory,
		processid => $processid,
		filename =>$filename,
		logfile => $logfile,
		log_path => $log_path,
		datetime => $datetime,
		require => Class['snoopy::install'],
	}
}
