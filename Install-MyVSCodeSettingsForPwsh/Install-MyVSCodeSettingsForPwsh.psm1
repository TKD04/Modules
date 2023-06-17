<#
.SYNOPSIS
Adds the VSCode settings for PowerShell to the current directory.
#>
function Install-MyVSCodeSetingsForPwsh {
    [CmdletBinding()]
    [OutputType([void])]
    param ()
    process {
        [PSCustomObject]$settings = [PSCustomObject]@{
            <# General #>
            'files.autoGuessEncoding'                      = $true
            'editor.formatOnSave'                          = $true
            'files.trimTrailingWhitespace'                 = $true
            'files.insertFinalNewline'                     = $true
            'files.trimFinalNewlines'                      = $true
            <# PowerShell #>
            'powershell.codeFormatting.autoCorrectAliases' = $true
            'powershell.codeFormatting.useCorrectCasing'   = $true
            'powershell.codeFormatting.useConstantStrings' = $true
            '[powershell]'                                 = @{
                'files.encoding' = 'utf8bom'
            }
        }
        [PSCustomObject]$extensions = [PSCustomObject]@{
            'recommendations' = @(
                'ms-vscode.powershell'
            )
        }

        Install-MyVSCodeSettings -Settings $settings -Extensions $extensions
    }
}

Export-ModuleMember -Function Install-MyVSCodeSettingsForPwsh
