﻿<#
.SYNOPSIS
Adds Prettier to the current directory.

.PARAMETER UsePug
Whether to support Pug.

.PARAMETER UseTailwindcss
Whether to support automatic class sorting of tailwindcss.
#>
function Install-MyPrettier {
    [CmdletBinding()]
    [OutputType([void])]
    param (
        [switch]$UsePug,
        [switch]$UseTailwindcss
    )
    process {
        [string[]]$neededDevPackages = @(
            'prettier'
        )

        if ($UsePug -or $UseTailwindcss) {
            [string]$prettierConfigPath = ''

            if ($UsePug -and $UseTailwindcss) {
                $neededDevPackages += @(
                    '@prettier/plugin-pug'
                    'prettier-plugin-tailwindcss'
                )
                $prettierConfigPath = "$PSScriptRoot\pug.tailwind.prettier.config.js"
            }
            elseif ($UsePug -and !$UseTailwindcss) {
                $neededDevPackages += @(
                    '@prettier/plugin-pug'
                )
                $prettierConfigPath = "$PSScriptRoot\pug.prettier.config.js"
            }
            elseif (!$UsePug -and $UseTailwindcss) {
                $neededDevPackages += @(
                    'prettier-plugin-tailwindcss'
                )
                $prettierConfigPath = "$PSScriptRoot\tailwind.prettier.config.js"
            }
            Copy-Item -LiteralPath $prettierConfigPath -Destination '.\prettier.config.js'

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
