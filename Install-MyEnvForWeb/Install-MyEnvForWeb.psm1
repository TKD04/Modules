<#
.SYNOPSIS
Adds the web develop environment to the current directory.

.PARAMETER OnlyTs
Whether to support for only TypeScript files.

.PARAMETER UseReact
Whether to support TypeScript.
#>
function Install-MyEnvForWeb {
    [CmdletBinding()]
    [Alias('ienvweb')]
    [OutputType([void])]
    param (
        [switch]$OnlyTs,
        [switch]$UseReact
    )
    process {
        if ($OnlyTs -and $UseReact) {
            throw 'Only either $OnlyTs or $UseReact can be enabled.'
        }

        Initialize-MyGit
        Initialize-MyNpm
        if ($OnlyTs) {
            Install-MyTypeScript
            Install-MyESLint -UseTypeScript -UseJest -UseBrower
            Install-MyJest -UseBrowser
            Install-MyPrettier
            Install-MyVSCodeSettingsForWeb
            return
        }
        if ($UseReact) {
            Install-MyTypeScript -UseReact
            Install-MyESLint -UseTypeScript -UseJest -UseBrower -UseReact
            Install-MyReact
            Install-MyJest -UseBrowser -UseReact
            Install-MyPrettier -UseTailwindcss
            Install-MyVSCodeSettingsForWeb
        }
        else {
            Install-MyTypeScript
            Install-MyESLint -UseTypeScript -UseJest -UseBrower
            Install-MyJest -UseBrowser
            Install-MyPrettier -UseTailwindcss
            Install-MyVSCodeSettingsForWeb
        }
        Install-MyWebpack
        Install-MyTypeDoc

        npm run format
        git add .
        git commit -m 'Format by prettier'
    }
}

Export-ModuleMember -Function Install-MyEnvForWeb -Alias 'ienvweb'
