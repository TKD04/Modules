<#
.SYNOPSIS
Adds Prettier to the current directory.
#>
function Install-MyPrettier {
    [CmdletBinding()]
    [OutputType([void])]
    param ()
    process {
        npm i -D prettier
        Add-MyNpmScript -NameToScript @{
            'format' = 'prettier . --write'
        }

        git add '.\package-lock.json' '.\package.json'
        git commit -m 'Add Prettier'
    }
}

Export-ModuleMember -Function Install-MyPrettier
