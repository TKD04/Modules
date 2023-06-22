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
    }
}

Export-ModuleMember -Function Install-MyEnvForNonReact -Alias 'ienvnr'
