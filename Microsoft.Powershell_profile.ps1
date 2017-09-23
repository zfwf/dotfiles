If ((Get-Executionpolicy).ToString() -ne "RemoteSigned") {
	Set-Executionpolicy RemoteSigned;
}

If(Test-Path $env:ChocolateyInstall) {
	Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1" -Force;
}
Else {
	iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'));
}