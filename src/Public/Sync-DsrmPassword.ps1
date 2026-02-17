function Sync-DsrmPassword {
    # .EXTERNALHELP Module-help.xml
    [OutputType([bool])]
    [CmdletBinding(
        SupportsShouldProcess
    )]
    param (
            [string]
        $Prefix = 'DSRM'
    )

    $UserName = '{0}-{1}' -f $Prefix, $env:COMPUTERNAME
    $DsrmUser = Get-ADUser -Identity $UserName -ErrorAction Stop

    if ($PSCmdlet.ShouldProcess($env:COMPUTERNAME, 'Sync DSRM Password')) {
        $result = ntdsutil.exe 'set dsrm password' "sync from domain account $UserName" q q
        Write-Verbose -Message ("{0}`n{1}" -f $result[1], $result[2])

            # get the resulting event
        Start-Sleep -Seconds 3
        $query = @(
            'System[(EventID = 4794) and TimeCreated[timediff(@SystemTime) <= {0}]]' -f 60000
            'EventData[Data[@Name="Workstation"] = "{0}"]' -f $env:COMPUTERNAME
        ) -join ' and '
        $xPathQuery = '*[{0}]' -f $query
        $EventRecord = Get-WinEvent -LogName Security -FilterXPath $xPathQuery -MaxEvents 1
        $XmlEvent = [xml] $EventRecord.ToXml()
        return $XmlEvent.SelectSingleNode('//*[@Name="Status"]').InnerText -eq '0x0'
    }
}
