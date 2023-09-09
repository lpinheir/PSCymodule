# PSCymodule.psd1

# Module manifest for module 'PSCymodule'

@{
    RootModule = 'PSCymodule.psm1'
    ModuleVersion = '1.0'
    GUID = 'a7d61322-1369-4feb-b8cb-ea9a91774267'
    Author = 'Lucas M. Pinheiro'
    CompanyName = 'Cymulate'
    Copyright = ''
    Description = 'A PowerShell module for interacting with the Cymulate API.'
    PrivateData = @{
        PSData = @{
            Tags = @('Cymulate', 'API', 'Security')
            LicenseUri = ''
            ProjectUri = ''
            ReleaseNotes = 'Initial release.'
        }
    }
    FunctionsToExport = @( 'Connect-CymApi', 'Get-PSCymHelp', 'Get-CymFindings', 'Get-CymScores', 'Get-CymEnvironments', 'Get-CymIMTioc' )
    FormatsToProcess = @()
    TypesToProcess = @()
    NestedModules = @()
    AliasesToExport = @()
    VariablesToExport = @()
    CmdletsToExport = @()
}
