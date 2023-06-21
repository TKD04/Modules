<#
.SYNOPSIS
Adds the given VSCode settings to the current directory.
#>
function Install-MyVSCodeSettings {
    [CmdletBinding()]
    [OutputType([void])]
    param (
        [Parameter(ValueFromPipeline)]
        [PSCustomObject]$Settings,
        [PSCustomObject]$Extensions
    )
    process {
        if ($null -eq $Settings -or $null -eq $Extensions) {
            throw 'Either $Settings or $Extensions must be [PSCustomObject].'
        }

        if (!(Test-MyStrictPath -LiteralPath '.\.vscode')) {
            New-Item -Path '.\' -Name '.vscode' -ItemType 'Directory'
        }
        Push-Location -LiteralPath '.\.vscode'
        if ($null -ne $Settings) {
            $Settings | Export-MyJSON -LiteralPath '.\settings.json'
            git add '.\settings.json'
        }
        if ($null -ne $Extensions) {
            $Extensions | Export-MyJSON -LiteralPath '.\extensions.json'
            git add '.\extensions.json'
        }
        Pop-Location

        git commit -m 'Add .vscode'
    }
}

Export-ModuleMember -Function Install-MyVSCodeSettings
