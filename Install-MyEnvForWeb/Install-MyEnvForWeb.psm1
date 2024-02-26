<#
.SYNOPSIS
Adds the web develop environment to the current directory.

.PARAMETER OnlyTs
Whether to support for only TypeScript files.

.PARAMETER UseReact
Whether to support TypeScript.

.PARAMETER UseDaysyUi
Whether to support daisyUI.
#>
function Install-MyEnvForWeb {
    [CmdletBinding()]
    [Alias('ienvweb')]
    [OutputType([void])]
    param (
        [switch]$OnlyTs,
        [switch]$UseReact,
        [switch]$UseDaysyUi
    )
    process {
        if ($OnlyTs -and ($UseReact -or $UseDaysyUi)) {
            throw 'Only either $OnlyTs or $UseReact and $UseDaisyUi can be enabled.'
        }

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
