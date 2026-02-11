function Set-DsrmUser {
    # .EXTERNALHELP Module-help.xml
    #[Alias('alias')]
    [OutputType([void])]
    [CmdletBinding(
        SupportsShouldProcess
    )]
    param (
            [string]
            # computer name for witch to create user
        $ComputerName = $env:COMPUTERNAME,
            [string]
            # prefix for user SamAccountName
        $Prefix = 'DSRM'
    )

    function Get-RandomString {
        [OutputType([string])]
        [CmdletBinding()]
        param (
                [int]
            $Length = 8,
                [char[]]
            $Number = (48..57 | ForEach-Object { [char]$_ }),
                [char[]]
            $Letter = (97..122 | ForEach-Object { [char]$_ }),
                [char[]]
            $Capital = (65..90 | ForEach-Object { [char]$_ }),
                [char[]]
            $Symbol = (33, 35, 36, 37, 40, 41, 43, 45, 46, 58, 64 | ForEach-Object { [char]$_ })
        )

        $table = @{
            Capital = $Capital
            Letter  = $Letter
            Number  = $Number
            Symbol  = $Symbol
        }
        $AllSymbol = $Number + $Letter + $Capital + $Symbol

        -join @(
            foreach ($key in $table.Keys | Get-Random -Count 4) { Get-Random -InputObject $table.$key }

            for ($i = 5; $i -le $Length; $i++) {
                Get-Random -InputObject $AllSymbol
            }
        )
    }

    $DC = Get-ADDomainController -Identity $ComputerName
    if ($dc.IsReadOnly) {
        Write-Error -Message 'Not supported on RODC'
        return
    }

    $UserName = '{0}-{1}' -f $Prefix, $ComputerName
    try {
        $DsrmUser = Get-ADUser -Identity $UserName -ErrorAction Stop
    } catch {
        $RandomString = Get-RandomString -Length 64
        $newADUserSplat = @{
            Name            = $UserName
            Description     = 'DSRM password automation account'
            AccountPassword = ConvertTo-SecureString -String $RandomString -AsPlainText -Force
            PassThru        = $true
        }
        $DsrmUser = New-ADUser @newADUserSplat
    }

    if ($PSCmdlet.ShouldProcess($DsrmUser, 'Set user properties')) {
        $setADUserSplat = @{
            Identity               = $DsrmUser
            Enabled                = $false
            SmartcardLogonRequired = $false
            AccountNotDelegated    = $true
            CannotChangePassword   = $true
            PasswordNeverExpires   = $true
        }
        Set-ADUser @setADUserSplat -Confirm:$false
        Clear-ADAccountExpiration -Identity $DsrmUser -Confirm:$false

        $DomainObject = [DirectoryServices.ActiveDirectory.Domain]::GetComputerDomain()
        $DomainSid = New-Object -TypeName Security.Principal.SecurityIdentifier -ArgumentList (
            $DomainObject.GetDirectoryEntry().objectSID[0],
            0
        )

        Write-Verbose -Message ('Check group membership: {0}' -f $DsrmUser)
        $DomainGuestsSid = ('{0}-514' -f $DomainSid)
        $UserGroupList = Get-ADPrincipalGroupMembership -Identity $DsrmUser
        if ($UserGroupList.Sid -like $DomainGuestsSid) {
            Write-Verbose -Message 'User already in Domain Guests'
        } else {
            Add-ADGroupMember -Identity ('{0}-514' -f $DomainSid) -Members $DsrmUser -Confirm:$false
        }
        Set-ADUser -Identity $DsrmUser -Replace @{ primaryGroupID = 514 } -Confirm:$false
        Remove-ADGroupMember -Identity ('{0}-513' -f $DomainSid) -Members $DsrmUser -Confirm:$false

        Add-ADGroupMember -Identity ('{0}-572' -f $DomainSid) -Members $DsrmUser -Confirm:$false
    }
}
