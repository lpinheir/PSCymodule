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

For detailed usage instructions and examples, please refer to the documentation (replace with a link to your documentation)..

## Installation 🎉

Clone or download this repository to your local machine.
Import the module by running the following command in PowerShell:
`Import-Module .\MyApiModule.psm1`
Set your Cymulate API key using the Connect-CymApi function:
`Connect-CymApi -ApiKey "your_api_key_here"`
You are now ready to use the module and its functions as described in the documentation


## Status e badges shields 🦄

Aperfeiçoe o seu perfil e os seus repositórios adicionando **[cards de status](https://github.com/iuricode/readme-template/tree/main/cards-status/readme.md)** e **[badges shields](https://github.com/iuricode/readme-template/tree/main/badges-shields/readme.md)** ao seu readme. Esses cards proporcionam uma visão aprimorada e detalhada das informações relevantes, tornando o seu perfil e os seus projetos ainda mais impressionantes.

## Contribuição ✨

Ajude a comunidade tornando este projeto ainda mais incrível. Leia como contribuir clicando **[aqui](https://github.com/iuricode/readme-template/blob/main/CONTRIBUTING.md)** e a **[licença](https://github.com/iuricode/readme-template/blob/main/LICENSE.md)**. Estou convencido de que juntos alcançaremos coisas incríveis! 

## Aprenda desenvolvimento frontend ❤️

Este repositório é um projeto gratuito para a comunidade de desenvolvedores, mas você pode me ajudar comprando o meu ebook "**[eFront - Estudando frontend do zero](https://iuricode.com/efront)**" se estiver interessado em aprender ou melhorar suas habilidades de desenvolvimento frontend. A sua compra me ajuda a produzir e fornecer mais conteúdo gratuito para a comunidade. Adquira agora e comece sua jornada no desenvolvimento frontend.
