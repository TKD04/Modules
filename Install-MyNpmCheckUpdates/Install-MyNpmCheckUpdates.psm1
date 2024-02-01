<#
.SYNOPSIS
Adds npm-check-updates to the current directory.
#>
function Install-MyNpmCheckUpdates {
    [CmdletBinding()]
    [OutputType([void])]
    param ()
    process {
        npm i -D npm-check-updates
        Add-MyNpmScript -NameToScript @{
            'update' = 'ncu -u && npm i'
        }

        git add '.\package-lock.json' '.\package.json'
        git commit -m 'Add npm-check-updates'
    }
}

Export-ModuleMember -Function Install-MyNpmCheckUpdates
