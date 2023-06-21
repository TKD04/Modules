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
        [string]$LiteralPath,
        [switch]$AsHashTable
    )
    process {
        if (!(Test-MyStrictPath -LiteralPath $LiteralPath)) {
            throw '$LiteralPath was not found.'
        }

        if ($AsHashTable) {
            Get-Content -LiteralPath $LiteralPath -Raw | ConvertFrom-Json -AsHashtable
        }
        else {
            Get-Content -LiteralPath $LiteralPath -Raw | ConvertFrom-Json
        }
    }
}

Export-ModuleMember -Function Import-MyJSON
