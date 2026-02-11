---
external help file: dsrm.password-help.xml
Module Name: dsrm.password
online version:
schema: 2.0.0
---

# Get-DsrmUser

## SYNOPSIS

Returns DSRM password sync account for specified DC

## SYNTAX

```
Get-DsrmUser [[-ComputerName] <String>] [[-Prefix] <String>] [<CommonParameters>]
```

## DESCRIPTION

{{ Fill in the Description }}

## EXAMPLES

### Example 1

```powershell
Get-DsrmUser
```

{{ Add example description here }}

## PARAMETERS

### -ComputerName

DC name for witch to search user

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: current computer
Accept pipeline input: False
Accept wildcard characters: False
```

### -Prefix

User account name prefix

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: DSRM
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### Microsoft.ActiveDirectory.Management.ADUser

## NOTES

## RELATED LINKS
