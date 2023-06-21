<#
.SYNOPSIS
Adds Jest and its settings to the current directory.
#>
function Install-MyJest {
    [CmdletBinding()]
    [OutputType([void])]
    param()
    process {
        Add-MyNpmScript -NameToScript @{
            'test' = 'jest'
        }
        npm i -D jest ts-jest @types/jest
        npx ts-jest config:init

        git add '.\jest.config.js' '.\package-lock.json' '.\package.json'
        git commit -m 'Add Jest'
    }
}

Export-ModuleMember -Function Install-MyJest
