<#
.SYNOPSIS
Removes the header of the filename in the current directory.

.PARAMETER NumberOfCharacters
A number of characters to remove.
#>
function Remove-MyHeadOfFileNames {
    [CmdletBinding()]
    [Alias('rmhead')]
    [OutputType([void])]
    param (
        [Parameter(Mandatory)]
        [ValidateRange(1, 255)]
        [int]$NumberOfCharacters
    )
    process {
        (Get-ChildItem -LiteralPath '.\' -File).Name | ForEach-Object {
            if ($_.Length -lt $NumberOfCharacters) {
                Write-Error -Message 'The length of {0} is shorter than {1}.' -f $_, $NumberOfCharacters
            }
            else {
                Rename-Item -LiteralPath ".\$_" -NewName ($_.Substring($NumberOfCharacters))
            }
        }
    }
}

Export-ModuleMember -Function Remove-MyHeadOfFileNames -Alias 'rmhead'
