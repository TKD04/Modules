<#
.SYNOPSIS
Adds gulp to the current directory.

.PARAMETER UseTypeScript
Whether to add the rules for TypeScript.
#>
function Install-MyGulp {
    [CmdletBinding()]
    [OutputType([void])]
    param (
        [switch]$UseTypeScript
    )
    process {
        npm i -D gulp gulp-cli
        New-Item -Path '.\' -Name 'gulpfile.mjs' -ItemType 'File'

        if ($UseTypeScript) {
            npm i -D @types/gulp
        }

        git add '.\package-lock.json' '.\package.json' '.\gulpfile.mjs'
        git commit -m 'Add gulp'
    }
}

Export-ModuleMember -Function Install-MyGulp
