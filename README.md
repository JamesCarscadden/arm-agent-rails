# arm-agent-rails
Azure resource manager template for a VSTS Ruby on Rails build agent

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FJamesCarscadden%2Farm-rails-agent%2Fmaster%2FRailsBuildAgent.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2FJamesCarscadden%2Farm-rails-agent%2Fmaster%2FRailsBuildAgent.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

This template will install a simple Ubuntu linux server with a docker container for a Postgres DB and a second container for a VTST build agent with tools for Ruby on Rails and Postgres.

## Deploy

1. Using Azure CLI

    Clone the files to your local machine, and then open a terminal at the cloned directory. Make sure you are logged in using azure cli, and that you are in Resource Manager mode. (More on how to do that at the link below)

    ```
    azure group create <resource group name> <location>; azure group deployment create -v -f RailsBuildAgent.json <resource group name> <deployment name>
    ```

  https://azure.microsoft.com/en-us/documentation/articles/xplat-cli-azure-resource-manager/

2. Using Powershell

  https://azure.microsoft.com/en-us/documentation/articles/powershell-azure-resource-manager/

3. Using Azure Portal
  Click the "Deploy to Azure" button.