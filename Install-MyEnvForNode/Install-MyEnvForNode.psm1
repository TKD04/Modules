Import-Module -Name 'New-UserVariables'

<#
.SYNOPSIS
Adds the Node develop environment to the current directory.

.PARAMETER UseTypeScript
Whether to support TypeScript.

.PARAMETER UseJest
Whether to use Jest.
#>
function Install-MyEnvForNode {
    [CmdletBinding()]
    [Alias('ienvnode')]
    [OutputType([void])]
    param(
        [switch]$UseTypeScript,
        [switch]$UseJest
    )
    process {
        Initialize-MyGit
        Initialize-MyNpm
        if ($UseTypeScript -and $UseJest) {
            Install-MyTypeScript -UseNode
            Install-MyESLint -UseTypeScript -UseNode -UseJest
            Install-MyJest -UseTypeScript -UseNode
        }
        elseif ($UseTypeScript -and !$UseJest) {
            Install-MyTypeScript -UseNode
            Install-MyESLint -UseTypeScript -UseNode
        }
        elseif (!$UseTypeScript -and $UseJest) {
            Install-MyESLint -UseNode -UseJest
            Install-MyJest -UseNode
        }
        else {
            Install-MyESLint -UseNode
        }
        Install-MyVSCodeSettingsForWeb
        New-Item -Path '.\' -Name 'src' -ItemType 'Directory'
        if ($UseTypeScript) {
            Add-MyNpmScript -NameToScript @{
                'watch' = 'nodemon --watch "src/**/*.ts" --exec "ts-node" src/index.ts'
            }
            npm i -D ts-node nodemon

            git add '.\package-lock.json'
        }
        else {
            Add-MyNpmScript -NameToScript @{
                'watch' = 'node --watch "./src"'
            }
        }
        Join-Path -Path $gitignoreDirPath -ChildPath 'Node.gitignore' |
        Copy-Item -Destination '.\.gitignore'
        <# Add "type": "module" to package.json #>
        [hashtable]$package = Import-MyJSON -LiteralPath '.\package.json' -AsHashTable
        $package.Add('type', 'module')
        Export-MyJSON -LiteralPath '.\package.json' -CustomObject $package

        git add '.\.gitignore' '.\package.json'
        git commit -m 'Add environment for Node'
    }
}

Export-ModuleMember -Function Install-MyEnvForNode -Alias 'ienvnode'
