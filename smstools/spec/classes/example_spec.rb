require 'spec_helper'

describe 'smstools' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "smstools class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }

        it { should contain_class('smstools::params') }
        it { should contain_class('smstools::install').that_comes_before('smstools::config') }
        it { should contain_class('smstools::config') }
        it { should contain_class('smstools::service').that_subscribes_to('smstools::config') }

        it { should contain_service('smstools') }
        it { should contain_package('smstools').with_ensure('present') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'smstools class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should contain_package('smstools') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
