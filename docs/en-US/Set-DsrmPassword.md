---
external help file: dsrm.password-help.xml
Module Name: dsrm.password
online version:
schema: 2.0.0
---

# Set-DsrmPassword

## SYNOPSIS

Changes DSRM account password

## SYNTAX

```
Set-DsrmPassword [-Password] <SecureString> [[-ComputerName] <String>] [[-Prefix] <String>] [-NoEvent]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

This function changes DSRM account password to specified password.

## EXAMPLES

### Example 1

```powershell
$Password = Read-Host -AsSecureString -prompt 'Enter Password'
Set-DsrmPassword -Password $Password
```

Sets DSRM account password to entered one

## PARAMETERS

### -ComputerName

Specifies the computer to which the DSRM account password should be set.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: local computer
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

### -NoEvent

Skip Event log check

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Password

Specifies password to set to DSRM account

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Prefix

DSRM account name prefix

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
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

### System.Boolean

The success status of password set

## NOTES

## RELATED LINKS

[Set-DsrmUser](Set-DsrmUser.md)

[Sync-DsrmPassword](Sync-DsrmPassword.md)
