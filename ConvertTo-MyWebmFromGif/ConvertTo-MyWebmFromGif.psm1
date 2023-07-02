<#
.SYNOPSIS
Converts GIF images to WebM videos using FFmpeg.

.PARAMETER Path
Specifies the path to the source GIF files. You can use wildcards.

.EXAMPLE
ConvertTo-MyWebmFromGif -Path '.\src\*.gif'

.COMPONENT
FFmpeg
#>
function ConvertTo-MyWebmFromGif {
    [CmdletBinding()]
    [Alias('cwg')]
    [OutputType([void])]
    param (
        [ValidateScript({ ($_.EndsWith('.gif')) -and (Test-Path -Path $_) })]
        [string]$Path = '.\*.gif'
    )
    process {
        [string]$destDir = '.\from-gif-to-webm'
        if (!(Test-MyCommandExists -Command 'ffmpeg')) {
            throw 'FFmpeg was not found.'
        }
        if (!(Test-MyStrictPath -LiteralPath $destDir)) {
            New-Item -Path $destDir -ItemType 'Directory'
        }

        Get-ChildItem -Path $Path -File | ForEach-Object {
            [string]$destFileName = $_.Name -replace '.gif$', '.webm'
            [string]$destPath = Join-Path -Path $destDir -ChildPath $destFileName
            # ref. https://web.dev/replace-gifs-with-videos/#create-webm-videos
            ffmpeg.exe -i $_.FullName -c vp9 -b:v 0 -crf 41 $destPath
        }
    }
}

Export-ModuleMember -Function ConvertTo-MyWebmFromGif -Alias 'cwg'
