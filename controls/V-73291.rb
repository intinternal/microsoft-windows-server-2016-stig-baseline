control 'V-73291' do
  title 'The Peer Name Resolution Protocol must not be installed.'
  desc  "Unnecessary services increase the attack surface of a system. Some of
  these services may not support required levels of authentication or encryption
  or may provide unauthorized access to the system."
  impact 0.5
  tag "gtitle": 'SRG-OS-000095-GPOS-00049'
  tag "gid": 'V-73291'
  tag "rid": 'SV-87943r1_rule'
  tag "stig_id": 'WN16-00-000370'
  tag "fix_id": 'F-80269r1_fix'
  tag "cci": ['CCI-000381']
  tag "nist": ['CM-7', 'Rev_4']
  tag "documentable": false
  tag "check": "Open PowerShell.

  Enter Get-WindowsFeature | Where Name -eq PNRP.

  If Installed State is Installed, this is a finding.

  An Installed State of Available or Removed is not a finding."
  tag "fix": "Uninstall the Peer Name Resolution Protocol feature.

  Start Server Manager.

  Select the server with the feature.

  Scroll down to ROLES AND FEATURES in the right pane.

  Select Remove Roles and Features from the drop-down TASKS list.

  Select the appropriate server on the Server Selection page and click
  Next.

  Deselect Peer Name Resolution Protoco on the Features page.

  Click Next and Remove as prompted."
  describe windows_feature('PNRP') do
    it { should_not be_installed }
  end
end
