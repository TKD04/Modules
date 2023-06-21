Import-Module -Name 'New-UserVariables'

<#
.SYNOPSIS
Adds the Node develop environment to the current directory.
#>
function Install-MyEnvForNode {
    [CmdletBinding()]
    [Alias('ienvnode')]
    [OutputType([void])]
    param()
    process {
        Initialize-MyGit
        Initialize-MyNpm
        Install-MyTypeScript -UseNode
        Install-MyESLint -UseNode -UseTypeScript -UseJest
        Install-MyJest
        Install-MyVSCodeSettingsForWeb
        New-Item -Path '.\' -Name 'src' -ItemType 'Directory'
        Add-MyNpmScript -NameToScript @{
            'dev'   = 'nodemon --watch "src/**/*.ts" --exec "ts-node" src/index.ts'
            'build' = 'tsc -p .'
        }
        Join-Path -Path $gitignoreDirPath -ChildPath 'Node.gitignore' |
        Copy-Item -Destination '.\.gitignore'
        npm i -D ts-node nodemon

        git add '.\.eslintrc.json' '.\.gitignore' '.\package.json'
        git commit -m 'Add environment for Node'
    }
}

Export-ModuleMember -Function Install-MyEnvForNode -Alias 'ienvnode'
