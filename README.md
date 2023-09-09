![Alt text](https://uploads-us-west-2.insided.com/cymulate-en/attachment/85f44e4c-5f50-4be4-b68b-3bd5671e0d2a.png)

# PSCymodule
This PowerShell module provides a convenient way to interact with the Cymulate platform's API. Cymulate is a comprehensive cyber security validation platform that allows organizations to assess and optimize their security posture. With this module, you can programmatically access Cymulate's API to retrieve findings, scores, environments, and immediate threat intelligence.

# Features 📜

Connect to Cymulate API: Set and manage your Cymulate API key using the Connect-CymApi function.

Retrieve Findings: Fetch security findings based on various filters like module, client ID, risk, and more using the Get-CymFindings function. You can also specify date ranges to narrow down your search.

Retrieve Scores: Get security scores for your Cymulate environment using the Get-CymScores function. This includes scores for various security metrics.

Retrieve Environments: List available environments in your Cymulate account using the Get-CymEnvironments function.

Retrieve Immediate Threat Intelligence: Fetch immediate threat intelligence data, filterable by date, name, MD5 hash, and status using the Get-CymIMTioc function.

## Usage ☕️

To use this PowerShell module, you'll need to obtain your Cymulate API key and set it using the Connect-CymApi function. Once authenticated, you can make API calls to retrieve the desired information.

For detailed usage instructions and examples, please refer to the documentation (replace with a link to your documentation).

If you need more informations please run:

- `Get-PSCymHelp`

## Installation 🎉

1. Clone or download this repository to your local machine
2. Import the module by running the following command in PowerShell:
   
- `Import-Module .\PSCymodule.psm1`
  
3. Set your Cymulate API key using the Connect-CymApi function:
   
- `Connect-CymApi -ApiKey "your_api_key_here"`
  
4. You are now ready to use the module and its functions as described in the documentation

+Note: Don't forget to replace "your_api_key_here".

## Contributing ✨

Contributions to this project are welcome! If you encounter issues or have suggestions for improvements, please create an issue or submit a pull request.

## About the Author ✨

**[Lucas M. Pinheiro](https://www.linkedin.com/in/lmpin/)** - Lucas is LATAM Solutions Architect for Cymulate.

## License ❤️

This project is licensed under the GPL License.
