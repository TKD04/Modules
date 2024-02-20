Import-Module -Name 'New-UserVariables'

<#
.SYNOPSIS
Adds the Node develop environment to the current directory.

.PARAMETER UseJest
Whether to use Jest.

.PARAMETER AddWatch
Whether to add `watch` to npm scripts.
#>
function Install-MyEnvForNode {
    [CmdletBinding()]
    [Alias('ienvnode')]
    [OutputType([void])]
    param(
        [switch]$UseJest,
        [switch]$AddWatch
    )
    process {
        Initialize-MyGit
        Initialize-MyNpm
        Install-MyTypeScript -UseNode
        if ($UseJest) {
            Install-MyESLint -UseTypeScript -UseNode -UseJest
            Install-MyJest -UseNode
        }
        else {
            Install-MyESLint -UseTypeScript -UseNode
        }
        if ($AddWatch) {
            Install-MyTSNode
            Install-MyNodemon
        }
        Install-MyVSCodeSettingsForWeb
        Join-Path -Path $gitignoreDirPath -ChildPath 'Node.gitignore' |
        Copy-Item -Destination '.\.gitignore'
        New-Item -Path '.\' -Name 'src' -ItemType 'Directory'
        New-Item -Path '.\src' -Name 'app.ts' -ItemType 'File'

        git add '.\.gitignore' '.\package.json' '.\src\app.ts'
        git commit -m 'Add environment for Node'
    }
}

Export-ModuleMember -Function Install-MyEnvForNode -Alias 'ienvnode'
