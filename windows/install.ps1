winget install JanDeDobbeleer.OhMyPosh

New-Item -ItemType SymbolicLink -Path "$HOME\bin" -Target bin

if (-not (Test-Path $HOME\Documents\WindowsPowerShell)) {
    New-Item -Path $HOME\Documents\WindowsPowerShell -ItemType Directory
}
New-Item -ItemType SymbolicLink -Path "$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" -Target ".\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"