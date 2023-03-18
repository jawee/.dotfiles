oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/gruvbox.omp.json" | Invoke-Expression

function GoToWork {
    GoToPath -Path C:\work\
}

function GoToPersonal {
    GoToPath -Path C:\personal\
}

function GoToPath([string]$Path) {
    Set-Location $Path
}

function OpenInVS() {
    $file = Get-ChildItem *.sln | Select-Object -ExpandProperty Name
    Invoke-expression ".\$file"
}

Set-Alias vs -value OpenInVS

Set-Alias work -value GoToWork
Set-Alias personal -value GoToPersonal

Set-Alias ll ls

Set-Alias open explorer.exe

Set-PSReadlineKeyHandler -Chord Ctrl+f -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert('sessionizer')
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

$paths = 'C:\personal', 'C:\work'
function sessionizer() {
    $res = Get-ChildItem -Path $paths | Select-Object -ExpandProperty FullName | fzf
    $res = $res.trim()
    Set-Location -Path $res
}

$env:Path += ";$HOME\bin"
