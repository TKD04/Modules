<#
.SYNOPSIS
Adds the given prefix to the filenames in the current directory.

.PARAMETER Prefix
A prefix string.
#>
function Add-MyPrefixToFiles {
    [CmdletBinding()]
    [Alias('addprefix')]
    [OutputType([void])]
    param (
        [Parameter(Mandatory)]
        [string]$Prefix
    )
    process {
        (Get-ChildItem -LiteralPath '.\' -File).Name | ForEach-Object {
            Rename-Item -LiteralPath ".\$_" -NewName "$Prefix$_"
        }
    }
}

Export-ModuleMember -Function Add-MyPrefixToFiles -Alias 'addprefix'
