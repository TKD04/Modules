<#
.SYNOPSIS
Adds the web develop environment to the current directory.

.PARAMETER UseReact
Whether to support TypeScript.

.PARAMETER OnlyTs
Whether to support for only TypeScript files.

.PARAMETER UseDaysyUi
Whether to support daisyUI.
#>
function Install-MyEnvForWeb {
    [CmdletBinding()]
    [Alias('ienvweb')]
    [OutputType([void])]
    param (
        [switch]$UseReact,
        [switch]$OnlyTs,
        [switch]$UseDaysyUi
    )
    process {
        Initialize-MyGit
        Initialize-MyNpm
        if ($UseReact) {
            Install-MyTypeScript -UseReact
            Install-MyESLint -UseTypeScript -UseJest -UseBrower -UseReact
            Install-MyReact
        }
        else {
            Install-MyTypeScript
            Install-MyESLint -UseTypeScript -UseJest -UseBrower
        }
        Install-MyJest -UseBrowser -UseReact
        if ($OnlyTs) {
            Install-MyWebpack -OnlyTs
        }
        elseif ($UseDaysyUi) {
            Install-MyWebpack -UseDaisyUi
        }
        else {
            Install-MyWebpack
        }
        Install-MyVSCodeSettingsForWeb
    }
}

Export-ModuleMember -Function Install-MyEnvForWeb -Alias 'ienvweb'
