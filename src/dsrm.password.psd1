@{
    RootModule        = 'dsrm.password.psm1'
    ModuleVersion     = '0.0.1'

    GUID              = 'f77e3616-8dab-4a39-919b-26247a6604bb'

    Author            = 'Peter Wawa'
    #CompanyName       = 'Unknown'
    Copyright         = 'Copyright (c) 2026 Peter Wawa'

    Description       = 'Module to manage DSRM password'

    # Minimum version of the Windows PowerShell engine required by this module
    PowerShellVersion = '4.0'

    <# CompatiblePSEditions = @(
        'Core'
        'Desktop'
    ) #>

    # Modules that must be imported into the global environment prior to importing this module
    # RequiredModules = @()

    # Assemblies that must be loaded prior to importing this module
    # RequiredAssemblies = @('bin\dsrm.password.dll')

    # Script files (.ps1) that are run in the caller's environment prior to importing this module.
    # ScriptsToProcess = @()

    # Type files (.ps1xml) to be loaded when importing this module
    # Expensive for import time, no more than one should be used.
    # TypesToProcess = @('dsrm.password.Types.ps1xml')

    # Format files (.ps1xml) to be loaded when importing this module.
    # Expensive for import time, no more than one should be used.
    # FormatsToProcess = @('dsrm.password.Format.ps1xml')

    # Functions to export from this module
    FunctionsToExport = @()

    CmdletsToExport   = @()
    VariablesToExport = @()
    AliasesToExport   = @()

    # DSC resources to export from this module
    # DscResourcesToExport = @()

    # List of all files packaged with this module
    # FileList          = @()

    PrivateData       = @{
        PSData = @{
            Tags         = @(
                'Windows'
                'PSedition_Core'
                'PSedition_Desktop'
            )

            LicenseUri   = 'https://github.com/peetrike/dsrm.password/blob/main/LICENSE'
            ProjectUri   = 'https://github.com/peetrike/dsrm.password/'
            # IconUri      = ''

            ReleaseNotes = 'https://github.com/peetrike/dsrm.password/blob/main/CHANGELOG.md'

            # Prerelease string of this module
            # Prerelease   = ''

            # Flag to indicate whether the module requires explicit user acceptance for install/update/save
            # RequireLicenseAcceptance = $false

            # External dependent modules of this module
            # ExternalModuleDependencies = @()
        }
    }
}
