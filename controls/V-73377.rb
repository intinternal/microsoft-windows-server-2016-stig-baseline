control 'V-73377' do
  title "Domain-created Active Directory Organizational Unit (OU) objects must
have proper access control permissions."
  desc  "When directory service database objects do not have appropriate access
control permissions, it may be possible for malicious users to create, read,
update, or delete the objects and degrade or destroy the integrity of the data.
When the directory service is used for identification, authentication, or
authorization functions, a compromise of the database objects could lead to a
compromise of all systems that rely on the directory service.

    For Active Directory, the OU objects require special attention. In a
distributed administration model (i.e., help desk), OU objects are more likely
to have access permissions changed from the secure defaults. If inappropriate
access permissions are defined for OU objects, it could allow an intruder to
add or delete users in the OU. This could result in unauthorized access to data
or a denial of service to authorized users.
  "
  impact 0.7
  tag "gtitle": 'SRG-OS-000324-GPOS-00125'
  tag "gid": 'V-73377'
  tag "rid": 'SV-88029r1_rule'
  tag "stig_id": 'WN16-DC-000110'
  tag "fix_id": 'F-79819r1_fix'
  tag "cci": ['CCI-002235']
  tag "nist": ['AC-6 (10)', 'Rev_4']
  tag "documentable": false
  tag "check": "This applies to domain controllers. It is NA for other systems.

Review the permissions on domain-defined OUs.

Open Active Directory Users and Computers (available from various menus or
run dsa.msc).

Ensure Advanced Features is selected in the View menu.

For each OU that is defined (folder in folder icon) excluding the Domain
Controllers OU:

Right-click the OU and select Properties.

Select the Security tab.

If the permissions on the OU are not at least as restrictive as those below,
this is a finding.

The permissions shown are at the summary level. More detailed permissions can
be viewed by selecting the Advanced button, the desired Permission entry,
and the Edit or View button.

Except where noted otherwise, the special permissions may include a wide range
of permissions and properties and are acceptable for this requirement.

CREATOR OWNER - Special permissions

Self - Special permissions

Authenticated Users - Read, Special permissions

The Special permissions for Authenticated Users are Read type. If detailed
permissions include any Create, Delete, Modify, or Write Permissions or
Properties, this is a finding.

SYSTEM - Full Control

Domain Admins - Full Control

Enterprise Admins - Full Control

Key Admins - Special permissions

Enterprise Key Admins - Special permissions

Administrators - Read, Write, Create all child objects, Generate resultant set
of policy (logging), Generate resultant set of policy (planning), Special
permissions

Pre-Windows 2000 Compatible Access - Special permissions

The Special permissions for Pre-Windows 2000 Compatible Access are for Read
types. If detailed permissions include any Create, Delete, Modify, or Write
Permissions or Properties, this is a finding.

ENTERPRISE DOMAIN CONTROLLERS - Read, Special permissions

If an ISSO-approved distributed administration model (help desk or other user
support staff) is implemented, permissions above Read may be allowed for groups
documented by the ISSO.

If any OU with improper permissions includes identification or authentication
data (e.g., accounts, passwords, or password hash data) used by systems to
determine access control, the severity is CAT I (e.g., OUs that include user
accounts, including service/application accounts).

If an OU with improper permissions does not include identification and
authentication data used by systems to determine access control, the severity
is CAT II (e.g., Workstation, Printer OUs)."
  tag "fix": "Maintain the permissions on domain-defined OUs to be at least as
restrictive as the defaults below.

Document any additional permissions above Read with the ISSO if an approved
distributed administration model (help desk or other user support staff) is
implemented.

CREATOR OWNER - Special permissions

Self - Special permissions

Authenticated Users - Read, Special permissions

The special permissions for Authenticated Users are Read type.

SYSTEM - Full Control

Domain Admins - Full Control

Enterprise Admins - Full Control

Key Admins - Special permissions

Enterprise Key Admins - Special permissions

Administrators - Read, Write, Create all child objects, Generate resultant set
of policy (logging), Generate resultant set of policy (planning), Special
permissions

Pre-Windows 2000 Compatible Access - Special permissions

The special permissions for Pre-Windows 2000 Compatible Access are for Read
types.

ENTERPRISE DOMAIN CONTROLLERS - Read, Special permissions"':'
  domain_role = command('wmic computersystem get domainrole | Findstr /v DomainRole').stdout.strip
  get_netbiosname = command('Get-ADDomain | Findstr NetBIOSName').stdout.strip
  netbiosname = get_netbiosname[37..-1]
  get_ou = command("Get-ADOrganizationalUnit -LDAPFilter '(name=*)' | Findstr DistinguishedName").stdout.strip
  ou = get_ou[27..70]
  if domain_role == '4' || domain_role == '5'
    describe powershell("Import-Module ActiveDirectory; Get-Acl -Path 'AD:#{ou}' | Fl | Findstr All") do
      its('stdout') { should eq "Access : NT AUTHORITY\\ENTERPRISE DOMAIN CONTROLLERS Allow  \r\n         NT AUTHORITY\\Authenticated Users Allow  \r\n         NT AUTHORITY\\SYSTEM Allow  \r\n         #{netbiosname}\\Domain Admins Allow  \r\n         BUILTIN\\Pre-Windows 2000 Compatible Access Allow  \r\n         BUILTIN\\Pre-Windows 2000 Compatible Access Allow  \r\n         BUILTIN\\Pre-Windows 2000 Compatible Access Allow  \r\n         BUILTIN\\Pre-Windows 2000 Compatible Access Allow  \r\n         BUILTIN\\Pre-Windows 2000 Compatible Access Allow  \r\n         BUILTIN\\Pre-Windows 2000 Compatible Access Allow  \r\n         BUILTIN\\Pre-Windows 2000 Compatible Access Allow  \r\n         BUILTIN\\Pre-Windows 2000 Compatible Access Allow  \r\n         BUILTIN\\Pre-Windows 2000 Compatible Access Allow  \r\n         BUILTIN\\Pre-Windows 2000 Compatible Access Allow  \r\n         #{netbiosname}\\Key Admins Allow  \r\n         #{netbiosname}\\Enterprise Key Admins Allow  \r\n         CREATOR OWNER Allow  \r\n         NT AUTHORITY\\SELF Allow  \r\n         NT AUTHORITY\\ENTERPRISE DOMAIN CONTROLLERS Allow  \r\n         NT AUTHORITY\\ENTERPRISE DOMAIN CONTROLLERS Allow  \r\n         NT AUTHORITY\\ENTERPRISE DOMAIN CONTROLLERS Allow  \r\n         NT AUTHORITY\\SELF Allow  \r\n         BUILTIN\\Pre-Windows 2000 Compatible Access Allow  \r\n         BUILTIN\\Pre-Windows 2000 Compatible Access Allow  \r\n         BUILTIN\\Pre-Windows 2000 Compatible Access Allow  \r\n         NT AUTHORITY\\SELF Allow  \r\n         NT AUTHORITY\\SELF Allow  \r\n         #{netbiosname}\\Enterprise Admins Allow  \r\n         BUILTIN\\Pre-Windows 2000 Compatible Access Allow  \r\n         BUILTIN\\Administrators Allow  \r\n" }
    end
  end

  if !domain_role == '4' && !domain_role == '5'
    impact 0.0
    desc 'This system is not a domain controller, therefore this control is not applicable as it only applies to domain controllers'
    describe 'This system is not a domain controller, therefore this control is not applicable as it only applies to domain controllers' do
      skip 'This system is not a domain controller, therefore this control is not applicable as it only applies to domain controllers'
    end
  end 
end
