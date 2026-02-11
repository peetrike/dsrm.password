function Get-DsrmUser {
    # .EXTERNALHELP Module-help.xml
    [CmdletBinding()]
    param (
            [string]
            # computer name for witch to create user
        $ComputerName = $env:COMPUTERNAME,
            [string]
            # prefix for user SamAccountName
        $Prefix = 'DSRM'
    )

    Get-ADUser -Identity ('{0}-{1}' -f $Prefix, $ComputerName)
}
