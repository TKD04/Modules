[string]$Global:gitignoreDirPath = 'D:\dev\gitignore'

[string[]]$variablesToExport = @(
    '$gitignoreDirPath'
)

Export-ModuleMember -Variable $variablesToExport
