using namespace System.Management.Automation

# ref. https://devblogs.microsoft.com/scripting/use-a-powershell-function-to-see-if-a-command-exists/
<#
.SYNOPSIS
Tests whether the given commend exists.

.PARAMETER Command
A command to be test.
#>
function Test-MyCommandExists {
    [CmdletBinding()]
    [OutputType([bool])]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [string]$Command
    )
    process {
        [ActionPreference]$oldErrorActionPreference = $ErrorActionPreference
        $ErrorActionPreference = 'Stop'

        try {
            if (Get-Command -Name $Command) {
                $true
            }
        }
        catch {
            $false
        }
        finally {
            $ErrorActionPreference = $oldErrorActionPreference
        }
    }
}
