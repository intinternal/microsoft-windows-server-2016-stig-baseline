control 'V-73593' do
  title "The Windows Remote Management (WinRM) client must not use Basic
  authentication."
  desc "Basic authentication uses plain-text passwords that could be used to
  compromise a system. Disabling Basic authentication will reduce this potential."
  impact 0.7
  tag "gtitle": 'SRG-OS-000125-GPOS-00065'
  tag "gid": 'V-73593'
  tag "rid": 'SV-88257r1_rule'
  tag "stig_id": 'WN16-CC-000500'
  tag "fix_id": 'F-80043r1_fix'
  tag "cci": ['CCI-000877']
  tag "nist": ['MA-4 c', 'Rev_4']
  tag "documentable": false
  tag "check": "If the following registry value does not exist or is not
  configured as specified, this is a finding.

  Registry Hive: HKEY_LOCAL_MACHINE
  Registry Path: \\SOFTWARE\\Policies\\Microsoft\\Windows\\WinRM\\Client\\

  Value Name: AllowBasic

  Type: REG_DWORD
  Value: 0x00000000 (0)"
  tag "fix": "Configure the policy value for Computer Configuration >>
  Administrative Templates >> Windows Components >> Windows Remote Management
  (WinRM) >> WinRM Client >> Allow Basic authentication to Disabled."
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows\\WinRM\\Client') do
    it { should have_property 'AllowBasic' }
    its('AllowBasic') { should cmp 0 }
  end
end
