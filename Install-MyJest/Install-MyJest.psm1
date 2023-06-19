<#
.SYNOPSIS
Adds Jest and its settings to the current directory.
#>
function Install-MyJest {
    [CmdletBinding()]
    [OutputType([void])]
    param()
    process {
        npm i -D jest ts-jest @types/jest
        npx ts-jest config:init
        Add-MyNpmScript -NameToScript @{
            'test' = 'jest'
        }

        git add '.\jest.config.js' '.\package-lock.json' '.\package.json'
        git commit -m 'Add Jest'
    }
}

Export-ModuleMember -Function Install-MyJest
