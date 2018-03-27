# malscan class
#
# This class installs, configures, and manages malscan
#
# @summary Installs, manages, and configures a malscan installation.
#
# @example
#   include malscan
#
# @param application_directory     String      Path to the malscan main application directory
# @param binary_path               String      Path to the malscan executable file
# @param configuration_directory   String      Path to the malscan configuration directory
# @param email_notifications       Boolean     Whether email notifications should be sent.
# @param freshclam_config_file     String      Path to the built-in Freshclam configuration file
# @param install_type              String      Whether the install uses an OS-specific package or manual file installation.
# @param logging_directory         String      Path that all log files are saved to.
# @param malscan_sender_address    String      The email address that malscan will send as for email notifications.
# @param notification_addresses    String      The email address(es) that will be notified for all detections.
# @param quarantine_directory      String      Path that quarantined files should be stored in.
# @param scan_cron_minute          String      The cron value used for the minutes the scan cronjob runs.
# @param scan_cron_hour            String      The cron value used for the hours the scan cronjob runs.
# @param scan_cron_day             String      The cron value used for the day the scan cronjob runs.
# @param scan_cron_month           String      The cron value used for the month the scan cronjob runs.
# @param scan_cron_weekday         String      The cron value used for the weekday the scan cronjob runs.
# @param scan_cron_arguments       String      The cron value used for the arguments passed to the scan cronjob.
# @param signatures_directory      String      Path that signature files and databases are saved to by the updater.
# @param string_length_minimum     String      The minimum continuous sting length required to trigger on a String Detection Scan
# @param update_cron_minute        String      The cron value used for the minutes the update cronjob runs.
# @param update_cron_hour          String      The cron value used for the hours the update cronjob runs.
# @param update_cron_day           String      The cron value used for the day the update cronjob runs.
# @param update_cron_month         String      The cron value used for the month the update cronjob runs.
# @param update_cron_weekday       String      The cron value used for the weekday the update cronjob runs.
# @param update_cron_arguments     String      The cron value used for the arguments passed to the update cronjob.
class malscan (
  $application_directory,
  $binary_path,
  $configuration_directory,
  $email_notifications,
  $freshclam_config_file,
  $install_type,
  $logging_directory,
  $malscan_sender_address,
  $notification_addresses,
  $quarantine_directory,
  $scan_cron_minute,
  $scan_cron_hour,
  $scan_cron_day,
  $scan_cron_month,
  $scan_cron_weekday,
  $scan_cron_arguments,
  $signatures_directory,
  $string_length_minimum,
  $update_cron_minute,
  $update_cron_hour,
  $update_cron_day,
  $update_cron_month,
  $update_cron_weekday,
  $update_cron_arguments,
  ) {

  class { 'malscan::install':
    install_type => $install_type,
  }

  class { 'malscan::config':
    application_directory   => $application_directory,
    configuration_directory => $configuration_directory,
    email_notifications     => $email_notifications,
    freshclam_config_file   => $freshclam_config_file,
    logging_directory       => $logging_directory,
    malscan_sender_address  => $malscan_sender_address,
    notification_addresses  => $notification_addresses,
    quarantine_directory    => $quarantine_directory,
    signatures_directory    => $signatures_directory,
    string_length_minimum   => $string_length_minimum,
    require                 => Class['malscan::install'],
  }

  class { 'malscan::service':
    scan_cron_minute      => $scan_cron_minute,
    scan_cron_hour        => $scan_cron_hour,
    scan_cron_day         => $scan_cron_day,
    scan_cron_month       => $scan_cron_month,
    scan_cron_weekday     => $scan_cron_weekday,
    scan_cron_arguments   => $scan_cron_arguments,
    update_cron_minute    => $update_cron_minute,
    update_cron_hour      => $update_cron_hour,
    update_cron_day       => $update_cron_day,
    update_cron_month     => $update_cron_month,
    update_cron_weekday   => $update_cron_weekday,
    update_cron_arguments => $update_cron_arguments,
  }
}
