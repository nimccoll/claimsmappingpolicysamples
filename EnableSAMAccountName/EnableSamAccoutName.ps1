#===============================================================================
# Microsoft FastTrack for Azure
# Create a claims mapping policy to include the SAM Account Name in the access
# token and assign the policy to the specified application registration
#===============================================================================
# Copyright © Microsoft Corporation.  All rights reserved.
# THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY
# OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT
# LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
# FITNESS FOR A PARTICULAR PURPOSE.
#===============================================================================
param(
    [Parameter(Mandatory)]$tenantId,
    [Parameter(Mandatory)]$applicationId
)
# Login to Azure
Connect-AzureAD -TenantId $tenantId

$servicePrincipal = Get-AzureADServicePrincipal -Filter "servicePrincipalNames/any(n: n eq '$applicationId')"
$claimsMappingPolicy = New-AzureADPolicy -Definition @('{"ClaimsMappingPolicy":{"Version":1,"IncludeBasicClaimSet":"true", "ClaimsSchema": [{"Source":"user","ID":"onpremisessamaccountname","SamlClaimType":"samaccountname","JwtClaimType":"samAccountName"}]}}') -DisplayName "SamAccountNameClaimsPolicy" -Type "ClaimsMappingPolicy"
Add-AzureADServicePrincipalPolicy -Id $servicePrincipal.ObjectId -RefObjectId $claimsMappingPolicy.Id