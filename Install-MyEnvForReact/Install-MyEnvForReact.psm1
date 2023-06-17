<#
.SYNOPSIS
Adds the React develop environment to the current directory.
#>
function Install-MyEnvForReact {
    [CmdletBinding()]
    [Alias('ienvre')]
    [OutputType([void])]
    param()
    process {
        # Remove ESLint config on package.json
        [string]$packagePath = '.\package.json'
        [PSCustomObject]$package = Import-MyJSON -LiteralPath $packagePath
        $package.PSObject.Properties.Remove('eslintConfig')
        Export-MyJSON -LiteralPath $packagePath -CustomObject $package

        Install-MyESLint -UseBrower -UseTypeScript -UseReact -UseJest

        git add .
        git commit -m 'Add environment for React'
        Install-MyVSCodeSettingsForWeb
    }
}

Export-ModuleMember -Function Install-MyEnvForReact -Alias 'ienvre'
