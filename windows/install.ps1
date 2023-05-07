Install-Module PsReadLine -Force

winget install JanDeDobbeleer.OhMyPosh

New-Item -ItemType SymbolicLink -Path "$HOME\bin" -Target bin

if (-not (Test-Path $HOME\Documents\WindowsPowerShell)) {
    New-Item -Path $HOME\Documents\WindowsPowerShell -ItemType Directory
}
New-Item -ItemType SymbolicLink -Path "$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" -Target ".\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
New-Item -ItemType SymbolicLink -Path "$HOME\.vsvimrc" -Target .vsvimrc
New-Item -ItemType SymbolicLink -Path "$env:AppData\Code\User\settings.json" -Target ".\vscode\settings.json"
