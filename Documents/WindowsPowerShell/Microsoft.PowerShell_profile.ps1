function mklink {     
    cmd /c mklink $args 
}


# initialize once
$initFile = "$HOME\.posh-init"
if (-not (Test-Path $initFile)) {
    # vi mode
    Install-Module -Name PSReadLine -Scope CurrentUser

    # install scoop
    if (-not (Test-Path "$HOME\scoop")) {
        Write-Host "Installing Scoop..."
        Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
        scoop bucket add extras 
        scoop bucket add nerd-fonts
    }

    if (-not (Test-Path "$HOME/Documents/PowerShell")) {
        # create Documents\PowerShell directory
        New-Item -Path "$HOME\Documents\PowerShell" -ItemType Directory -Force | Out-Null
        # create a symlink to the PowerShell profile
        mklink "%USERPROFILE%\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" "%USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
    }

    # finish init
    New-Item -Path $initFile -ItemType File -Force | Out-Null
}

# initialize vfox once
$vfoxDir = "$HOME\.version-fox"
if (-not (Test-Path $vfoxDir)) {
    # install vfox
    if (Get-Command "vfox.exe" -ErrorAction SilentlyContinue) {
        # get latest version of vfox from github releases
        $latestRelease = Invoke-RestMethod -Uri "https://api.github.com/repos/version-fox/vfox/releases/latest"
        # derive the `tag_name` from the latest release, remove leading 'v'
        $fileVersion = $latestRelease.tag_name.TrimStart('v')
        # download the vfox installer zip file, using the tagName variable
        $vfoxInstallerUrl = "https://github.com/version-fox/vfox/releases/download/v${fileVersion}/vfox_${fileVersion}_windows_x86_64.zip"
        $vfoxInstallerPath = "$HOME\Downloads\vfox_installer.zip"
        Invoke-WebRequest -Uri $vfoxInstallerUrl -OutFile $vfoxInstallerPath
        # extract the zip file to the vfox directory
        New-Item -Path $vfoxDir -ItemType Directory -Force | Out-Null
        Expand-Archive -Path $vfoxInstallerPath -DestinationPath $vfoxDir -Force
        # remove the installer zip file
        Remove-Item -Path $vfoxInstallerPath -Force
    }
}

# add vfox to the PATH environment variable
if (-not (Get-Command "vfox.exe" -ErrorAction SilentlyContinue)) {
    # get path to vfox.exe
    $vfoxes = Get-ChildItem -Recurse $vfoxDir -Include vfox.exe -ErrorAction SilentlyContinue -Force 
    # get first vfox.exe found
    if ($vfoxes.Count -gt 0) {
        # get the directory of the first vfox.exe found
        $vfoxHome = $vfoxes[0].DirectoryName
        $env:PATH += ";$vfoxHome"

        # source vfox autocompletion script
        $vfoxCompletionScript = "$vfoxHome\completions\powershell_autocomplete.ps1"
        if (Test-Path $vfoxCompletionScript) {
            . $vfoxCompletionScript
        }
    }

}

# enable vi mode
Set-PSReadLineOption -EditMode Vi

# jk esc in vi mode start
$j_timer = New-Object System.Diagnostics.Stopwatch

Set-PSReadLineKeyHandler -Key j -ViMode Insert -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert("j")
    $j_timer.Restart()
}

Set-PSReadLineKeyHandler -Key k -ViMode Insert -ScriptBlock {
    if (!$j_timer.IsRunning -or $j_timer.ElapsedMilliseconds -gt 1000) {
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert("k")
    }
    else {
        [Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode()
        $line = $null
        $cursor = $null
        [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
        [Microsoft.PowerShell.PSConsoleReadLine]::Delete($cursor, 1)
        [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor - 1)
    }
}

Set-PSReadLineKeyHandler -Key Escape -ViMode Insert -ScriptBlock {
    if ($j_timer.IsRunning) {
        $j_timer.Stop()
    }
    [Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode()
}
# jk esc in vi mode end

# set vi mode indicator
Write-Host -NoNewLine "`e[5 q" # default to blinking line
function OnViModeChange {
    if ($args[0] -eq 'Command') {
        # Set the cursor to a blinking block.
        Write-Host -NoNewLine "`e[1 q"
    }
    else {
        # Set the cursor to a blinking line.
        Write-Host -NoNewLine "`e[5 q"
    }
}
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $Function:OnViModeChange


# override git so when using git in home directory, set --git-dir as $HOME/.cfg and --work-tree as $HOME
function git() {
    param(
        [Parameter(ValueFromRemainingArguments = $true)]
        $args
    )

    $updatedArgs = $args
    
    # if current directory is home directory, set git config to use $HOME\.cfg as git directory
    if ($PWD.Path -eq $HOME) {
        $gitDir = "$HOME\.cfg"
        $workTree = $HOME
        # add --git-dir and --work-tree to the args
        $updatedArgs = @("--git-dir=$gitDir", "--work-tree=$workTree") + $args
    }

    if (($updatedArgs -contains "push") -and ($updatedArgs -notcontains "--help")) {
        $updatedArgs = $updatedArgs + @("-u")
    }
    
    & git.exe @updatedArgs
}

# starship
if (Get-Command "starship.exe" -ErrorAction SilentlyContinue) { 
    $ENV:STARSHIP_CONFIG = "$HOME\.config\starship.toml"
    Invoke-Expression (&starship init powershell)
}
