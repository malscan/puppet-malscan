# malscan install class
#
# This module subclass class installs malscan
#
# @summary Installs malscan
#
# @example
#   include malscan::install
#
# @param paramname Parameter description
class malscan::install (
  $install_type,
  ) {

  if ($install_type == 'package') {

    $repo_file = lookup('malscan::repo_file')
    $repo_path = lookup('malscan::repo_path')
    file { "${repo_path}/${repo_file}":
      ensure  => file,
      owner   => root,
      group   => root,
      mode    => '0644',
      content => epp("malscan/${$repo_file}", {} ),
    }

    $package = lookup('malscan::package_name')
    package { $package:
      ensure  => present,
      require => File["${repo_path}/${repo_file}"],
    }

    $dependency_packages = lookup('malscan::dependency_packages')
    $dependency_packages.each |$dependency| {
      package { $dependency:
        ensure  => present,
        before  => Package[$package],
        require => File["${repo_path}/${repo_file}"],
      }
    }
  } else {
    fail('Your operating system is not currently supported by malscan\'s Puppet module.')
  }
}
