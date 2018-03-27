require 'puppetlabs_spec_helper/module_spec_helper'

RSpec.configure do |c|
  c.hiera_config = 'hiera.yaml'

  c.after(:suite) do
    RSpec::Puppet::Coverage.report!(100)
  end
end
