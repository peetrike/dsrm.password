---
external help file: dsrm.password-help.xml
Module Name: dsrm.password
online version:
schema: 2.0.0
---

# Sync-DsrmPassword

## SYNOPSIS

Synchronizes DSRM password from DSRM account

## SYNTAX

```
Sync-DsrmPassword [[-Prefix] <String>] [-NoEvent] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

This function takes password from DSRM account and uses it as DSRM password for 
local computer.

The DSRM account name is formed from prefix and computer NetBIOS name
(contents of **COMPUTERNAME** environment variable).

## EXAMPLES

### Example 1

```powershell
Sync-DsrmPassword
```

This example synchronizes local DSRM password from DSRM account

## PARAMETERS

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

### -Prefix

DSRM Account name prefix

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
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

Password sync status

## NOTES

## RELATED LINKS

[Set-DsrmPassword](Set-DsrmPassword.md)

[Set-DsrmUser](Set-DsrmUser.md)
