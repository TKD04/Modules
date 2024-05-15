<#
.SYNOPSIS
Adds the VSCode settings for Web to the current directory.

.PARAMETER UseStyledComponents
Whether to support styled-components.

.PARAMETER UseTailwindCss
Whether to support tailwindcss.
#>
function Install-MyVSCodeSettingsForWeb {
    [CmdletBinding()]
    [OutputType([void])]
    param (
        [switch]$UseStyledComponents,
        [switch]$UseTailwindCss
    )
    process {
        [PSCustomObject]$settings = [PSCustomObject]@{
            <# General #>
            'editor.formatOnSave'                        = $true
            'files.autoGuessEncoding'                    = $true
            'files.insertFinalNewline'                   = $true
            'files.trimFinalNewlines'                    = $true
            'files.trimTrailingWhitespace'               = $true
            <# Web #>
            'editor.defaultFormatter'                    = 'esbenp.prettier-vscode'
            'editor.tabSize'                             = 2
            <# HTML #>
            'editor.linkedEditing'                       = $true
            'emmet.variables'                            = @{
                'lang' = 'ja'
            }
            <# TypeScript/JavaScript #>
            'javascript.updateImportsOnFileMove.enabled' = 'always'
            'typescript.updateImportsOnFileMove.enabled' = 'always'
            <# Markdown #>
            '[markdown]'                                 = @{
                'files.trimTrailingWhitespace' = $false
            }
        }
        [PSCustomObject]$extensions = [PSCustomObject]@{
            'recommendations' = @(
                'dbaeumer.vscode-eslint'
                'davidanson.vscode-markdownlint'
                'esbenp.prettier-vscode'
                'orta.vscode-jest'
            )
        }

        if ($UseStyledComponents) {
            $extensions.recommendations += 'styled-components.vscode-styled-components'
        }
        if ($UseTailwindCss) {
            $extensions.recommendations += 'bradlc.vscode-tailwindcss'
        }

        Install-MyVSCodeSettings -Settings $settings -Extensions $extensions
    }
}

Export-ModuleMember -Function Install-MyVSCodeSettingsForWeb
