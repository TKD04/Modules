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
        if (!(Test-MyStrictPath -LiteralPath '.\node_modules')) {
            throw '.\node_modules directory not found.'
        }

        Remove-Item -LiteralPath '.\node_modules' -Recurse -Force
    }
}

Export-ModuleMember -Function Remove-MyNodeModulesDir -Alias 'rmnodemodules'
