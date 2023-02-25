#!/usr/bin/env pwsh

function CreateWorkItem(
  [string] $org,
  [string] $project,
  [string] $repoName,
  [string] $type,
  [string] $message) {
  
  $url = "https://dev.azure.com/$org/$project/_apis/wit/workitems/`$$($type)?api-version=7.0"
  $body = @"
    [
      {
        "op": "add",
        "path": "/fields/System.Title",
        "from": null,
        "value": "$repoName package upgrades (PackageBot)"
      },
      {
        "op": "add",
        "path": "/fields/System.Description",
        "from": null,
        "value": "$message"
      }
    ]
"@

  $SYSTEM_ACCESSTOKEN = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes("`:$($env:SYSTEM_ACCESSTOKEN)"))

  $headers = @{
    "Authorization" = "Basic $SYSTEM_ACCESSTOKEN"
    "Content-Type" = "application/json-patch+json"
  }

  $response = Invoke-WebRequest `
    -Uri $url `
    -Method POST `
    -Headers $headers `
    -Body $body

  $response.Content | Write-Host

}