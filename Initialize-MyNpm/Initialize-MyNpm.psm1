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
        Add-Content -LiteralPath '.\.gitignore' -Value @(
            '/node_modules/'
            '/dist/'
        )
        git add '.\.gitignore' '.\package.json'
        git commit -m 'Add npm'
    }
}

Export-ModuleMember -Function Initialize-MyNpm -Alias 'ninit'
