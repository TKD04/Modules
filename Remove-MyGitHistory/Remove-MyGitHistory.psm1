<#
.SYNOPSIS
Removes the .git directory from the current directory.
#>
function Remove-MyGitHistory {
    [CmdletBinding()]
    [Alias('rmgithis')]
    [OutputType([void])]
    param()
    process {
        Remove-Item -LiteralPath '.\.git' -Recurse -Force -Confirm
    }
}

Export-ModuleMember -Function Remove-MyGitHistory -Alias 'rmgithis'
