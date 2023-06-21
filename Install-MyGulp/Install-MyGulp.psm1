<#
.SYNOPSIS
Adds gulp and its settings to the current directory.

.PARAMETER UseTypeScript
Whether to write gulpfile using TypeScript.

#>
function Install-MyGulp {
    param (
        [switch]$UseTypeScript
    )
    process {
        [string]$gulpFilePath = '.\gulpfile.js'

        if ($UseTypeScript) {
            $gulpFilePath = $gulpFilePath -replace '.js$', '.ts'
            npm i -D @types/gulp
        }
        npm i -D gulp gulp-cli
        New-Item -Path '.\' -Name $gulpFilePath -ItemType 'File'

        git add '.\package-lock.json' '.\package.json' $gulpFilePath
        git commit -m 'Add gulp'
    }
}

Export-ModuleMember -Function Install-MyGulp
