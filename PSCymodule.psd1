# Module manifest for PSCymodule

# Script module or binary module file associated with this manifest
ModuleToProcess = 'PSCymodule.psm1'

# Version number of this module.
ModuleVersion = '1.0.0'

# ID used to uniquely identify this module
GUID = 'a7d61322-1369-4feb-b8cb-ea9a91774267'

# Author of this module
Author = 'Lucas M. Pinheiro'

# Description of the functionality provided by this module
Description = 'PowerShell module for interacting with Cymulate platform.'

# Minimum version of PowerShell required to run this module
PowerShellVersion = '5.1'

# Functions to export from this module
FunctionsToExport = 'Connect-CymApi', 'Get-CymFindings', 'Get-CymScores', 'Get-CymEnvironments', 'Get-CymIMTioc'

# Private data to pass to the module specified in RootModule/ModuleToProcess
PrivateData = @{
    PSData = @{
        # Tags applied to this module
        Tags = @()

        # A URL to the license for this module
        LicenseUri = ''

        # A URL to the main website for this project
        ProjectUri = ''

        # IconUri - URI to the module's icon
        IconUri = ''

        # ReleaseNotes - release notes for this module
        ReleaseNotes = ''
    } # End of PSData hashtable
} # End of PrivateData hashtable
