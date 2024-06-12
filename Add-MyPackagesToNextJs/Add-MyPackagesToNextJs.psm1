<#
.SYNOPSIS
Adds some needed packages to a Next.js project.

.PARAMETER UseDaisyUi
Whether to use daisyUI.
#>
function Add-MyPackagesToNextJs {
    [CmdletBinding()]
    [OutputType([void])]
    param (
        [switch]$UseDaisyUi
    )
    process {
        [hashtable]$missingCompilerOptions = @{
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
            'forceConsistentCasingInFileNames'   = $true
        }

        <# npm-check-updates #>
        Install-MyNpmCheckUpdates
        <# TypeScript #>
        # Make tsconfig more strict
        [hashtable]$tsConfig = Import-MyJSON -LiteralPath '.\tsconfig.json' -AsHashTable
        $tsConfig.compilerOptions.Remove('allowJs')
        $missingCompilerOptions.GetEnumerator() | ForEach-Object {
            $tsConfig.compilerOptions.Add($_.Key, $_.Value)
        }
        Export-MyJSON -LiteralPath '.\tsconfig.json' -CustomObject $tsConfig
        git add '.\tsconfig.json'
        git commit -m 'Make tsconfig more strict'
        <# ESLint #>
        # Make eslintrc more strict
        git rm '.\.eslintrc.json'
        Install-MyESLint -UseTypeScript -UseReact -UseJest
        [hashtable]$eslintrc = Import-MyJSON -LiteralPath '.\.eslintrc.json' -AsHashTable
        $eslintrc.extends += 'next/core-web-vitals'
        Export-MyJSON -LiteralPath '.\.eslintrc.json' -CustomObject $eslintrc
        git add '.\.eslintrc.json'
        git commit -m 'Make eslintrc more strict'
        <# Jest #>
        Install-MyJest -UseBrowser -UseReact
        <# Prettier #>
        Install-MyPrettier -UseTailwindcss
        <# Tailwind CSS #>
        Install-MyTailwindCss -UseDaisyUi:$UseDaisyUi -IsNextJs
    }
}

Export-ModuleMember -Function Add-MyPackagesToNextJs
