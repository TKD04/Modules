<#
.SYNOPSIS
Adds Tailwind CSS to the current directory.

.PARAMETER IsVite
Whether to support a project created by Vite.

.PARAMETER IsNextJs
Whether to support a project created by NextJS.
#>
function Install-MyTailwindCss {
    [CmdletBinding()]
    [OutputType([void])]
    param (
        [switch]$IsVite,
        [switch]$IsNextJs
    )
    process {
        if ($IsVite -and $IsNextJs) {
            throw 'Only enable either $IsVite or $IsNextJs'
        }

        [string[]]$neededDevPackages = @(
            'tailwindcss'
            'postcss'
            'autoprefixer'
            '@tailwindcss/typography'
            "@tailwindcss/forms"
        )

        if ($IsNextJs) {
            npm i -D @tailwindcss/typography
            Copy-Item -LiteralPath "$PSScriptRoot\tailwind-nextjs.config.ts" -Destination '.\tailwind.config.ts' -Force

            git add '.\package-lock.json' '.\package.json' '.\tailwind.config.ts'
            git commit -m 'Add `@tailwindcss/typography`'

            return
        }
        if ($IsVite) {
            Copy-Item -LiteralPath "$PSScriptRoot\tailwind-vite.config.js" -Destination '.\tailwind.config.js' -Force
            Copy-Item -LiteralPath "$PSScriptRoot\index-vite.css" -Destination '.\src\index.css' -Force

            git add '.\src\index.css'
        }
        else {
            Copy-Item -LiteralPath "$PSScriptRoot\tailwind.config.js" -Destination '.\tailwind.config.js' -Force
            Copy-Item -LiteralPath "$PSScriptRoot\index.css" -Destination '.\index.css' -Force

            git add '.\index.css'
        }
        Copy-Item -LiteralPath "$PSScriptRoot\postcss.config.js" -Destination '.\postcss.config.js'
        npm i -D $neededDevPackages

        git add '.\package-lock.json' '.\package.json' '.\tailwind.config.js' '.\postcss.config.js'
        git commit -m 'Add Tailwind CSS'
    }
}

Export-ModuleMember -Function Install-MyTailwindCss
