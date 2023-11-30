##Install-Module -Name BcContainerHelper -Force

$artifactUrl = Get-BCArtifactUrl -country es -select Latest -type Sandbox

New-BcContainer -accept_eula -auth UserPassword -containerName BC23CU1ES -artifactUrl $artifactUrl -includeTestToolkit -includeTestLibrariesOnly -updateHosts -useBestContainerOS -dns '8.8.8.8'