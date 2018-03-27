require 'spec_helper'

describe 'malscan::install' do
  context 'install subclass' do
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
          install_type: 'package'
        }
      end

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_package('epel-release').
        with_before('Package[malscan]')
      }

      it { is_expected.to contain_package('malscan').
        with_require('File[/etc/yum.repos.d/malscan.repo]')
      }

      it { is_expected.to contain_file('/etc/yum.repos.d/malscan.repo').
        with_content(%r{baseurl=http://yum.malscan.org/el/7/})
      }
    end
  end
end
