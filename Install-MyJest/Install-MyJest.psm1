<#
.SYNOPSIS
Adds Jest and its settings to the current directory.

.PARAMETER UseBrowser
Whether to support browser (dom).

.PARAMETER UseNode
Whether to support Node.
#>
function Install-MyJest {
    [CmdletBinding()]
    [OutputType([void])]
    param(
        [switch]$UseBrowser,
        [switch]$UseNode
    )
    process {
        if ($UseBrowser -and $UseNode) {
            throw 'Only either $UseBrowser or $UseNode can be enabled.'
        }
        if (!$UseBrowser -and !$UseNode) {
            throw 'Either $UseBrowser or $UseNode must be enabled.'
        }

        [string]$jestConfigPath = '.\jest.config.js'
        [string[]]$neededDevPackages = @(
            'jest'
            'ts-jest'
            '@types/jest'
        )

        if ($UseBrowser) {
            [string]$SrcJestConfigPath = Join-Path -Path $PSScriptRoot -ChildPath '.\ts.browser.jest.config.js'
            Copy-Item -LiteralPath $SrcJestConfigPath -Destination $jestConfigPath
            $neededDevPackages += 'jest-environment-jsdom'
        }
        if ($UseNode) {
            [string]$SrcJestConfigPath = Join-Path -Path $PSScriptRoot -ChildPath '.\ts.node.jest.config.js'
            Copy-Item -LiteralPath $SrcJestConfigPath -Destination $jestConfigPath
        }
        Add-MyNpmScript -NameToScript @{
            'test' = 'jest'
        }
        npm i -D $neededDevPackages

        git add '.\package-lock.json' '.\package.json' $jestConfigPath
        git commit -m 'Add Jest'
    }
}

Export-ModuleMember -Function Install-MyJest
