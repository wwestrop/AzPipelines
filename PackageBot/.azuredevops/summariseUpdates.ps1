#!/usr/bin/env pwsh

function Summarise() {

  $prMessage = "";

  if (-not (Test-Path updates.json)) {
    return $prMessage
  }


  $updates = Get-Content updates.json `
    | ConvertFrom-Json `
    | % { $_.Projects.TargetFrameworks.Dependencies } `


  $anyMajor = $updates | ? { $_.UpgradeSeverity -eq "Major" }
  if ($anyMajor.Count -ne 0) {
    $prMessage += "<div style='padding: 20px; background-color: #B4CFE4; font-size: larger; font-weight: bold;'>&#x26A0; <b>This PR contains major version updates</b> &#x26A0;</div> <br/>"
  }

  $prMessage += "<ul>"
  $summary = $updates `
      | Select-Object @{ E = {"<li><code>$($_.Name)</code> : $($_.ResolvedVersion) --> $($_.LatestVersion)</li>"};  L="Descriptor"; } `
      | Sort-Object Descriptor
      | Select-Object -Unique Descriptor

  $summary | % { $prMessage += $_.Descriptor + "`n" }

  $prMessage += "</ul>"

  $prMessage += "<br/><br/><i>Happy upgrading, from your friendly neighbourhood PackageBot</i>"

  return $prMessage
}