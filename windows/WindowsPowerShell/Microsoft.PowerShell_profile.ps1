oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/gruvbox.omp.json" | Invoke-Expression

function OpenInVS() {
    $file = Get-ChildItem *.sln | Select-Object -ExpandProperty Name
    Invoke-expression ".\$file"
}

Set-Alias vs -value OpenInVS

Set-Alias nwt new-worktree.exe

Set-Alias ll ls

Set-Alias open explorer.exe

Set-PSReadlineKeyHandler -Chord Ctrl+f -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert('Sessionizer')
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

Set-PSREadlineKeyHandler -Chord Ctrl+g -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert('GoToWorktree')
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

$paths = 'C:\personal', 'C:\work', "$HOME"
function Sessionizer() {
    $res = Get-ChildItem -Path $paths | Select-Object -ExpandProperty FullName | fzf
    if ($null -eq $res) {
        return
    }
    $res = $res.trim()
    # Windows terminal open in new tab
    wt -w 0 powershell.exe -noexit -command "cd $res"
    # For just changing location in current powershell
    # Set-Location -Path $res
}

function GoToWorktree() {
    $res = Get-ChildItem -Path . | Select-Object -ExpandProperty FullName | fzf
    if ($null -eq $res) {
        return
    }

    $res = $res.trim()

    Set-Location -Path $res
}

$env:Path += ";$HOME\bin"
