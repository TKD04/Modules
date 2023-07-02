<#
.SYNOPSIS
Converts GIF images to MP4 videos using FFmpeg.

.PARAMETER Path
Specifies the path to the source GIF files. You can use wildcards.

.EXAMPLE
ConvertTo-MyMp4FromGif -Path '.\src\*.gif'

.COMPONENT
FFmpeg
#>
function ConvertTo-MyMp4FromGif {
    [CmdletBinding()]
    [Alias('cmg')]
    [OutputType([void])]
    param (
        [ValidateScript({ ($_.EndsWith('.gif')) -and (Test-Path -Path $_) })]
        [string]$Path = '.\*.gif'
    )
    process {
        [string]$destDir = '.\from-gif-to-mp4'
        if (!(Test-MyCommandExists -Command 'ffmpeg')) {
            throw 'FFmpeg was not found.'
        }
        if (!(Test-MyStrictPath -LiteralPath $destDir)) {
            New-Item -Path $destDir -ItemType 'Directory'
        }

        Get-ChildItem -Path $Path -File | ForEach-Object {
            [string]$destFileName = $_.Name -replace '.gif$', '.mp4'
            [string]$destPath = Join-Path -Path $destDir -ChildPath $destFileName
            # ref. https://web.dev/replace-gifs-with-videos/#create-mpeg-videos
            ffmpeg.exe -i $_.FullName -b:v 0 -crf 25 -f mp4 -vcodec libx264 -pix_fmt yuv420p $destPath
        }
    }
}

Export-ModuleMember -Function ConvertTo-MyMp4FromGif -Alias 'cmg'
