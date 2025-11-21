# NB Below should be idempotent

function mklink {
	# enable permission before running mklink (or win developer mode)
    cmd /c mklink $args
}

# vi mode
Install-Module -Name PSReadLine -Scope CurrentUser -AllowClobber -Force

# install x-cmd
[System.Text.Encoding]::GetEncoding("utf-8").GetString($(Invoke-WebRequest -Uri "https://get.x-cmd.com/x-cmd.ps1").RawContentStream.ToArray()) | Invoke-Expression

# git
x scoop install git
x scoop bucket add extras
x scoop install extras/git-credential-manager

# lang version manager
x scoop install nvs # nodejs
x scoop install rustup # rust
x scoop install uv # python

# tools
x scoop install make

# starship prompt
x scoop install starship

# nerd font
x scoop bucket add nerd-fonts
x scoop install nerd-fonts/CascadiaCode-NF

# update path for scoop shims
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","User") + ";" + [System.Environment]::GetEnvironmentVariable("Path","Machine")

# setup dotfiles
[System.Text.Encoding]::GetEncoding("utf-8").GetString($(Invoke-WebRequest -Uri "https://raw.githubusercontent.com/zfwf/dotfiles/refs/heads/main/install/setup-dotfiles.sh").RawContentStream.ToArray()) | Invoke-Expression

# setup git config
if (-not (Test-Path "$HOME/.gitconfig")) {
    mklink "%USERPROFILE%\.gitconfig" "%USERPROFILE%\.gitconfig_win"
}

# setup profile for PS5+
if (-not (Test-Path "$HOME/Documents/PowerShell")) {
    # create Documents\PowerShell directory
    New-Item -Path "$HOME\Documents\PowerShell" -ItemType Directory -Force | Out-Null
    # create a symlink to the PowerShell profile
    mklink "%USERPROFILE%\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" "%USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
    mklink "%APPDATA%\zed\settings.json" "%USERPROFILE%\.config\zed\settings.json"
}

# setup profile for zed
if (-not (Test-Path "%APPDATA%/zed")) {
    # create zed config directory
    New-Item -Path "%APPDATA%/zed" -ItemType Directory -Force | Out-Null
    # create a symlink to the PowerShell profile
    mklink "%APPDATA%\zed\settings.json" "%USERPROFILE%\.config\zed\settings.json"
    mklink "%APPDATA%\zed\keymap.json" "%USERPROFILE%\.config\zed\keymap.json"
}
