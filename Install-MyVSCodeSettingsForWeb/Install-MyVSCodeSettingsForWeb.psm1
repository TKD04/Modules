<#
.SYNOPSIS
Adds the VSCode settings for Web to the current directory.
#>
function Install-MyVSCodeSettingsForWeb {
    [CmdletBinding()]
    [OutputType([void])]
    param ()
    process {
        [PSCustomObject]$settings = [PSCustomObject]@{
            <# General #>
            'editor.formatOnSave'                                = $true
            'files.autoGuessEncoding'                            = $true
            'files.insertFinalNewline'                           = $true
            'files.trimFinalNewlines'                            = $true
            'files.trimTrailingWhitespace'                       = $true
            <# Web #>
            'editor.defaultFormatter'                            = 'esbenp.prettier-vscode'
            'editor.tabSize'                                     = 2
            <# HTML #>
            'editor.linkedEditing'                               = $true
            'emmet.variables'                                    = @{
                'lang' = 'ja'
            }
            <# TypeScript/JavaScript #>
            'typescript.preferences.importModuleSpecifierEnding' = 'js'
            'typescript.updateImportsOnFileMove.enabled'         = 'always'
            'javascript.preferences.importModuleSpecifierEnding' = 'js'
            'javascript.updateImportsOnFileMove.enabled'         = 'always'
            <# Markdown #>
            '[markdown]'                                         = @{
                'files.trimTrailingWhitespace' = $false
            }
        }
        [PSCustomObject]$extensions = [PSCustomObject]@{
            'recommendations' = @(
                'dbaeumer.vscode-eslint',
                'davidanson.vscode-markdownlint',
                'esbenp.prettier-vscode',
                'orta.vscode-jest'
            )
        }

        Install-MyVSCodeSettings -Settings $settings -Extensions $extensions
    }
}

Export-ModuleMember -Function Install-MyVSCodeSettingsForWeb
