require 'spec_helper'

describe 'malscan::service' do
  context 'service subclass' do
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
          scan_cron_minute:      '0',
          scan_cron_hour:        '*/6',
          scan_cron_day:         '*',
          scan_cron_month:       '*',
          scan_cron_weekday:     '*',
          scan_cron_arguments:   '-a /var/www',
          update_cron_minute:    '0',
          update_cron_hour:      '2',
          update_cron_day:       '*',
          update_cron_month:     '*',
          update_cron_weekday:   '*',
          update_cron_arguments: '-u'
        }
      end

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_cron('malscan-scan').
        with_command('/usr/local/bin/malscan -a /var/www').
        with_user('root').
        with_minute('0').
        with_hour('*/6').
        with_month('*').
        with_monthday('*').
        with_weekday('*')
      }

      it { is_expected.to contain_cron('malscan-update').
        with_command('/usr/local/bin/malscan -u').
        with_user('root').
        with_minute('0').
        with_hour('2').
        with_month('*').
        with_monthday('*').
        with_weekday('*')
      }
    end

    context 'with custom parameters' do
      let(:params) do
        {
          scan_cron_minute:      '0',
          scan_cron_hour:        '*/4',
          scan_cron_day:         '*',
          scan_cron_month:       '*',
          scan_cron_weekday:     '*',
          scan_cron_arguments:   '-alm /var/www',
          update_cron_minute:    '0',
          update_cron_hour:      '0',
          update_cron_day:       '*',
          update_cron_month:     '*',
          update_cron_weekday:   '*',
          update_cron_arguments: '-u --fast'
        }
      end

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_cron('malscan-scan').
        with_command('/usr/local/bin/malscan -alm /var/www').
        with_user('root').
        with_minute('0').
        with_hour('*/4').
        with_month('*').
        with_monthday('*').
        with_weekday('*')
      }

      it { is_expected.to contain_cron('malscan-update').
        with_command('/usr/local/bin/malscan -u --fast').
        with_user('root').
        with_minute('0').
        with_hour('0').
        with_month('*').
        with_monthday('*').
        with_weekday('*')
      }
    end
  end
end
