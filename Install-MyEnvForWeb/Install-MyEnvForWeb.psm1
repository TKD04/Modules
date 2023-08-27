<#
.SYNOPSIS
Adds the web develop environment to the current directory.

.PARAMETER UseTypeScript
Whether to support TypeScript.

.PARAMETER UseReact
Whether to support TypeScript.
#>
function Install-MyEnvForWeb {
    [CmdletBinding()]
    [Alias('ienvweb')]
    [OutputType([void])]
    param (
        [switch]$UseTypeScript,
        [switch]$UseReact
    )
    process {
        # TODO: Add UseTypeScript switch
        # TODO: Add UseReact switch
        Initialize-MyGit
        Initialize-MyNpm
        Install-MyTypeScript
        Install-MyESLint -UseTypeScript -UseJest -UseBrower
        Install-MyJest -UseTypeScript -UseBrowser
        Install-MyWebpack
        Install-MyVSCodeSettingsForWeb
    }
}

Export-ModuleMember -Function Install-MyEnvForWeb -Alias 'ienvweb'
