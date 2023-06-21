<#
.SYNOPSIS
Adds ESLint and its settings to the current directory.

.PARAMETER UseBrowser
Whether to support the global variables in browser.

.PARAMETER UseNode
Whether to support the global varialbes in Node.

.PARAMETER UseTypeScript
Whether to add the rules for TypeScript.

.PARAMETER UseReact
Whether to add the rules for React.

.PARAMETER UseJest
Whether to add the rules for Jest.
#>
function Install-MyESLint {
    [CmdletBinding()]
    [OutputType([void])]
    param (
        [switch]$UseBrower,
        [switch]$UseNode,
        [switch]$UseTypeScript,
        [switch]$UseReact,
        [switch]$UseJest
    )
    process {
        [string]$eslintrcPath = '.\.eslintrc.json'
        [hashtable]$eslintrc = @{
            root           = $true
            env            = @{
                es2021 = $true
            }
            parserOptions  = @{
                ecmaVersion = 'latest'
                sourceType  = 'module'
            }
            plugins        = @()
            extends        = @()
            ignorePatterns = @('/dist/')
        }
        [string[]]$neededEslintPackages = @(
            'eslint'
            'eslint-plugin-import'
            'eslint-config-prettier'
        )

        if ($UseBrower) {
            $eslintrc.env.Add('browser', $true)
        }
        if ($UseNode) {
            $eslintrc.env.Add('node', $true)
        }
        if ($UseReact) {
            # ref. https://www.npmjs.com/package/eslint-config-airbnb
            $neededEslintPackages += @(
                'eslint-config-airbnb'
                'eslint-plugin-react'
                'eslint-plugin-react-hooks'
                'eslint-plugin-jsx-a11y'
            )
            $eslintrc.extends += @(
                'airbnb'
                'airbnb/hooks'
            )
        }
        else {
            # ref. https://www.npmjs.com/package/eslint-config-airbnb-base
            $neededEslintPackages += 'eslint-config-airbnb-base'
            $eslintrc.extends += 'airbnb-base'
        }
        if ($UseTypeScript) {
            # ref. https://www.npmjs.com/package/eslint-config-airbnb-typescript
            # ref. https://typescript-eslint.io/linting/typed-linting/
            # ref. https://typescriptbook.jp/tutorials/eslint#typescript-eslint%E3%81%AE%E8%A8%AD%E5%AE%9A%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%82%92%E4%BD%9C%E3%82%8B
            $neededEslintPackages += @(
                'eslint-config-airbnb-typescript'
                '@typescript-eslint/eslint-plugin'
                '@typescript-eslint/parser'
            )
            $eslintrc.Add('parser', '@typescript-eslint/parser')
            $eslintrc.parserOptions.Add('project', './tsconfig.eslint.json')
            $eslintrc.parserOptions.Add('tsconfigRootDir', './')
            $eslintrc.plugins += '@typescript-eslint'
            if ($UseReact) {
                $eslintrc.extends += 'airbnb-typescript'
            }
            else {
                $eslintrc.extends += 'airbnb-typescript/base'
            }
            $eslintrc.extends += 'plugin:@typescript-eslint/recommended-requiring-type-checking'

            <# Create tsconfig.eslint.json to avoid the error below. #>
            # ref. https://typescript-eslint.io/linting/troubleshooting/#i-get-errors-telling-me-eslint-was-configured-to-run--however-that-tsconfig-does-not--none-of-those-tsconfigs-include-this-file
            [string]$tsconfigEslintPath = '.\tsconfig.eslint.json'
            [hashtable]$tsconfigEslint = [ordered]@{
                extends         = './tsconfig.json'
                include         = @('./')
                compilerOptions = @{
                    noEmit = $true
                }
            }
            $tsconfigEslint | Export-MyJSON -LiteralPath $tsconfigEslintPath
            git add $tsconfigEslintPath
        }
        if ($UseJest) {
            # ref. https://www.npmjs.com/package/eslint-plugin-jest
            $eslintrc.env.Add('jest', $true)
            $eslintrc.plugins += 'jest'
            $eslintrc.extends += 'plugin:jest/all'
            $neededEslintPackages += 'eslint-plugin-jest'
        }
        $eslintrc.extends += 'prettier'
        npm i -D $neededEslintPackages
        [PSCustomObject]$eslintrc | Export-MyJSON -LiteralPath $eslintrcPath

        git add '.\.eslintrc.json' '.\package-lock.json' '.\package.json'
        git commit -m 'Add ESLint'
    }
}

Export-ModuleMember -Function Install-MyESLint
