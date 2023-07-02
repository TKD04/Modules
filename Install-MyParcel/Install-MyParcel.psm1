<#
.SYNOPSIS
Adds parcel to the current directory.
#>
function Install-MyParcel {
    [CmdletBinding()]
    [OutputType([void])]
    param ()
    process {
        Add-MyNpmScript -NameToScript @{
            'dev'   = 'parcel build ./src/index.html'
            'watch' = 'parcel serve ./src/index.html --open'
        }
        Add-Content -LiteralPath '.\.gitignore' -Value '/.parcel-cache/'
        npm i -D parcel

        git add '.\.gitignore' '.\package-lock.json' '.\package.json'
        git commit -m 'Add parcel'
    }
}

Export-ModuleMember -Function Install-MyParcel
