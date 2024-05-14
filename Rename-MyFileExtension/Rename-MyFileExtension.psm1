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
        [ValidateNotNullOrEmpty()]
        [string]$OldExtension,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$NewExtension,
        [switch]$Recurse
    )
    process {
        $files = Get-ChildItem -File -Recurse:$Recurse -Filter "*.$OldExtension"

        foreach ($file in $files) {
            $newName = $file.FullName -replace "\.$OldExtension$", ".$NewExtension"
            Rename-Item -LiteralPath $file.FullName -NewName $newName
        }
    }
}

Export-ModuleMember -Function Rename-MyFileExtension -Alias 'renameextension'
