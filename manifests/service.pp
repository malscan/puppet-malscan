# malscan service class
#
# This module subclass class manages malscan service management
#
# @summary Manages system services and daemons for malscan
#
# @example
#   class { 'malscan::service': }
#
# @param paramname Parameter description
class malscan::service (
  $scan_cron_minute,
  $scan_cron_hour,
  $scan_cron_day,
  $scan_cron_month,
  $scan_cron_weekday,
  $scan_cron_arguments,
  $update_cron_minute,
  $update_cron_hour,
  $update_cron_day,
  $update_cron_month,
  $update_cron_weekday,
  $update_cron_arguments,
  ){

  cron { 'malscan-update':
    command  => "/usr/local/bin/malscan ${update_cron_arguments}",
    user     => 'root',
    minute   => $update_cron_minute,
    hour     => $update_cron_hour,
    monthday => $update_cron_day,
    month    => $update_cron_month,
    weekday  => $update_cron_weekday,
  }

  cron { 'malscan-scan':
  command  => "/usr/local/bin/malscan ${scan_cron_arguments}",
  user     => 'root',
  minute   => $scan_cron_minute,
  hour     => $scan_cron_hour,
  monthday => $scan_cron_day,
  month    => $scan_cron_month,
  weekday  => $scan_cron_weekday,
  }

}
