<#
.SYNOPSIS
Removes the node_modules directory from the current directory.
#>
function Remove-MyNodeModulesDir {
    [CmdletBinding()]
    [Alias('rmnodemodules')]
    [OutputType([void])]
    param()
    process {
        Remove-Item -LiteralPath '.\node_modules' -Recurse -Force -Confirm
    }
}

Export-ModuleMember -Function Remove-MyNodeModulesDir -Alias 'rmnodemodules'
