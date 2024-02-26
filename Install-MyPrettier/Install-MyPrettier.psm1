<#
.SYNOPSIS
Adds Prettier to the current directory.

.PARAMETER UseTailwindcss
Whether to support automatic class sorting of tailwindcss.
#>
function Install-MyPrettier {
    [CmdletBinding()]
    [OutputType([void])]
    param (
        [switch]$UseTailwindcss
    )
    process {
        [string[]]$neededDevPackages = @(
            'prettier'
        )

        if ($UseTailwindcss) {
            [string]$srcPrettierConfigPath = Join-Path -Path $PSScriptRoot -ChildPath '.\prettier.config.js'
            Copy-Item -LiteralPath $srcPrettierConfigPath -Destination '.\prettier.config.js'
            $neededDevPackages += 'prettier-plugin-tailwindcss'
            git add '.\prettier.config.js'
        }
        Add-MyNpmScript -NameToScript @{
            'format' = 'prettier . --write'
        }
        npm i -D $neededDevPackages

        git add '.\package-lock.json' '.\package.json'
        git commit -m 'Add Prettier'
    }
}

Export-ModuleMember -Function Install-MyPrettier
