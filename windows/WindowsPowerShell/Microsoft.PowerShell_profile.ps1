oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/gruvbox.omp.json" | Invoke-Expression

function OpenInVS() {
    $file = Get-ChildItem *.sln | Select-Object -ExpandProperty Name
    Invoke-expression ".\$file"
}

Set-Alias vs -value OpenInVS

Set-Alias ll ls

Set-Alias open explorer.exe

Set-PSReadlineKeyHandler -Chord Ctrl+f -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert('sessionizer')
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

$paths = 'C:\personal', 'C:\work', "$HOME"
function sessionizer() {
    $res = Get-ChildItem -Path $paths | Select-Object -ExpandProperty FullName | fzf
    $res = $res.trim()
    # Windows terminal open in new tab
    wt -w 0 powershell.exe -noexit -command "cd $res"
    # For just changing location in current powershell
    # Set-Location -Path $res
}

$env:Path += ";$HOME\bin"
