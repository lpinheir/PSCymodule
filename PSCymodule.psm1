# PSCymodule.psm1

# Default API key (you can replace this with your actual default API key)
$global:defaultApiKey = $null

# Base URL for the API
$baseUrl = "https://api.app.cymulate.com/v1/"

# Function to set the API key
function Connect-CymApi {
    param (
        [string]$ApiKey
    )

    # Set the provided API key as the global default
    $global:defaultApiKey = $ApiKey
}

# Function to make a generic API call
function Invoke-ApiCall {
    param (
        [string]$Endpoint,
        [string]$QueryString
    )

    # Authenticate using the default API key
    $authToken = $global:defaultApiKey

    # If the API key is not set, raise an error
    if ($authToken -eq $null) {
        throw "API key not set. Please run 'Connect-CymApi -ApiKey your_api_key_here'  to set the API key."
    }

    # Construct the complete API URL
    $apiUrl = $baseUrl + $Endpoint + "$QueryString"
    Write-Host $apiUrl

    # Create headers with the x-token
    $headers = @{
        "x-token" = $authToken
    }

    try {
        # Make API call with headers
        $response = Invoke-RestMethod -Uri $apiUrl -Headers $headers -Method GET
        return $response
    }
    catch {
        throw "API call failed: $_"
    }
}
function Get-PSCymHelp {
    $CustomHelpMessage = @"
=======================================================
Cymulate PowerShell API Integration - Command Help
=======================================================

This script provides help and usage information for Cymulate API integration cmdlets.

1. `Connect-CymApi` - Set Cymulate API Key
---------------------------------------------------
This function allows you to set your Cymulate API key for authentication.

Usage:
Connect-CymApi -ApiKey <your_api_key>
Connect-CymApi -Help

2. `Get-CymFindings` - Retrieve Security Findings
---------------------------------------------------
Retrieve security findings from the Cymulate platform based on various filters.

Usage:
Get-CymFindings [-module <module>] [-limit <limit>] [-name <name>] [-clientID <clientID>] [-agentUserID <agentUserID>] [-aptGroups <aptGroups>] [-softwares <softwares>] [-tactics <tactics>] [-techniques <techniques>] [-securityControl <securityControl>] [-risk <risk>] [-os <os>] [-prevStatus <prevStatus>] [-status <status>] [-type <type>] [-testCase <testCase>] [-date]
Get-CymFindings -Help

For data range (if -date is specified):
Get-CymFindings -module <module> -limit <limit> -name <name> -date
Enter dateFrom (YYYY-MM-DD): <date_from>
Enter dateTo (YYYY-MM-DD): <date_to>

3. `Get-CymScores` - Retrieve Security Scores
---------------------------------------------------
Retrieve security scores for your Cymulate environment.

Usage:
Get-CymScores -setenv <environment_id>
Get-CymScores -Help

Tip: To find your environment ID, run Get-CymEnvironments.

4. `Get-CymEnvironments` - List Available Environments
---------------------------------------------------
List available environments in your Cymulate account.

Usage:
Get-CymEnvironments
Get-CymEnvironments -Help

5. `Get-CymIMTioc` - Retrieve Immediate Threat Intelligence
---------------------------------------------------
Retrieve immediate threat intelligence data with filters.

Usage:
Get-CymIMTioc -setpath <output_path> -fromdate <from_date> -todate <to_date> [-NameFilter <name_filter>] [-MD5Filter <md5_filter>] [-StatusFilter <status_filter>]

Example:
Get-CymIMTioc -fromdate 2023-01-10 -todate 2023-05-10 -MD5Filter <md5_hash_here>
Get-CymIMTioc -Help

For more information and detailed examples, refer to the documentation..
"@

    Write-Host $CustomHelpMessage
}

function Get-CymFindings {
    [CmdletBinding()]
    param (
        [string]$module,
        [int]$limit = 25,
        [string]$name,
        [string]$clientID,
        [string]$agentUserID,
        [string]$aptGroups,
        [string]$softwares,
        [string]$tactics,
        [string]$techniques,
        [string]$setpath = $env:TEMP,
        [string]$securityControl,
        [string]$risk,
        [string]$os,
        [string]$prevStatus,
        [string]$status,
        [string]$type,
        [string]$testCase,
        #[string]$apikey,
        [switch]$date,
        [switch]$HelpMessage
    )

    if ($date) {
        $dateFrom = Read-Host "Enter dateFrom (YYYY-MM-DD):"
        $dateTo = Read-Host "Enter dateTo (YYYY-MM-DD):"
    }

    # Define a custom help message scriptblock
    $CustomHelpMessage = {
        Write-Host @"
DESCRIPTION:
This script connects to the Cymulate API and retrieves findings based on specified filters.

Usage:
Get-CymFindings [-module <module>] [-limit <limit>] [-name <name>] [-clientID <clientID>] [-agentUserID <agentUserID>] [-aptGroups <aptGroups>] [-softwares <softwares>] [-tactics <tactics>] [-techniques <techniques>] [-securityControl <securityControl>] [-risk <risk>] [-os <os>] [-prevStatus <prevStatus>] [-status <status>] [-type <type>] [-testCase <testCase>] [-?]

FILTERS:

-module        : Filter by module.
-limit         : Limit the number of results (default is 25 max 250).
-name          : Filter by name.
-clientID      : Filter by client ID.
-agentUserID   : Filter by agent user ID.
-aptGroups     : Filter by APT groups.
-softwares     : Filter by software.
-tactics       : Filter by tactics.
-techniques    : Filter by techniques.
-env           : Filter by environment ID.
-securityControl : Filter by security control.
-risk          : Filter by risk.
-os            : Filter by operating system.
-prevStatus    : Filter by previous status.
-status        : Filter by status.
-setpath       : Set the path to save your CSV File.
-type          : Filter by type.

-help            : Show this help message.

Usage:
Get-CymFindings -module immediateThreats -limit 40 -name teste

For data range:
-date          : Findings from the data range

Usage:
Get-CymFindings -module immediateThreats -limit 40 -name teste -date
Enter dateFrom (YYYY-MM-DD):: 2023-06-07
Enter dateTo (YYYY-MM-DD):: 2023-06-25

"@
    }

    # Check for the -? argument (Custom Help)
    if ($HelpMessage) {
        & $CustomHelpMessage
        return
    }

    $Endpoint = "findings/?skip=0&limit=$limit"
    $QueryString = ""

    # Define parameters as a hashtable
    $params = @{
        "module" = $module
        "name" = $name
        "clientID" = $clientID
        "agentUserID" = $agentUserID
        "aptGroups" = $aptGroups
        "softwares" = $softwares
        "tactics" = $tactics
        "techniques" = $techniques
        "securityControl" = $securityControl
        "risk" = $risk
        "os" = $os
        "prevStatus" = $prevStatus
        "status" = $status
        "type" = $type
        "testCase" = $testCase
    }

    if ($date) {
        $params["dateFrom"] = $dateFrom
        $params["dateTo"] = $dateTo
    }

    # Construct the query string based on parameters
    $QueryString = Construct-QueryString -params $params

    try {
        # Make the API request
        $response = Invoke-ApiCall -Endpoint $Endpoint -QueryString $QueryString

        # Flatten the nested properties and format them for CSV
        $csvData = $response.data.items | ForEach-Object {
            [PSCustomObject]@{
                "_id" = $_."_id"
                "lastUpdated" = $_.lastUpdated
                "testCase" = $_.testCase
                "module" = $_.module
                "type" = $_.type
                "resource" = $_.resource
                "date" = $_.date
                "status" = $_.status
                "prevStatus" = $_.prevStatus
                "os" = ($_.os -join ', ')
                "techniques" = ($_.techniques | ForEach-Object { $_.name }) -join ', '
                "tactics" = ($_.tactics | ForEach-Object { $_.name }) -join ', '
                "aptGroups" = ($_.aptGroups | ForEach-Object { $_.label }) -join ', '
                "softwares" = ($_.softwares | ForEach-Object { $_.label }) -join ', '
                "risk" = $_.risk
                "cve" = ($_.cve -join ', ')
                "asset" = $_.asset
                "assessmentName" = $_.assessmentName
                "env" = $_.env
                "clientID" = $_.clientID
                "attackID" = $_.attackID
                "latest" = $_.latest
                "validated" = $_.validated
                "tags" = ($_.tags -join ', ')
                "agentUserID" = $_.agentUserID
                "attackPayloadID" = $_.attackPayloadID
                "affectedAsset" = $_.affectedAsset
                "securityControl" = ($_.securityControl -join ', ')
                "platforms" = ($_.platforms -join ', ')
                "mitigations" = ($_.mitigations -join ', ')
                "updated" = $_.updated
                "createdAt" = $_.createdAt
                "created" = $_.created
                "realModule" = $_.realModule
                "realClientID" = $_.realClientID
                "displayId" = $_.displayId
                "ticketStatus" = $_.ticketStatus
                "ticketId" = $_.ticketId
                "testCaseDescription" = $_.testCaseDescription
                "hasTicketingSystemActive" = $_.hasTicketingSystemActive
            }
        }
        
        # Display the data as a table
        $csvData | Format-Table -AutoSize -Property *
        
        # Export the data to a CSV file
        if ($setpath) {
            $csvData | Export-Csv -Path "$setpath\Cym_Findings_data.csv" -NoTypeInformation
            Write-Host "Data exported to $setpath\Cym_Findings_data.csv"
        }

    }
    catch {
        Write-Host "An error occurred: $_"
    }
}
function Get-CymScores {
    [CmdletBinding()]
    param (
        [string]$setenv,
        [string]$setpath = $env:TEMP ,
        [switch]$HelpMessage
    )

    # Define a custom help message scriptblock
    $CustomHelpMessage = {
        Write-Host @"
DESCRIPTION:

Usage:
Get-CymScores -setenv your_environment_id_here

Tip: If you need to find your env id please run Get-CymEnvironments


"@
    }

    # Check for the -? argument (Custom Help)
    if ($HelpMessage) {
        & $CustomHelpMessage
        return
    }

    $Endpoint = "user/scores"
    $QueryString = ""
    $Headers = @{
        "x-token" = $global:defaultApiKey  # Replace with your actual API token
    }

    # Define parameters as a hashtable
    $params = @{
        "env" = $env
        
    }

    # Construct the query string based on parameters
    $QueryString = Construct-QueryString -params $params

    # Append the 'env' parameter to the query string
    $QueryString += "env=$($setenv)"

    try {
        # Check if the response contains the expected structure
        if ($global:defaultApiKey -eq $null) {
            throw "API key not set. Please run 'Connect-CymApi -ApiKey your_api_key_here' to set the API key."
        }
        # Make the API request using Invoke-RestMethod
        $response = Invoke-RestMethod -Uri "https://api.app.cymulate.com/v1/$Endpoint/?$QueryString" -Headers $Headers

        if ($response.success -and $response.data.Count -gt 0) {
            # Extract and display specific values as a table
            $data = $response.data[0]

            # Create a custom object with properties
            $customObject = [PSCustomObject]@{
                'Metric' = 'Total Score', 'Web Application Firewall Score', 'Email Gateway Score', 'Web Gateway Score', 'Exfiltration Score',
                           'Endpoint Score', 'Hopper Score', 'Immediate Threats Score', 'Phishing Score', 'Kill Chain APT Scenarios Score',
                           'Kill Chain APT Campaign Score', 'Recon Score'
            }

            $values = $data.Total_Score, $data.Web_Application_Firewall_Score, $data.Email_Gateway_Score, $data.Web_Gateway_Score,
                      $data.Exfiltration_Score, $data.Endpoint_Score, $data.Hopper_Score, $data.Immediate_Threats_Score,
                      $data.Phishing_Score, $data.Kill_Chain_APT_Scenarios_Score, $data.Kill_Chain_APT_Campaign_Score, $data.Recon_Score

            $table = @()

            for ($i = 0; $i -lt $customObject.Metric.Count; $i++) {
                $table += [PSCustomObject]@{
                    'Metric' = $customObject.Metric[$i]
                    'Value' = $values[$i]
                }
            }

            # Display the table on the screen vertically
            $table | Format-Table -Property Metric, Value -AutoSize

            # Export the custom objects to a CSV file
            $table | Export-Csv -Path "$setpath\Cym_Env_Scores.csv" -NoTypeInformation

            Write-Host "CSV file saved successfully at $setpath."
        } else {
            Write-Host "Invalid or empty response."
        }
    }
    catch {
        Write-Host "An error occurred: $_"
    }
}

function Get-CymEnvironments {
    [CmdletBinding()]
    param (
        [string]$setenv,
        [switch]$HelpMessage
    )

    # Define a custom help message scriptblock
    $CustomHelpMessage = {
        Write-Host @"
DESCRIPTION:
Usage:
Get-CymEnvironments


"@
    }

    # Check for the -? argument (Custom Help)
    if ($HelpMessage) {
        & $CustomHelpMessage
        return
    }

    $Headers = @{
        "x-token" = $global:defaultApiKey  # Replace with your actual API token
    }
    
    try {
        # Check if the response contains the expected structure
        if ($global:defaultApiKey -eq $null) {
            throw "API key not set. Please run 'Connect-CymApi -ApiKey your_api_key_here'  to set the API key."
        }
        # Make the API request using Invoke-RestMethod
        $response = Invoke-RestMethod -Uri "https://api.app.cymulate.com/v1/environments/" -Headers $Headers

        # Check if the response contains the expected structure
        if ($response.success -and $response.data.Count -gt 0) {
            # Iterate through the data array and display each item
            foreach ($dataItem in $response.data) {
                $table = @{
                    'Environment ID' = $dataItem.id
                    'Environment Name' = $dataItem.name
                }

                $table | Format-Table -AutoSize
            }
        } else {
            Write-Host "Invalid or empty response."
        }
    }
    catch {
        Write-Host "An error occurred: $_"
    }    
    
}
function Get-CymIMTioc {
    [CmdletBinding()]
    param (
        [string]$setpath,
        [string]$fromdate,
        [string]$todate,
        [string]$NameFilter,
        [string]$MD5Filter,
        [string]$StatusFilter
    )

    # Define a custom help message scriptblock
    $CustomHelpMessage = {
        Write-Host @"
DESCRIPTION:

FILTERS:

-setpath       : Set output path to save your CSV File.
-fromdate      : From date Filter (DD-MM-AAAA).
-todate        : To date Filter (DD-MM-AAAA).
-NameFilter    : IMT Name.
-StatusFilter  : Status of the template (Tested / Not tested).
-MD5Filter     : Filter by hash value.

Usage:
Get-CymIMTioc -fromdate 2023-01-10 -todate 2023-05-10 -MD5Filter your_md5_hash_here

"@
    }

    # Check for the -? argument (Custom Help)
    if ($HelpMessage) {
        & $CustomHelpMessage
        return
    }

    $Endpoint = "immediate-threats"
    $QueryString = ""
    $Headers = @{
        "x-token" = $global:defaultApiKey  # Replace with your actual API token
    }

    # Define parameters as a hashtable
    $params = @{
        "fromdate" = $fromdate
        "todate" = $todate
        
    }

    # Construct the query string based on parameters
    $QueryString = Construct-QueryString -params $params

    # Append the 'date' parameter to the query string
    $QueryString += "fromdate=$($fromdate)"
    $QueryString += "todate=$($todate)"

    try {
        # Check if the response contains the expected structure
        if ($global:defaultApiKey -eq $null) {
            throw "API key not set. Please run 'Connect-CymApi -ApiKey your_api_key_here'  to set the API key."
        }
        # Make the API request using Invoke-RestMethod
        $response = Invoke-RestMethod -Uri "https://api.app.cymulate.com/v1/$Endpoint/ioc/?$QueryString" -Headers $Headers
    
        # Check if the response contains the expected structure
        if ($response.success -and $response.data.Count -gt 0) {
            # Initialize an array to store the extracted data
            $table = @()
    
            # Loop through the test objects in the response
            foreach ($test in $response.data) {
                # Extract the test information
                $testId = $test._id
                $immediateThreatName = $test.immediate_threat_name
                $status = $test.status
    
                # Loop through the IOCs in the test
                foreach ($ioc in $test.iocs) {
                    $rowData = @{
                        'Test ID' = $testId
                        'Immediate Threat Name' = $immediateThreatName
                        'Status' = $status
                        'IOC ID' = $ioc._id
                        'Name' = $ioc.name
                        'MD5' = $ioc.md5
                        'SHA1' = $ioc.sha1
                        'SHA256' = $ioc.sha256
                        'IOC Status' = $ioc.status
                        'VIRUS TOTAL' = $ioc.vt_reference
                        'TIMESTAMP' = $ioc.timestamp
                        'MODULE' = $ioc.module
                    }

                    # Apply filters if provided
                    if ($NameFilter) {
                        if ($rowData['Name'] -notlike "*$NameFilter*") {
                            continue
                        }
                    }

                    if ($StatusFilter) {
                        if ($rowData['Status'] -notlike "*$StatusFilter*") {
                            continue
                        }
                    }

                    if ($MD5Filter) {
                        if ($rowData['MD5'] -notlike "*$MD5Filter*") {
                            continue
                        }
                    }
                    # Add the current row of data to the table array
                    $table += New-Object PSObject -Property $rowData
                }
            }
            # Filter the table based on status before displaying it
            if ($StatusFilter) {
            $table = $table | Where-Object { $_.'Status' -like "*$StatusFilter*" }
        }
    
            # Display the table
            $table | Format-Table -AutoSize
            # Save data to CSV if setpath parameter is provided
            if ($setpath) {
                $csvFileName = "Cym_IMT_Data.csv"
                $csvPath = Join-Path -Path $setpath -ChildPath $csvFileName
                $table | Export-Csv -Path $csvPath -NoTypeInformation -Force -Delimiter ";" -Encoding UTF8
                Write-Host "Data saved to $csvPath"
            }
        }
        else {
            Write-Host "No data found in the response."
        }
    }
    catch {
        Write-Host "Error occurred: $_"
    }
   
}

# Function to construct the query string based on parameters
function Construct-QueryString {
    param (
        [hashtable]$params
    )

    $queryString = ""

    foreach ($key in $params.Keys) {
        if ($params[$key]) {
            $queryString += "&$key=$($params[$key])"
        }
    }

    return $queryString
}

Export-ModuleMember -Function Connect-CymApi, Get-PSCymHelp, Get-CymFindings, Get-CymScores, Get-CymEnvironments, Get-CymIMTioc
