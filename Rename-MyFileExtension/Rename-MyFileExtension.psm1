<#
.SYNOPSIS
Renames the file extensions the new one.
.PARAMETER OldExtension
The file extension which you want to replace with the new one.
.PARAMETER NewExtension
The file extension which you want to replace the old one with
.PARAMETER Recurse
Whether to rename the matched files recursively.
#>
function Rename-MyFileExtension {
    [CmdletBinding()]
    [Alias('renameextension')]
    [OutputType([void])]
    param (
        [Parameter(Mandatory)]
        [string]$OldExtension,
        [Parameter(Mandatory)]
        [string]$NewExtension,
        [switch]$Recurse
    )
    process {
        if ($Recurse) {
            Get-ChildItem -File -Filter ('*.{0}' -f $OldExtension) -Recurse |
            ForEach-Object {
                [string]$newName = $_.Name -replace ('.{0}$' -f $OldExtension), ('.{0}' -f $NewExtension)
                Rename-Item -LiteralPath $_.FullName -NewName $newName
            }
        }
        else {
            Get-ChildItem -File -Filter ('*.{0}' -f $OldExtension) |
            ForEach-Object {
                [string]$newName = $_.Name -replace ('.{0}$' -f $OldExtension), ('.{0}' -f $NewExtension)
                Rename-Item -LiteralPath $_.FullName -NewName $newName
            }
        }
    }
}

Export-ModuleMember -Function Rename-MyFileExtension -Alias 'renameextension'
