<#
.SYNOPSIS
Adds TypeDoc to the current directory.
#>
function Install-MyTypeDoc {
    [CmdletBinding()]
    [OutputType([void])]
    param ()
    process {
        Add-MyNpmScript -NameToScript @{
            'docs' = 'typedoc --out docs --entryPointStrategy expand src'
        }
        npm i -D typedoc

        git add '.\package-lock.json' '.\package.json'
        git commit -m 'Add TypeDoc'
    }
}

Export-ModuleMember -Function 'Install-MyTypeDoc'
