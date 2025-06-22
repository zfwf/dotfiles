function mklink {     
    cmd /c mklink $args 
}


# starship
if (Get-Command "starship.exe" -ErrorAction SilentlyContinue) 
{ 
    $ENV:STARSHIP_CONFIG = "$HOME\.config\starship.toml"
    Invoke-Expression (&starship init powershell)
}

