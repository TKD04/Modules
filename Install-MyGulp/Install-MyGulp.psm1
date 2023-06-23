<#
.SYNOPSIS
Adds gulp and its settings to the current directory.
#>
function Install-MyGulp {
    param ()
    process {
        npm i -D gulp gulp-cli
        New-Item -Path '.\' -Name 'gulpfile.js' -ItemType 'File'

        git add '.\package-lock.json' '.\package.json' '.\gulpfile.js'
        git commit -m 'Add gulp'
    }
}

Export-ModuleMember -Function Install-MyGulp
