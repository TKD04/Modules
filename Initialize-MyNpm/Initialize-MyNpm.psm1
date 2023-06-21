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
        npm init -y
        <# Remove `test` in npm scripts which is generated automatically #>
        [hashtable]$package = '.\package.json' | Import-MyJSON -AsHashTable
        $package.scripts.Remove('test')
        $package | Export-MyJSON -LiteralPath '.\package.json'
        Add-Content -LiteralPath '.\.gitignore' -Value @(
            '/node_modules/'
            '/dist/'
        )

        git add '.\.gitignore' '.\package.json'
        git commit -m 'Add npm'
    }
}

Export-ModuleMember -Function Initialize-MyNpm -Alias 'ninit'
