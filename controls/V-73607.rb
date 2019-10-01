control 'V-73607' do
  title "The DoD Interoperability Root CA cross-certificates must be installed
  in the Untrusted Certificates Store on unclassified systems."
  desc "To ensure users do not experience denial of service when performing
  certificate-based authentication to DoD websites due to the system chaining to
  a root other than DoD Root CAs, the DoD Interoperability Root CA
  cross-certificates must be installed in the Untrusted Certificate Store. This
  requirement only applies to unclassified systems."
  impact 0.5
  tag "gtitle": 'SRG-OS-000066-GPOS-00034'
  tag "satisfies": ['SRG-OS-000066-GPOS-00034', 'SRG-OS-000403-GPOS-00182']
  tag "gid": 'V-73607'
  tag "rid": 'SV-88271r2_rule'
  tag "stig_id": 'WN16-PK-000020'
  tag "fix_id": 'F-87313r2_fix'
  tag "cci": ['CCI-000185', 'CCI-002470']
  tag "nist": ['IA-5 (2) (a)', 'Rev_4']
  tag "nist": ['SC-23 (5)', 'Rev_4']
  tag "documentable": false
  tag "check": "This is applicable to unclassified systems. It is NA for others.

  Open PowerShell as an administrator.

  Execute the following command:

  Get-ChildItem -Path Cert:Localmachine\\disallowed | Where {$_.Issuer -Like
  *DoD Interoperability* -and $_.Subject -Like *DoD*} | FL Subject,
  Issuer, Thumbprint, NotAfter

  If the following certificate Subject, Issuer, and Thumbprint
  information is not displayed, this is finding.

  If an expired certificate (NotAfter date) is not listed in the results,
  this is not a finding.

  Subject: CN=DoD Root CA 2, OU=PKI, OU=DoD, O=U.S. Government, C=US
  Issuer: CN=DoD Interoperability Root CA 1, OU=PKI, OU=DoD, O=U.S. Government,
  C=US
  Thumbprint: 22BBE981F0694D246CC1472ED2B021DC8540A22F
  NotAfter: 9/6/2019

  Subject: CN=DoD Root CA 3, OU=PKI, OU=DoD, O=U.S. Government, C=US
  Issuer: CN=DoD Interoperability Root CA 2, OU=PKI, OU=DoD, O=U.S. Government,
  C=US
  Thumbprint: FFAD03329B9E527A43EEC66A56F9CBB5393E6E13
  NotAfter: 9/23/2018

  Subject: CN=DoD Root CA 3, OU=PKI, OU=DoD, O=U.S. Government, C=US
  Issuer: CN=DoD Interoperability Root CA 2, OU=PKI, OU=DoD, O=U.S. Government,
  C=US
  Thumbprint: FCE1B1E25374DD94F5935BEB86CA643D8C8D1FF4
  NotAfter: 2/17/2019

  Alternately, use the Certificates MMC snap-in:

  Run MMC.

  Select File, Add/Remove Snap-in.

  Select Certificates and click Add.

  Select Computer account and click Next.

  Select Local computer: (the computer this console is running on) and click
  Finish.

  Click OK.

  Expand Certificates and navigate to Untrusted Certificates >>
  Certificates.

  For each certificate with DoD Root CA… under Issued To and DoD
  Interoperability Root CA… under Issued By:

  Right-click on the certificate and select Open.

  Select the Details Tab.

  Scroll to the bottom and select Thumbprint.

  If the certificates below are not listed or the value for the Thumbprint
  field is not as noted, this is a finding.

  If an expired certificate (Valid to date) is not listed in the results,
  this is not a finding.

  Issued To: DoD Root CA 2
  Issued By: DoD Interoperability Root CA 1
  Thumbprint: 22BBE981F0694D246CC1472ED2B021DC8540A22F
  Valid to: Friday, September 6, 2019

  Issued To: DoD Root CA 3
  Issued By: DoD Interoperability Root CA 2
  Thumbprint: FFAD03329B9E527A43EEC66A56F9CBB5393E6E13
  Valid to: Sunday, September 23, 2018

  Issued To: DoD Root CA 3
  Issued By: DoD Interoperability Root CA 2
  Thumbprint: FCE1B1E25374DD94F5935BEB86CA643D8C8D1FF4
  Valid to: Sunday, February 17, 2019"
  tag "fix": "Install the DoD Interoperability Root CA cross-certificates on
  unclassified systems.

  Issued To - Issued By - Thumbprint
  DoD Root CA 2 - DoD Interoperability Root CA 1 -
  22BBE981F0694D246CC1472ED2B021DC8540A22F

  DoD Root CA 3 - DoD Interoperability Root CA 2 -
  FFAD03329B9E527A43EEC66A56F9CBB5393E6E13

  DoD Root CA 3 - DoD Interoperability Root CA 2 -
  FCE1B1E25374DD94F5935BEB86CA643D8C8D1FF4

  Administrators should run the Federal Bridge Certification Authority (FBCA)
  Cross-Certificate Removal Tool once as an administrator and once as the current
  user.

  The FBCA Cross-Certificate Remover Tool and User Guide are available on IASE at
  http://iase.disa.mil/pki-pke/Pages/tools.aspx."
  query = 'Get-ChildItem -Path Cert:Localmachine\\\\disallowed | Where {$_.Issuer -Like "*DoD Interoperability*" -and $_.Subject -Like "*DoD*"} | ConvertTo-Json'
  # describe 'The DoD Interoperability Root CA cross-certificates installed' do
    # subject { command('Get-ChildItem -Path Cert:Localmachine\\\\disallowed | Where {$_.Issuer -Like
    # "*DoD Interoperability*" -and $_.Subject -Like "*DoD*"} | FL Subject,
    # Issuer, Thumbprint, NotAfter').stdout }
    # it  { should eq "\r\n\r\nSubject    : CN=DoD Root CA 2, OU=PKI, OU=DoD, O=U.S. Government, C=US\r\nIssuer     : CN=DoD Interoperability Root CA 1, OU=PKI, OU=DoD, O=U.S. Government, C=US\r\nThumbprint : 22BBE981F0694D246CC1472ED2B021DC8540A22F\r\n\r\nSubject    : CN=DoD Root CA 3, OU=PKI, OU=DoD, O=U.S. Government, C=US\r\nIssuer     : CN=DoD Interoperability Root CA 2, OU=PKI, OU=DoD, O=U.S. Government, C=US\r\nThumbprint : FFAD03329B9E527A43EEC66A56F9CBB5393E6E13\r\n\r\nSubject    : CN=DoD Root CA 3, OU=PKI, OU=DoD, O=U.S. Government, C=US\r\nIssuer     : CN=DoD Interoperability Root CA 2, OU=PKI, OU=DoD, O=U.S. Government, C=US\r\nThumbprint : FCE1B1E25374DD94F5935BEB86CA643D8C8D1FF4\r\n\r\n\r\n\r\n" }
  # end
  describe json({ command: query }) do
    its([1]) { should cmp 'temp' }
  end
end
