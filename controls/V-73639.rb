control 'V-73639' do
  title 'The computer account password must not be prevented from being reset.'
  desc  "Computer account passwords are changed automatically on a regular
  basis. Disabling automatic password changes can make the system more vulnerable
  to malicious access. Frequent password changes can be a significant safeguard
  for the system. A new password for the computer account will be generated every
  30 days."
  impact 0.5
  tag "gtitle": 'SRG-OS-000379-GPOS-00164'
  tag "gid": 'V-73639'
  tag "rid": 'SV-88303r1_rule'
  tag "stig_id": 'WN16-SO-000110'
  tag "fix_id": 'F-80089r1_fix'
  tag "cci": ['CCI-001967']
  tag "nist": ['IA-3 (1)', 'Rev_4']
  tag "documentable": false
  tag "check": "If the following registry value does not exist or is not
  configured as specified, this is a finding.

  Registry Hive: HKEY_LOCAL_MACHINE
  Registry Path: \\SYSTEM\\CurrentControlSet\\Services\\Netlogon\\Parameters\\

  Value Name: DisablePasswordChange

  Value Type: REG_DWORD
  Value: 0x00000000 (0)"
  tag "fix": "Configure the policy value for Computer Configuration >> Windows
  Settings >> Security Settings >> Local Policies >> Security Options >> \"Domain
  member: Disable machine account password changes\" to \"Disabled\"."
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Services\\Netlogon\\Parameters') do
    it { should have_property 'DisablePasswordChange' }
    its('DisablePasswordChange') { should cmp 0 }
  end
end
