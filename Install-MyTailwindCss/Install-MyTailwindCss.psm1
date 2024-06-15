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
        npm i -D tailwindcss @tailwindcss/typography

        if ($IsNextJs) {
            if ($UseDaisyUi) {
                npm i -D daisyui@latest
                Copy-Item -LiteralPath "$PSScriptRoot\nextjs-daisyui-tailwind.config.ts" -Destination '.\tailwind.config.ts' -Force
            }
            Copy-Item -LiteralPath "$PSScriptRoot\nextjs-tailwind.config.ts" -Destination '.\tailwind.config.ts' -Force

            git add '.\package-lock.json' '.\package.json' '.\tailwind.config.ts'
            git commit -m 'Add Tailwind CSS'

            return
        }

        if ($UseDaisyUi) {
            npm i -D daisyui@latest
            Copy-Item -LiteralPath "$PSScriptRoot\daisyui-tailwind.config.js" -Destination '.\tailwind.config.js'
        }
        else {
            Copy-Item -LiteralPath "$PSScriptRoot\tailwind.config.js" -Destination '.\tailwind.config.js'
        }
        if ($IsVite) {
            Copy-Item -LiteralPath "$PSScriptRoot\vite-index.css" -Destination '.\src\index.css' -Force
            git add '.\src\index.css'
        }
        else {
            Copy-Item -LiteralPath "$PSScriptRoot\style.css" -Destination '.\style.css' -Force
            git add '.\style.css'
        }

        git add '.\package-lock.json' '.\package.json' '.\tailwind.config.js'
        git commit -m 'Add Tailwind CSS'
    }
}

Export-ModuleMember -Function Install-MyTailwindCss
