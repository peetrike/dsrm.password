---
external help file: dsrm.password-help.xml
Module Name: dsrm.password
online version:
schema: 2.0.0
---

# Set-DsrmUser

## SYNOPSIS

Prepares DSRM password sync account for specified DC

## SYNTAX

```
Set-DsrmUser [[-ComputerName] <String>] [[-Prefix] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

{{ Fill in the Description }}

## EXAMPLES

### Example 1

```powershell
Set-DsrmUser
```

{{ Add example description here }}

## PARAMETERS

### -ComputerName

DC name for witch to prepare user

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Prefix

Prefix for user SamAccountName

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

### -WhatIf

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### None

## NOTES

## RELATED LINKS

[Get-DsrmUser](Get-DsrmUser.md)
