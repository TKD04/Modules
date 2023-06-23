<#
.SYNOPSIS
Adds Jest and its settings to the current directory.

.PARAMETER UseTypeScript
Whether to support TypeScript.

.PARAMETER UseBrowser
Whether to support browser (dom).

.PARAMETER UseNode
Whether to support Node.
#>
function Install-MyJest {
    [CmdletBinding()]
    [OutputType([void])]
    param(
        [switch]$UseTypeScript,
        [switch]$UseBrowser,
        [switch]$UseNode
    )
    process {
        if (!$UseBrowser -and !$UseNode) {
            throw 'Either $UseBrowser or $UseNode must be enabled.'
        }
        if ($UseBrowser -and $UseNode) {
            throw 'Only either $UseBrowser or $UseNode can be enabled.'
        }

        [string]$jestConfigPath = '.\jest.config.js'
        [string[]]$neededPackages = @(
            'jest'
        )

        if ($UseTypeScript) {
            $neededPackages += @(
                'ts-jest'
                '@types/jest'
            )
            if ($UseBrowser) {
                [string]$SrcJestConfigPath = Join-Path -Path $PSScriptRoot -ChildPath '.\ts.browser.jest.config.js'
                Copy-Item -LiteralPath $SrcJestConfigPath -Destination $jestConfigPath
            }
            if ($UseNode) {
                [string]$SrcJestConfigPath = Join-Path -Path $PSScriptRoot -ChildPath '.\ts.node.jest.config.js'
                Copy-Item -LiteralPath $SrcJestConfigPath -Destination $jestConfigPath
            }
        }
        else {
            if ($UseBrowser) {
                [string]$SrcJestConfigPath = Join-Path -Path $PSScriptRoot -ChildPath '.\browser.jest.config.js'
                Copy-Item -LiteralPath $SrcJestConfigPath -Destination $jestConfigPath
            }
            if ($UseNode) {
                [string]$SrcJestConfigPath = Join-Path -Path $PSScriptRoot -ChildPath '.\node.jest.config.js'
                Copy-Item -LiteralPath $SrcJestConfigPath -Destination $jestConfigPath
            }
        }
        Add-MyNpmScript -NameToScript @{
            'test' = 'jest'
        }
        npm i -D $neededPackages

        git add '.\package-lock.json' '.\package.json' $jestConfigPath
        git commit -m 'Add Jest'
    }
}

Export-ModuleMember -Function Install-MyJest
