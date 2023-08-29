<#
.SYNOPSIS
Adds React to the current directory.

.PARAMETER UseTypeScript
Whether to support TypeScript.
#>
function Install-MyReact {
    [CmdletBinding()]
    [OutputType([void])]
    param (
        [switch]$UseTypeScript
    )
    process {
        npm i react react-dom
        if ($UseTypeScript) {
            npm i -D @types/react @types/react-dom
        }

        git add '.\package-lock.json' '.\package.json'
        git commit -m 'Add React'
    }
}

Export-ModuleMember -Function Install-MyReact
