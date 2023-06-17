<#
.SYNOPSIS
Removes all the files and directories from the current directory.
#>
function Clear-MyCurrentDirectory {
    [CmdletBinding()]
    [Alias('cldir')]
    [OutputType([void])]
    param ()
    process {
        Remove-Item -Path '.\*' -Recurse -Force -Confirm
    }
}

Export-ModuleMember -Function Clear-MyCurrentDirectory -Alias 'cldir'
