Some small scripts for working with AzureDevops


# PackageBot
Updates Nuget packages on a schedule and creates an associated PR and WorkItem, to automate some manual developer effort.

Dependabot creates separate PRs for every .NET dependency which is messy. Other tools are available, but it seemed like it should be easy to glue the `dotnet outdated` together with the DevOps REST API, so here it is ¯\\\_(ツ)_/¯
