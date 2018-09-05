control "V-73303" do
  title "FTP servers must be configured to prevent anonymous logons."
  desc  "The FTP service allows remote users to access shared files and
  directories. Allowing anonymous FTP connections makes user auditing difficult.

  Using accounts that have administrator privileges to log on to FTP risks
  that the userid and password will be captured on the network and give
  administrator access to an unauthorized user.
  "
  is_ftp_installed = command("Get-WindowsFeature Web-Ftp-Server | Select -Expand Installed").stdout.strip
  if (is_ftp_installed == 'False' || is_ftp_installed == '')
    impact 0.0
  else
    impact 0.5
  end
  tag "gtitle": "SRG-OS-000480-GPOS-00227"
  tag "gid": "V-73303"
  tag "rid": "SV-87955r1_rule"
  tag "stig_id": "WN16-00-000430"
  tag "fix_id": "F-79745r1_fix"
  tag "cci": ["CCI-000366"]
  tag "nist": ["CM-6 b", "Rev_4"]
  tag "documentable": false
  tag "check": "If FTP is not installed on the system, this is NA.

  Open \"Internet Information Services (IIS) Manager\".

  Select the server.

  Double-click \"FTP Authentication\".

  If the \"Anonymous Authentication\" status is \"Enabled\", this is a finding."
  tag "fix": "Configure the FTP service to prevent anonymous logons.

  Open \"Internet Information Services (IIS) Manager\".

  Select the server.

  Double-click \"FTP Authentication\".

  Select \"Anonymous Authentication\".

  Select \"Disabled\" under \"Actions\"."
  describe 'File Transfer Protocol (FTP) servers must be configured to prevent
  anonymous logons' do
    skip "is a manual check"
  end
end
