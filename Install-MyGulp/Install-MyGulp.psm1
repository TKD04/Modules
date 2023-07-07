<#
.SYNOPSIS
Adds gulp to the current directory.
#>
function Install-MyGulp {
    [CmdletBinding()]
    [OutputType([void])]
    param ()
    process {
        npm i -D gulp gulp-cli
        New-Item -Path '.\' -Name 'gulpfile.mjs' -ItemType 'File'

        git add '.\package-lock.json' '.\package.json' '.\gulpfile.mjs'
        git commit -m 'Add gulp'
    }
}

Export-ModuleMember -Function Install-MyGulp
