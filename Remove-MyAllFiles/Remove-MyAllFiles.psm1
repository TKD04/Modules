<#
.SYNOPSIS
Remove all files, not directories, from the current directory.
#>
function Remove-MyAllFiles {
    [CmdletBinding()]
    [Alias('rmallfiles')]
    [OutputType([void])]
    param ()
    process {
        Get-ChildItem -File | Remove-Item $allFiles -Confirm:$Confirm -WhatIf
    }
}

Export-ModuleMember -Function Remove-MyAllFiles -Alias 'rmallfiles'
