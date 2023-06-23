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
        [System.IO.FileInfo[]]$allFiles = Get-ChildItem -File
        Remove-Item $allFiles -Confirm
    }
}

Export-ModuleMember -Function Remove-MyAllFiles -Alias 'rmallfiles'
