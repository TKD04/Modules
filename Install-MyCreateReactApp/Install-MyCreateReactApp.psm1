<#
.SYNOPSIS
Install Create-React-App in the current directory.
#>
function Install-MyCreateReactApp {
    [CmdletBinding()]
    [Alias('icra')]
    [OutputType([void])]
    param()
    process {
        # WARNING: Do not 'git init' on the root of the directory
        # since it prevents create-react-app from making each git structures.
        npm init -y
        npm i -D create-react-app
        Add-MyNpmScript -NameToScript @{
            'new' = 'create-react-app --template typescript'
        }
    }
}

Export-ModuleMember -Function Install-MyCreateReactApp -Alias 'icra'
