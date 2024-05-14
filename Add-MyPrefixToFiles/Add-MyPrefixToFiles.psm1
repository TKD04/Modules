<#
.SYNOPSIS
Adds the given prefix to the filenames in the current directory.

.PARAMETER Prefix
The string to be added as a prefix to the filenames.
#>
function Add-MyPrefixToFiles {
    [CmdletBinding()]
    [Alias('addprefix')]
    [OutputType([void])]
    param (
        [Parameter(Mandatory)]
        [string]$Prefix
    )
    process {
        $files = Get-ChildItem -LiteralPath '.\' -File

        if ($files.Count -eq 0) {
            throw 'No files found in the current directory.'
        }

        foreach ($file in $files) {
            [string]$newName = $Prefix + $file.Name
            Rename-Item -LiteralPath $file.FullName -NewName $newName
        }
    }
}

Export-ModuleMember -Function Add-MyPrefixToFiles -Alias 'addprefix'
