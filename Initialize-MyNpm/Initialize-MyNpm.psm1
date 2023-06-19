<#
.SYNOPSIS
Initializes npm in the current directory.
#>
function Initialize-MyNpm {
    [CmdletBinding()]
    [Alias('ninit')]
    [OutputType([void])]
    param()
    process {
        [string]$packagePath = '.\package.json'
        npm init -y
        [hashtable]$package = $packagePath | Import-MyJSON -AsHashTable
        $package.scripts.Remove('test')
        $package | Export-MyJSON -LiteralPath $packagePath
        Add-Content -LiteralPath '.\.gitignore' -Value @(
            '/node_modules/'
            '/dist/'
        )
        git add '.\.gitignore' $packagePath
        git commit -m 'Add npm'
    }
}

Export-ModuleMember -Function Initialize-MyNpm -Alias 'ninit'
