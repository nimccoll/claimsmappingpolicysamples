# EnableSamAccountName.ps1
This script will create a claims mapping policy that will include the onpremisessamaccountname property in the token's claims bundle. The value of the user's SAM account name (if they have one) will be available in the samAccountName claim.

## Prerequisites
1. Create an application registration that you wish to include the SAM account name value in the claims bundle
1. Allow mapped claims for the application by modifying the manifest as follows:
    - "acceptMappedClaims": true
1. Install the AzureADPreview PowerShell module
    - Install-Module AzureADPreview -AllowClobber
1. Ensure that the AzureADPreview module is loaded prior to running the script
    - Import-Module AzureADPreview

## Inputs
1. tenantId - The Microsoft Entra tenant ID
1. applicationId - The Application (Client) ID of the application registration

## Retrieving the SAM Account Name in your application
Once the claims mapping policy has been created and assigned to your application registration the SAM Account name value for the current user will be available in the samAccountName claim (if they have one). For ASP.Net developers cast the User.Identity to a ClaimsIdentity and access the value from the Claims collection.