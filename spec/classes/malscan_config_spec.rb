require 'spec_helper'

describe 'malscan::config' do
  context 'config subclass' do
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
      let(:params) do
        {
          application_directory:    '/usr/local/share/malscan',
          configuration_directory:  '/etc/malscan',
          email_notifications:      'FALSE',
          freshclam_config_file:    '/etc/malscan/freshclam.conf',
          logging_directory:        '/var/log/malscan',
          malscan_sender_address:   '',
          notification_addresses:   '',
          quarantine_directory:     '/root/.malscan/quarantine',
          signatures_directory:     '/var/lib/malscan',
          string_length_minimum:    '15000'
        }
      end

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_file('/usr/local/share/malscan').
        with_owner('malscan').
        with_group('malscan').
        with_mode('0755').
        with_ensure('directory')
      }

      it { is_expected.to contain_file('/etc/malscan').
        with_owner('malscan').
        with_group('malscan').
        with_mode('0755').
        with_ensure('directory')
      }

      it { is_expected.to contain_file('/var/lib/malscan').
        with_owner('malscan').
        with_group('malscan').
        with_mode('0755').
        with_ensure('directory')
      }

      it { is_expected.to contain_file('/var/log/malscan').
        with_owner('malscan').
        with_group('malscan').
        with_mode('0755').
        with_ensure('directory')
      }

      it { is_expected.to contain_exec('create-quarantine-directory').
        with_command('mkdir -p \'/root/.malscan/quarantine\'').
        with_unless('test -d \'/root/.malscan/quarantine\'').
        with_before('File[/root/.malscan/quarantine]')
      }

      it { is_expected.to contain_file('/root/.malscan/quarantine').
        with_owner('root').
        with_group('root').
        with_mode('0700').
        with_ensure('directory')
      }

      it { is_expected.to contain_file('/etc/malscan/malscan.conf').
        with_owner('malscan').
        with_group('malscan').
        with_mode('0644').
        with_ensure('file').
        with_content(%r{APPLICATION_DIRECTORY="/usr/local/share/malscan"}).
        with_content(%r{CONFIGURATION_DIRECTORY="/etc/malscan"}).
        with_content(%r{FRESHCLAM_CONFIG_FILE="/etc/malscan/freshclam.conf"}).
        with_content(%r{LOGGING_DIRECTORY="/var/log/malscan"}).
        with_content(%r{SIGNATURES_DIRECTORY="/var/lib/malscan"}).
        with_content(%r{QUARANTINE_DIRECTORY="/root/.malscan/quarantine"}).
        with_content(%r{EMAIL_NOTIFICATIONS="FALSE"}).
        with_content(%r{MALSCAN_SENDER_ADDRESS=""}).
        with_content(%r{NOTIFICATION_ADDRESSES=""}).
        with_content(%r{STRING_LENGTH_MINIMUM=1500})
      }

      it { is_expected.to contain_file('/etc/malscan/freshclam.conf').
        with_owner('malscan').
        with_group('malscan').
        with_mode('0644').
        with_ensure('file').
        with_content(%r{DatabaseDirectory /var/lib/malscan}).
        with_content(%r{UpdateLogFile /var/log/malscan/update.log})
      }
    end
  end
end
