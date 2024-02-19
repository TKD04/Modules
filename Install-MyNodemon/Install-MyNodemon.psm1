<#
.SYNOPSIS
Adds nodemon to the current directory.
#>
function Install-MyNodemon {
    [CmdletBinding()]
    [OutputType([void])]
    param()
    process {
        Add-MyNpmScript -NameToScript @{
            'watch' = 'nodemon --watch src/**/*.ts --exec ts-node src/app.ts'
        }
        npm i -D nodemon

        git add '.\package-lock.json' '.\package.json'
        git commit -m 'Add nodemon'
    }
}

Export-ModuleMember -Function Install-MyNodemon
