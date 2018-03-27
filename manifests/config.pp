# malscan config class
#
# This module subclass manages module configuration
#
# @summary Manages files and configurations for malscan
#
# @example
#   include malscan::config
#
class malscan::config (
  $application_directory,
  $configuration_directory,
  $email_notifications,
  $freshclam_config_file,
  $logging_directory,
  $malscan_sender_address,
  $notification_addresses,
  $quarantine_directory,
  $signatures_directory,
  $string_length_minimum,
  )  {

  file { "${configuration_directory}/malscan.conf":
    ensure  => file,
    owner   => 'malscan',
    group   => 'malscan',
    mode    => '0644',
    content => epp('malscan/malscan.conf', {
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
    }),
  }

  file { "${configuration_directory}/freshclam.conf":
    ensure  => file,
    owner   => 'malscan',
    group   => 'malscan',
    mode    => '0644',
    content => epp('malscan/freshclam.conf', {
      logging_directory    => $logging_directory,
      signatures_directory => $signatures_directory
    }),
  }

  file { [ $application_directory, $configuration_directory, $logging_directory, $signatures_directory ]:
    ensure => directory,
    owner  => 'malscan',
    group  => 'malscan',
    mode   => '0755',
  }

  exec { 'create-quarantine-directory':
    command => "mkdir -p '${quarantine_directory}'",
    unless  => "test -d '${quarantine_directory}'",
    path    => '/bin:/usr/bin',
    before  => File[$quarantine_directory],
  }

  file { $quarantine_directory:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0700',
  }


}
