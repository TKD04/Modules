<#
.SYNOPSIS
Imports a JSON file as [PSCustomObject] or [HashTable].

.PARAMETER LiteralPath
A source path to a JSON file.

.PARAMETER AsHashTable
Whether to import a JSON file as [HashTable].
#>
function Import-MyJSON {
    [CmdletBinding()]
    [OutputType([PSCustomObject])]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateScript({
                if (!(Test-MyStrictPath -LiteralPath $_)) {
                    throw "The path '$_' does not exist or is not accessible."
                }

                $true
            })]
        [string]$LiteralPath,
        [switch]$AsHashTable
    )
    process {
        try {
            [string]$json = Get-Content -LiteralPath $LiteralPath -Raw

            if ($AsHashTable) {
                ConvertFrom-Json -InputObject $json -AsHashtable
            }
            else {
                ConvertFrom-Json -InputObject $json
            }
        }
        catch {
            Write-Error -Message "Failed to import JSON from $LiteralPath. $_"
        }

    }
}

Export-ModuleMember -Function Import-MyJSON
