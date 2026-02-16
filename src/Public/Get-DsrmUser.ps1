function Get-DsrmUser {
    # .EXTERNALHELP Module-help.xml
    [OutputType("Microsoft.ActiveDirectory.Management.ADUser")]
    [CmdletBinding()]
    param (
            [string]
        $ComputerName = $env:COMPUTERNAME,
            [string]
        $Prefix = 'DSRM'
    )

    Get-ADUser -Identity ('{0}-{1}' -f $Prefix, $ComputerName)
}
