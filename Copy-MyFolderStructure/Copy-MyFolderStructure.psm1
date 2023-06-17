<#
.SYNOPSIS
Copies the folder structure of the given directory to the current directory.

.PARAMETER SrcPath
A source path to a directory to be copied.
#>
function Copy-MyFolderStructure {
    [CmdletBinding()]
    [Alias('copyfolderstructure')]
    [OutputType([void])]
    param(
        [string]$LiteralPath
    )
    process {
        [string]$absoluteSrcPath = Resolve-Path -LiteralPath $LiteralPath
        [string]$dirName = Split-Path -Path $absoluteSrcPath -Leaf
        [string]$destPath = '.\copied-folder-structure_{0}' -f $dirName

        if (!(Test-MyStrictPath -LiteralPath $absoluteSrcPath)) {
            throw 'Cannot find path {0} because it does not exist.' -f $absoluteSrcPath
        }
        if (!(Test-MyStrictPath -LiteralPath $destPath)) {
            New-Item -Path '.\' -Name $destPath -ItemType 'Directory'
        }

        # ref. https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/xcopy#parameter
        xcopy.exe /E /T $absoluteSrcPath $destPath
    }
}

Export-ModuleMember -Function 'Copy-MyFolderStructure' -Alias 'copyfolderstructure'
