<#
.SYNOPSIS
Adds React to the current directory.

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
        [string[]]$neededPackages = @(
            'react'
            'react-dom'
        )
        [string[]]$neededDevPackages = @(
            '@types/react'
            '@types/react-dom'
        )

        if ($UseStyledComponents) {
            $neededDevPackages += 'styled-components'
        }
        npm i $neededPackages
        npm i -D $neededDevPackages

        git add '.\package-lock.json' '.\package.json'
        git commit -m 'Add React'
    }
}

Export-ModuleMember -Function Install-MyReact
