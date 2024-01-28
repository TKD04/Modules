<#
.SYNOPSIS
Adds React to the current directory.

.PARAMETER UseTypeScript
Whether to support TypeScript.

.PARAMETER UseStyledComponents
Whether to support StyledComponents.
#>
function Install-MyReact {
    [CmdletBinding()]
    [OutputType([void])]
    param (
        [switch]$UseTypeScript,
        [switch]$UseStyledComponents
    )
    process {
        npm i react react-dom
        if ($UseTypeScript) {
            npm i -D @types/react @types/react-dom
        }
        if ($UseStyledComponents) {
            npm i -D styled-components
        }

        git add '.\package-lock.json' '.\package.json'
        git commit -m 'Add React'
    }
}

Export-ModuleMember -Function Install-MyReact
