<#
.SYNOPSIS
Converts images

.PARAMETER SrcPath
Specifies the path to the source files. You can use wildcards.

.PARAMETER DestDirPath
Specifies the path to the target directory.

.PARAMETER Format
Specifies the output format.

.COMPONENT
ImageMagick
#>
function ConvertTo-MyImageFormats {
    [CmdletBinding()]
    [Alias('cif')]
    [OutputType([void])]
    param (
        [Parameter(Mandatory)]
        [ValidateScript({ Test-Path -Path $_ -IsValid })]
        [string]$SrcPath,
        [Parameter(Mandatory)]
        [ValidateScript({ Test-Path -LiteralPath $_ -IsValid })]
        [string]$DestDirPath,
        [Parameter(Mandatory)]
        [ValidateSet('png', 'jpg', 'jpeg', 'webp', 'avif')]
        [string]$Format
    )
    process {
        if (!(Test-MyCommandExists -Command 'magick') ) {
            throw 'ImageMagick was not found.'
        }

        if (!(Test-MyStrictPath -LiteralPath $DestDirPath)) {
            [string]$parentDirPath = Split-Path $DestDirPath -Parent
            [string]$destDirName = Split-Path $DestDirPath -Leaf
            New-Item -Path $parentDirPath -Name $destDirName -ItemType 'Directory'
        }
        magick.exe mogrify -format $Format -path $DestDirPath $SrcPath
    }
}

Export-ModuleMember -Function ConvertTo-MyImageFormats -Alias 'cif'
