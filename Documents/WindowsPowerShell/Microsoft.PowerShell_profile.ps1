# x-cmd
if (Test-Path "$HOME\.x-cmd.root\local\data\pwsh\_index.ps1") { Set-ExecutionPolicy Bypass -Scope Process; . "$HOME\.x-cmd.root\local\data\pwsh\_index.ps1" };  # boot up x-cmd.

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
