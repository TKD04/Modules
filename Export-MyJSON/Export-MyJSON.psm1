<#
.SYNOPSIS
Exports the given [PSCustomObject] as a JSON file.

.PARAMETER LiteralPath
A destination path for an export.

.PARAMETER CustomObject
A [PSCustomObject] to be export.
#>
function Export-MyJSON {
    [CmdletBinding()]
    [OutputType([void])]
    param (
        [Parameter(Mandatory)]
        [string]$LiteralPath,
        [Parameter(Mandatory, ValueFromPipeline)]
        [PSCustomObject]$CustomObject
    )
    process {
        ConvertTo-Json -InputObject $CustomObject | Set-Content -LiteralPath $LiteralPath
    }
}

Export-ModuleMember -Function Export-MyJSON
