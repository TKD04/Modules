<#
.SYNOPSIS
Adds Express to the current directory.

.PARAMETER $UseTypeScript
Whether to add type definitions of Express.
#>
function Install-MyExpress {
    [CmdletBinding()]
    [OutputType([void])]
    param (
        [switch]$UseTypeScript
    )
    process {
        npm i express
        if ($UseTypeScript) {
            npm i -D @types/express
        }

        git add '.\package-lock.json' 'package.json'
        git commit -m 'Add Express'
    }
}

Export-ModuleMember -Function Install-MyExpress
