<#
.SYNOPSIS
Adds TypeScript and its settings to the current directory.

.PARAMETER UseNoEmit
Whether to enable "noEmit".

.PARAMETER UseNode
Whether to support Node.

.PARAMETER UseJSX
Whether to support React.
#>
function Install-MyTypeScript {
    [CmdletBinding()]
    [OutputType([void])]
    param (
        [switch]$UseNoEmit,
        [switch]$UseNode,
        [switch]$UseJSX
    )
    process {
        [hashtable]$tsConfig = [ordered]@{
            # ref. https://www.typescriptlang.org/tsconfig
            'include'         = @(
                './src'
            )
            'compilerOptions' = [ordered]@{
                <# Type Checking #>
                'allowUnreachableCode'               = $false
                'allowUnusedLabels'                  = $false
                'exactOptionalPropertyTypes'         = $true
                'noFallthroughCasesInSwitch'         = $true
                'noImplicitOverride'                 = $true
                'noImplicitReturns'                  = $true
                'noPropertyAccessFromIndexSignature' = $true
                'noUncheckedIndexedAccess'           = $true
                'noUnusedLocals'                     = $true
                'noUnusedParameters'                 = $true
                'strict'                             = $true
                <# Modules #>
                'module'                             = 'esnext'
                'moduleResolution'                   = 'node'
                'resolveJsonModule'                  = $true
                <# Emit #>
                'outDir'                             = './dist'
                'sourceMap'                          = $true
                <# Interop Constraints #>
                'esModuleInterop'                    = $true
                'forceConsistentCasingInFileNames'   = $true
                'isolatedModules'                    = $true
                'verbatimModuleSyntax'               = $true
                <# Language and Environment #>
                'lib'                                = @(
                    'esnext'
                    'dom'
                    'dom.iterable'
                )
                'target'                             = 'es2016'
                <# Completeness #>
                'skipLibCheck'                       = $true
            }
        }

        if ($UseNode) {
            # ref. https://gist.github.com/azu/56a0411d69e2fc333d545bfe57933d07
            # ref. https://github.com/tsconfig/bases/tree/main/bases
            # For node-lts (node18)
            $tsConfig.compilerOptions.module = 'node16'
            $tsConfig.compilerOptions.target = 'es2022'
            $tsConfig.compilerOptions.lib = @(
                'es2023'
            )

            npm i -D @types/node
        }
        if ($UseNoEmit) {
            $tsConfig.compilerOptions.Add('noEmit', $true)
        }
        if ($UseJSX) {
            $tsConfig.compilerOptions.Add('jsx', 'react-jsx')
        }
        npm i -D typescript
        Export-MyJSON -LiteralPath '.\tsconfig.json' -CustomObject $tsConfig

        git add '.\package-lock.json' '.\package.json' '.\tsconfig.json'
        git commit -m 'Add TypeScript'
    }
}
