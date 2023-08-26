<#
.SYNOPSIS
Adds webpack to the current directory.
#>
function Install-MyWebpack {
    [CmdletBinding()]
    [OutputType([void])]
    param ()
    process {
        [string[]]$neededPackages = @(
            'webpack'
            'webpack-cli'
            'webpack-dev-server'
            'pug-plugin'
            'css-loader'
            'postcss-loader'
            'postcss'
            'autoprefixer'
            'sass-loader'
            'sass'
            'ts-loader'
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
        New-Item -Path '.\src' -Name 'icons' -ItemType 'Directory'
        New-Item -Path '.\src' -Name 'pug' -ItemType 'Directory'
        New-Item -Path '.\src' -Name 'scss' -ItemType 'Directory'
        New-Item -Path '.\src' -Name 'ts' -ItemType 'Directory'
        [string]$srcLayoutPug = Join-Path -Path $PSScriptRoot -ChildPath '.\_layout.pug'
        Copy-Item -LiteralPath $srcLayoutPug -Destination '.\src\pug\_layout.pug'
        [string]$srcWebpackConfigPath = Join-Path -Path $PSScriptRoot -ChildPath '.\webpack.config.js'
        Copy-Item -LiteralPath $srcWebpackConfigPath -Destination '.\webpack.config.js'
        <# Add "sideEffects: false" to package.json #>
        [hashtable]$package = Import-MyJSON -LiteralPath '.\package.json' -AsHashTable
        $package.Add('sideEffects', $false)
        Export-MyJSON -LiteralPath '.\package.json' -CustomObject $package
        <# Add npm scripts #>
        Add-MyNpmScript -NameToScript @{
            'dev'   = 'webpack --mode development --devtool eval-cheap-module-source-map'
            'watch' = 'webpack serve --open --mode development --devtool eval-cheap-module-source-map'
            'build' = 'webpack --mode production'
        }
        npm i -D $neededPackages

        git add '.\package-lock.json' '.\package.json' '.\webpack.config.js' '.\src\pug\_layout.pug'
        git commit -m 'Add webpack'
    }
}

Export-ModuleMember -Function Install-MyWebpack
