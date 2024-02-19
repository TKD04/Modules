<#
.SYNOPSIS
Adds the web develop environment to the current directory.

.PARAMETER UseReact
Whether to support TypeScript.

.PARAMETER OnlyTs
Whether to support for only TypeScript files.
#>
function Install-MyEnvForWeb {
    [CmdletBinding()]
    [Alias('ienvweb')]
    [OutputType([void])]
    param (
        [switch]$UseReact,
        [switch]$OnlyTs
    )
    process {
        Initialize-MyGit
        Initialize-MyNpm
        if ($UseReact) {
            Install-MyTypeScript -UseReact
            Install-MyReact -UseStyledComponents
            Install-MyESLint -UseTypeScript -UseJest -UseBrower -UseReact
        }
        else {
            Install-MyTypeScript
            Install-MyESLint -UseTypeScript -UseJest -UseBrower
        }
        Install-MyJest -UseBrowser
        if ($OnlyTs) {
            Install-MyWebpack -OnlyTs
        }
        else {
            Install-MyWebpack
        }
        Install-MyVSCodeSettingsForWeb
    }
}

Export-ModuleMember -Function Install-MyEnvForWeb -Alias 'ienvweb'
