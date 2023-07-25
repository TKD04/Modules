<#
.SYNOPSIS
Adds the web develop environment to the current directory.
#>
function Install-MyEnvForWeb {
    [CmdletBinding()]
    [Alias('ienvweb')]
    [OutputType([void])]
    param ()
    process {
        # TODO: Add UseTypeScript switch
        # TODO: Add UseReact switch
        Initialize-MyGit
        Initialize-MyNpm
        Install-MyTypeScript
        Install-MyESLint -UseTypeScript -UseJest -UseBrower
        Install-MyJest -UseTypeScript -UseBrowser
        Install-MyPrettier
        Install-MyWebpack
        Install-MyVSCodeSettingsForWeb
    }
}

Export-ModuleMember -Function Install-MyEnvForWeb -Alias 'ienvweb'
