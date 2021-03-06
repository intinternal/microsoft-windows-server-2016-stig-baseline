control 'V-73641' do
  title "The maximum age for machine account passwords must be configured to 30
  days or less."
  desc "Computer account passwords are changed automatically on a regular
  basis. This setting controls the maximum password age that a machine account
  may have. This must be set to no more than 30 days, ensuring the machine
  changes its password monthly."
  impact 0.5
  tag "gtitle": 'SRG-OS-000480-GPOS-00227'
  tag "gid": 'V-73641'
  tag "rid": 'SV-88305r1_rule'
  tag "stig_id": 'WN16-SO-000120'
  tag "fix_id": 'F-80091r1_fix'
  tag "cci": ['CCI-000366']
  tag "nist": ['CM-6 b', 'Rev_4']
  tag "documentable": false
  tag "check": "This is the default configuration for this setting (30 days).

  If the following registry value does not exist or is not configured as
  specified, this is a finding.

  Registry Hive: HKEY_LOCAL_MACHINE
  Registry Path: \\SYSTEM\\CurrentControlSet\\Services\\Netlogon\\Parameters\\

  Value Name: MaximumPasswordAge

  Value Type: REG_DWORD
  Value: 0x0000001e (30) (or less, but not 0)"
  tag "fix": "This is the default configuration for this setting (30 days).

  Configure the policy value for Computer Configuration >> Windows Settings >>
  Security Settings >> Local Policies >> Security Options >> Domain member:
  Maximum machine account password age to 30 or less (excluding 0,
  which is unacceptable)."
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Services\\Netlogon\\Parameters') do
    it { should have_property 'MaximumPasswordAge' }
    its('MaximumPasswordAge') { should be <= 30 }
  end
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Services\\Netlogon\\Parameters') do
    it { should have_property 'MaximumPasswordAge' }
    its('MaximumPasswordAge') { should be > 0 }
  end
end
