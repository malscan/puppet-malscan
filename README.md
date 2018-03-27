# malscan

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with malscan](#setup)
    * [What malscan affects](#what-malscan-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with malscan](#beginning-with-malscan)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)

## Description

The malscan module allows you to install and configure malscan with Puppet.

Malscan is an extension of ClamAV that provides alternative scan methods and robust new features for Linux systems.

## Setup

### What malscan affects:

* Package, service, and configuration files for malscan

### Getting started with malscan

To install and configure malscan, declare the `malscan` class:
``` puppet
class { 'malscan': }
```

The Puppet module applies a default configuration based on your operating system. You can customize parameters when declaring the `malscan` class. For instance, this declaration installs malscan with an update cronjob that runs every two hours:
``` puppet
class { 'malscan':
  update_cron_hour => '*/2',
}
```

By default, this module installs malscan using the official malscan repositories, if they are available for your Operating System. Alternatively, you can have this module manually install Malscan to /opt/malscan with:

``` puppet
class { 'malscan':
  install_type => 'manual',
}
```

To install this module to your Puppetmaster, add the following to your Puppetfile:

``` puppet
mod 'malscan',
  :git => 'https://github.com/malscan/puppet-malscan.git'
```

Alternatively, clone down the repository and manually include it on your codepath.

## Reference

### Classes

#### Public Classes

* [`malscan`](#malscan): Installs and configures malscan

#### Private Classes

* [`malscan::config`](#malscan::config)
* [`malscan::install`](#malscan::install)
* [`malscan::service`](#malscan::service)


### `malscan`

Installs and configures malscan.

When this class is declared without any parameters, Puppet:

- Provisions the official malscan repository on your system (if available)
- Installs the appropriate malscan package for your operating system (OS package, if available; manual install otherwise).
- Configures malscan
- Creates cronjobs for automatic malscan updating and scanning

You declare the module, with default parameters, via:

``` puppet
class { 'malscan': }
```

#### Parameters

##### `application_path`
Data Type: *string*.

The main path that the application resides in.

Default: `/usr/local/share/malscan`.

##### `binary_path`
Data Type: *string*.

The path that the application executable resides in.

Default: `/usr/local/bin/malscan`.

##### `configuration_path`
Data Type: *string*.

The path that the application's configuration files resides in.

Default: `/usr/local/share/malscan`.

##### `email_notifications`
Data Type: *boolean*.

Whether the application should send email notifications on a malware detection.

Default: `false`.

##### `freshclam_config_file`
Data Type: *string*.

The path to the malscan built-in Freshclam configuration file.

Default: `/etc/malscan/freshclam.conf`.

##### `install_type`
Data Type: *string*.

Whether the module uses the OS-specific package to install malscan, or manually installs all malscan component files.

Default for RedHat derivatives: `package`.
Default for all others: `manual`.

##### `logging_directory`
Data Type: *string*.

The path to the malscan logging directory.

Default: `/var/log/malscan`.

##### `malscan_sender_address`
Data Type: *string*.

The email address that malscan will use to send email notifications from.

**NOTE**: Ensure that you have added SPF and/or DKIM for the domain you will be sending from, so this email will pass authentication.
**NOTE**: It is strongly suggested you set a valid PTR record for the IP address the server is sending from, to ensure that email is delivered properly.

Default: `''`.

##### `notification_addresses`
Data Type: *string*.

The email address(es) that malscan will send notifications to, in a comma-separated list.

Default: `''`.

##### `quarantine_directory`
Data Type: *string*.

Path that quarantined files should be stored in.

Default: `/root/.malscan/quarantine`.

##### `scan_cron_minute`
Data Type: *string*.

The cron value used for the minutes the scan cronjob should run.

Default: `0`.

##### `scan_cron_hour`
Data Type: *string*.

The cron value used for the hours the scan cronjob should run.

Default: `*/6`.

##### `scan_cron_day`
Data Type: *string*.

The cron value used for the days the scan cronjob should run.

Default: `*`.

##### `scan_cron_month`
Data Type: *string*.

The cron value used for the months the scan cronjob should run.

Default: `*`.

##### `scan_cron_weekday`
Data Type: *string*.

The cron value used for the days of the week the scan cronjob should run.

Default: `*`.

##### `scan_cron_arguments`
Data Type: *string*.

The cron value used for the arguments passed to the scan cronjob.

Default: `-a /var/www`.

##### `signatures_directory`
Data Type: *string*.

Path that signature files and databases are stored in for malscan.

Default: `/var/lib/malscan`.

##### `string_length_minimum`
Data Type: *string*.

The minimum continuous string length required to trigger a String Length Scan detection.

Default: `15000`.


##### `update_cron_minute`
Data Type: *string*.

The cron value used for the minutes the update cronjob should run.

Default: `0`.

##### `update_cron_hour`
Data Type: *string*.

The cron value used for the hours the update cronjob should run.

Default: `2`.

##### `update_cron_day`
Data Type: *string*.

The cron value used for the days the update cronjob should run.

Default: `*`.

##### `update_cron_month`
Data Type: *string*.

The cron value used for the months the update cronjob should run.

Default: `*`.

##### `update_cron_weekday`
Data Type: *string*.

The cron value used for the days of the week the update cronjob should run.

Default: `*`.

##### `update_cron_arguments`
Data Type: *string*.

The cron value used for the arguments passed to the update cronjob.

Default: `-a /var/www`.

### Class: `malscan::config`

Configures files for malscan.

### Class: `malscan::install`

Deploys and configures any custom repositories and all pertinent packages.

### Class: `malscan::service`

Enables and controls the malscan cronjobs.

## Limitations

Basic testing is performed for the following Operating Systems:

* CentOS 7
* CentOS 6
