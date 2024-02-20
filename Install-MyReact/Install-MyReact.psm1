<#
.SYNOPSIS
Adds React to the current directory.
#>
function Install-MyReact {
    [CmdletBinding()]
    [OutputType([void])]
    param (
        [switch]$UseTypeScript
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

        npm i $neededPackages
        npm i -D $neededDevPackages

        git add '.\package-lock.json' '.\package.json'
        git commit -m 'Add React'
    }
}

Export-ModuleMember -Function Install-MyReact
