<#
.SYNOPSIS
Converts image formats to the specified image formats using ImageMagick.

.PARAMETER Path
Specifies the path to the source files. You can use wildcards.

.PARAMETER Format
Specifies the output format.

.EXAMPLE
ConvertTo-MyImageFormats -Path '.\src\*.jpg' -Format 'webp'

.COMPONENT
ImageMagick
#>
function ConvertTo-MyImageFormats {
    [CmdletBinding()]
    [Alias('cif')]
    [OutputType([void])]
    param (
        [Parameter(Mandatory)]
        [ValidateScript({ Test-Path -Path $_ }) ]
        [string]$Path,
        [Parameter(Mandatory)]
        [ValidateSet('png', 'jpg', 'jpeg', 'webp', 'avif')]
        [string]$Format
    )
    process {
        [string]$destDir = '.\{0}' -f $Format
        if (!(Test-MyCommandExists -Command 'magick') ) {
            throw 'ImageMagick was not found.'
        }
        New-Item -Path '.\' -Name $destDir -ItemType 'Directory'

        magick.exe mogrify -format $Format -path $destDir $Path
    }
}

Export-ModuleMember -Function ConvertTo-MyImageFormats -Alias 'cif'
