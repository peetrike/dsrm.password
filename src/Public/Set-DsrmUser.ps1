function Set-DsrmUser {
    # .EXTERNALHELP Module-help.xml
    [OutputType([void])]
    [CmdletBinding(
        SupportsShouldProcess
    )]
    param (
            [string]
        $ComputerName = $env:COMPUTERNAME,
            [string]
        $Prefix = 'DSRM'
    )

    function Get-RandomString {
        [OutputType([string])]
        [CmdletBinding()]
        param (
                [int]
            $Length = 64,
                [char[]]
            $Number = ('0123456789'.ToCharArray()),
                [char[]]
            $Letter = ('abcdefghijklmnopqrstuvwxyz'.ToCharArray()),
                [char[]]
            $Capital = ('ABCDEFGHIJKLMNOPQRSTUVWXYZ'.ToCharArray()),
                [char[]]
            $Symbol = ('!#%+@:=?*'.ToCharArray())
        )

        $table = @{
            Capital = $Capital
            Letter  = $Letter
            Number  = $Number
            Symbol  = $Symbol
        }
        $AllSymbol = $Number + $Letter + $Capital + $Symbol

        -join @(
            for ($i = 5; $i -le $Length; $i++) {
                Get-Random -InputObject $AllSymbol
            }
            foreach ($key in $table.Keys | Get-Random -Count 4) { Get-Random -InputObject $table.$key }
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
        Write-Verbose -Message ('Creating user: {0}' -f $UserName)
        $Password = Get-RandomString | ConvertTo-SecureString -AsPlainText -Force
        $newADUserSplat = @{
            Name            = $UserName
            Description     = 'DSRM password automation account'
            AccountPassword = $Password
            PassThru        = $true
        }
        $DsrmUser = New-ADUser @newADUserSplat
    }

    if ($PSCmdlet.ShouldProcess($DsrmUser, 'Set user properties')) {
        $setADUserSplat = @{
            Enabled                = $false
            SmartcardLogonRequired = $false
            AccountNotDelegated    = $true
            CannotChangePassword   = $true
            PasswordNeverExpires   = $true
        }
        Set-ADUser -Identity $DsrmUser @setADUserSplat -Confirm:$false
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
            Add-ADGroupMember -Identity $DomainGuestsSid -Members $DsrmUser -Confirm:$false
        }
        Set-ADUser -Identity $DsrmUser -Replace @{ primaryGroupID = 514 } -Confirm:$false
            # remove user from Domain Users
        Remove-ADGroupMember -Identity ('{0}-513' -f $DomainSid) -Members $DsrmUser -Confirm:$false
            # Add user to DENIED RODC Password Replication Group
        Add-ADGroupMember -Identity ('{0}-572' -f $DomainSid) -Members $DsrmUser -Confirm:$false
    }
}
