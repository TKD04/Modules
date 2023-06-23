<#
.SYNOPSIS
Adds ts-node to the current directory.
#>
function Install-MyTSNode {
    [CmdletBinding()]
    [OutputType([void])]
    param ()
    process {
        [hashtable]$tsConfigTsnode = [ordered]@{
            esm     = $true
            require = @('ts-node/register')
            swc     = $true
        }

        [hashtable]$tsConfig = Import-MyJSON -LiteralPath '.\tsconfig.json' -AsHashTable
        $tsConfig.Add('ts-node', $tsConfigTsnode)
        Export-MyJSON -LiteralPath '.\tsconfig.json' -CustomObject $tsConfig
        npm i -D ts-node @swc/core @swc/helpers

        git add '.\package-lock.json' '.\package.json' '.\tsconfig.json'
        git commit -m 'Add ts-node'
    }
}

Export-ModuleMember -Function 'Install-MyTSNode'
