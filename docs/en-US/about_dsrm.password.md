# dsrm.password

## about_dsrm.password

# SHORT DESCRIPTION

Module to manage DSRM passwords

# LONG DESCRIPTION

This module helps to manage DSRM passwords.

DSRM passwords are synchronized from special user accounts.
Every DC gets its own user account.
The account name is combined from prefix and computer NetBIOS name.
The created DSRM accounts are by default added to
_DENIED RODC Password Replication Group_.
When the DSRM account is for RODC, that account must be removed from the group.

The passwords for DSRM Accounts can be updated using `Set-DsrmPassword` function
or manually.
Password synchronization is performed by `Sync-DsrmPassword` function.


# EXAMPLES

```powershell
Set-DsrmUser -ComputerName myRODC
```

This example creates DSRM account for RODC computer.

```powershell
$Password = Read-Host -AsSecureString -Prompt 'RODC password'
Set-DsrmPassword -ComputerName myRODC -Password $Password
```

This example asks password interactively and then sets the password to DSRM
account for RODC computer.

```powershell
Sync-DsrmPassword
```

This example synchronizes local DSRM password from DSRM account.

# NOTE

When syncing DSRM passwords on RODC-s, ensure that DSRM account passwords are
replicated to desired RODCs.
That needs Password Replication Policy to be modified accordingly.

# TROUBLESHOOTING NOTE

{{ Troubleshooting Placeholder - Warns users of bugs}}

{{ Explains behavior that is likely to change with fixes }}

# SEE ALSO

[DS Restore Mode Password Maintenance](https://techcommunity.microsoft.com/blog/askds/ds-restore-mode-password-maintenance/396102)

{{ You can also list related articles, blogs, and video URLs. }}

# KEYWORDS

{{List alternate names or titles for this topic that readers might use.}}

- {{ Keyword Placeholder }}
- {{ Keyword Placeholder }}
- {{ Keyword Placeholder }}
- {{ Keyword Placeholder }}
