function Set-DsrmPassword {
    # .EXTERNALHELP Module-help.xml
    [OutputType([bool])]
    [CmdletBinding(
        SupportsShouldProcess
    )]
    param (
            [Parameter(Mandatory)]
            [securestring]
        $Password,
            [string]
        $ComputerName = $env:COMPUTERNAME,
            [string]
        $Prefix = 'DSRM'
    )

    $DC = Get-ADDomainController -Identity $env:COMPUTERNAME
    if ($DC.IsReadOnly) {
        Write-Error -Message 'Not supported on RODC'
        return
    }

    $UserName = '{0}-{1}' -f $Prefix, $ComputerName
    $DsrmUser = Get-ADUser -Identity $UserName -ErrorAction Stop

    if ($PSCmdlet.ShouldProcess($DsrmUser, 'Reset password')) {
        Set-ADAccountPassword -Identity $DsrmUser -NewPassword $Password -Reset -ErrorAction Stop -Confirm:$false

            # get the resulting event
        Start-Sleep -Seconds 3
        Write-Verbose 'Checking password change event (4724)'
        $query = @(
            'System[(EventID = 4724) and TimeCreated[timediff(@SystemTime) <= {0}]]' -f 60000
            'EventData[Data[@Name="TargetUserName"] = "{0}"]' -f $UserName
        ) -join ' and '
        $xPathQuery = '*[{0}]' -f $query
        $EventRecord = Get-WinEvent -LogName Security -FilterXPath $xPathQuery -MaxEvents 1
        return (0, 4 -contains $EventRecord.Level)
    }
}
