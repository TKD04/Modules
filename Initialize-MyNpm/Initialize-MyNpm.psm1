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
        [hashtable]$package = Import-MyJSON -LiteralPath '.\package.json' -AsHashTable
        $package.scripts.Remove('test')
        Export-MyJSON -LiteralPath '.\package.json' -CustomObject $package
        Add-Content -LiteralPath '.\.gitignore' -Value @(
            '/node_modules/'
            '/dist/'
        )
        <# Add `npm-check-updates` to update npm packages effortlessly #>
        npm i -D npm-check-updates
        Add-MyNpmScript -NameToScript @{
            'update' = 'ncu -u'
        }

        git add '.\.gitignore' '.\package-lock.json' '.\package.json'
        git commit -m 'Add npm'
    }
}

Export-ModuleMember -Function Initialize-MyNpm -Alias 'ninit'
