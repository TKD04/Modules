<#
.SYNOPSIS
Adds a date prefix to the filenames in the current directory.
#>
function Add-MyDatePrefixToFiles {
    [CmdletBinding()]
    [Alias('adddateprefix')]
    [OutputType([void])]
    param ()
    process {
        [string]$yyMMdd = Get-Date -Format 'yyMMdd'

        Add-MyPrefixToFiles -Prefix '{0}_' -f $yyMMdd
    }
}

Export-ModuleMember -Function Add-MyDatePrefixToFiles -Alias 'adddateprefix'
