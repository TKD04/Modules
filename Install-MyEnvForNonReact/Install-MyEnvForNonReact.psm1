<#
.SYNOPSIS
Adds the non-React develop environment to the current directory.
#>
function Install-MyEnvForNonReact {
    [CmdletBinding()]
    [Alias('ienvnr')]
    [OutputType([void])]
    param()
    process {
        Initialize-MyGit
        Initialize-MyNpm
        Install-MyTypeScript
        Install-MyESLint -UseBrower -UseTypeScript -UseJest
        Install-MyJest
        Install-MyVSCodeSettingsForWeb

        New-Item -Path '.\' -Name 'src' -ItemType 'Directory'
        Add-Content -LiteralPath '.\.gitignore' -Value '/dist/'
        git add '.\.eslintrc.json' '.\.gitignore'
        git commit -m 'Add environment for non-React'
    }
}

Export-ModuleMember -Function Install-MyEnvForNonReact -Alias 'ienvnr'
