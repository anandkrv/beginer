# == Class: snoopy::params
#
# Base class of snoopy module which contains default parameter values to be used, inherited in init
#
#  [*username*]
#    If you want to include username in logs. Value: true
#
#  [*userid*]
#    If you want to include userid in logs. Value: true
#
#  [*groupid*]
#    If you want to include groupid in logs. Value: false
#
#  [*superid*]
#    If you want to include superuser id in logs. Value: false
#
#  [*terminal*]
#    If you want to include terminal type in logs. Value: true
#
#  [*currect_directory*]
#    If you want to include the directory from where the command is issued in logs. Value: true
#
#  [*processid*]
#    If you want to include processid of the command executed in logs. Value: false
#
#  [*filename*]
#    If you want to include the path of the binary that is called when command is executed in logs. Value: true
#
#  [*logfile*]
#    If you want to change the location of snoopy logs. Value: true
#
#  [*log_path*]
#    If logfile is set to true, then set the path of the log file. Value: /var/log/snoopy.log
#
#  [*datetime*]
#    If you want to include datetime when the command is executed in logs. Value: false
# === Parameters
#
class snoopy::params{
$username = true
$userid = true
$groupid = false
$superid = true
$terminal = true
$current_directory = true
$processid = false
$filename = true
$logfile = false
$datetime = false
$log_path = '/var/log/snoopy.log'
}
