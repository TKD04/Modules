<#
.SYNOPSIS
Adds webpack to the current directory.

.PARAMETER OnlyTs
Whether to support for only TypeScript files.
#>
function Install-MyWebpack {
    [CmdletBinding()]
    [OutputType([void])]
    param (
        [switch]$OnlyTs
    )
    process {
        [string[]]$neededDevPackages = @(
            'webpack'
            'webpack-cli'
            'ts-loader'
        )
        [hashtable]$npmScripts = @{
            'build' = 'webpack --mode production'
        }

        if ($OnlyTs) {
            [string]$srcWebpackConfigPath = Join-Path -Path $PSScriptRoot -ChildPath '.\onlyts-webpack.config.js'
            Copy-Item -LiteralPath $srcWebpackConfigPath -Destination '.\webpack.config.js'
        }
        else {
            [string[]]$neededDevPackages += @(
                'webpack-dev-server'
                'pug-plugin'
                'css-loader'
                'postcss-loader'
                'postcss'
                'autoprefixer'
                'sass-loader'
                'sass'
                'css-minimizer-webpack-plugin'
                'terser-webpack-plugin'
                'image-minimizer-webpack-plugin'
                'imagemin'
                'imagemin-gifsicle'
                'imagemin-mozjpeg'
                'imagemin-pngquant'
                'imagemin-svgo'
            )

            <# Creates needed folders #>
            New-Item -Path '.\' -Name 'src' -ItemType 'Directory'
            New-Item -Path '.\src' -Name 'pug' -ItemType 'Directory'
            New-Item -Path '.\src' -Name 'scss' -ItemType 'Directory'
            New-Item -Path '.\src' -Name 'ts' -ItemType 'Directory'
            [string]$srcWebpackConfigPath = Join-Path -Path $PSScriptRoot -ChildPath '.\webpack.config.js'
            [string]$srcLayoutPug = Join-Path -Path $PSScriptRoot -ChildPath '.\_layout.pug'
            [string]$srcIndexPug = Join-Path -Path $PSScriptRoot -ChildPath '.\index.pug'
            Copy-Item -LiteralPath $srcWebpackConfigPath -Destination '.\webpack.config.js'
            Copy-Item -LiteralPath $srcLayoutPug -Destination '.\src\pug\_layout.pug'
            Copy-Item -LiteralPath $srcIndexPug -Destination '.\src\pug\index.pug'
            New-Item -Path '.\src\scss' -Name 'style.scss' -ItemType 'File'
            New-Item -Path '.\src\ts' -Name 'index.ts' -ItemType 'File'
            $npmScripts.Add(
                'dev',
                'webpack serve --open --mode development --devtool eval-cheap-module-source-map'
            )
        }
        <# Add "sideEffects: false" to package.json #>
        [hashtable]$package = Import-MyJSON -LiteralPath '.\package.json' -AsHashTable
        $package.Add('sideEffects', $false)
        Export-MyJSON -LiteralPath '.\package.json' -CustomObject $package
        <# Add npm scripts #>
        Add-MyNpmScript -NameToScript $npmScripts
        npm i -D $neededDevPackages

        git add '.\package-lock.json' '.\package.json' '.\webpack.config.js'
        if (!$OnlyTs) {
            git add '.\src'
        }
        git commit -m 'Add webpack'
    }
}

Export-ModuleMember -Function Install-MyWebpack
