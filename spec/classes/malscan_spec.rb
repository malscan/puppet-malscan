require 'spec_helper'

describe 'malscan' do
  context 'malscan class' do
    let(:facts) do
      {
        os: {
          family: 'RedHat',
          name:   'RedHat',
          release: {
            major: '7'
          }
        }
      }
    end

    context 'with hiera parameters' do
      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('malscan::install').with(
        'install_type' => 'package'
        )
      }

      it { is_expected.to contain_class('malscan::config').with(
        'application_directory'   => '/usr/local/share/malscan',
        'configuration_directory' => '/etc/malscan',
        'email_notifications'     => 'FALSE',
        'freshclam_config_file'   => '/etc/malscan/freshclam.conf',
        'logging_directory'       => '/var/log/malscan',
        'malscan_sender_address'  => '',
        'notification_addresses'  => '',
        'quarantine_directory'    => '/root/.malscan/quarantine',
        'signatures_directory'    => '/var/lib/malscan',
        'string_length_minimum'   => '15000',
        'require'                 => 'Class[Malscan::Install]'
        )
      }

      it { is_expected.to contain_class('malscan::service').with(
        'scan_cron_minute'      => '0',
        'scan_cron_hour'        => '*/6',
        'scan_cron_day'         => '*',
        'scan_cron_month'       => '*',
        'scan_cron_weekday'     => '*',
        'scan_cron_arguments'   => '-a /var/www',
        'update_cron_minute'    => '0',
        'update_cron_hour'      => '2',
        'update_cron_day'       => '*',
        'update_cron_month'     => '*',
        'update_cron_weekday'   => '*',
        'update_cron_arguments' => '-u'
        )
      }
    end
  end
end
