<#
.SYNOPSIS
Exports the given [PSCustomObject] as a JSON file.

.PARAMETER LiteralPath
A destination path for an export.

.PARAMETER CustomObject
A [PSCustomObject] to be export.

.PARAMETER Depth
Specifies how many levels of contained objects are included in the JSON representation.
#>
function Export-MyJSON {
    [CmdletBinding()]
    [OutputType([void])]
    param (
        [Parameter(Mandatory)]
        [ValidateScript({
                if (!(Test-MyStrictPath -LiteralPath $_)) {
                    throw "The path '$_' does not exist or is not accessible."
                }

                $true
            })]
        [string]$LiteralPath,
        [Parameter(Mandatory, ValueFromPipeline)]
        [PSCustomObject]$CustomObject,
        [int]$Depth = 4
    )
    process {
        try {
            ConvertTo-Json -InputObject $CustomObject -Depth $Depth |
            Set-Content -LiteralPath $LiteralPath -ErrorAction Stop
        }
        catch {
            Write-Error -Message "Failed to export JSON to $LiteralPath. $_"
        }
    }
}

Export-ModuleMember -Function Export-MyJSON
