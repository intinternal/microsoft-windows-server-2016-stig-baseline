control 'V-73657' do
  title "Unencrypted passwords must not be sent to third-party Server Message
  Block (SMB) servers."
  desc  "Some non-Microsoft SMB servers only support unencrypted (plain-text)
  password authentication. Sending plain-text passwords across the network when
  authenticating to an SMB server reduces the overall security of the
  environment. Check with the vendor of the SMB server to determine if there is a
  way to support encrypted password authentication."
  impact 0.5
  tag "gtitle": 'SRG-OS-000074-GPOS-00042'
  tag "gid": 'V-73657'
  tag "rid": 'SV-88321r1_rule'
  tag "stig_id": 'WN16-SO-000210'
  tag "fix_id": 'F-80107r1_fix'
  tag "cci": ['CCI-000197']
  tag "nist": ['IA-5 (1) (c)', 'Rev_4']
  tag "documentable": false
  tag "check": "If the following registry value does not exist or is not
  configured as specified, this is a finding.

  Registry Hive:  HKEY_LOCAL_MACHINE
  Registry Path:
  \\SYSTEM\\CurrentControlSet\\Services\\LanmanWorkstation\\Parameters\\

  Value Name:  EnablePlainTextPassword

  Value Type:  REG_DWORD
  Value:  0x00000000 (0)"
  tag "fix": "Configure the policy value for Computer Configuration >> Windows
  Settings >> Security Settings >> Local Policies >> Security Options >>
  Microsoft Network Client: Send unencrypted password to third-party SMB
  servers to Disabled."
  describe registry_key('HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Services\\LanmanWorkstation\\Parameters') do
    it { should have_property 'EnablePlainTextPassword' }
    its('EnablePlainTextPassword') { should cmp 0 }
  end
end
