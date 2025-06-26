param (
	[Parameter(Mandatory=$true)][string]$Path
)

Add-Type -AssemblyName System.Windows.Forms

Function Get-FolderName
{
[CmdletBinding()]
	[OutputType([string])]
	Param
	(
		# InitialDirectory help description
		[Parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			HelpMessage = "Initial Directory for browsing",
			Position = 0)]
		[String]$SelectedPath,

		# Description help description
		[Parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true,
			HelpMessage = "Message Box Title")]
		[String]$Description="Select a Folder",

		# ShowNewFolderButton help description
		[Parameter(
			Mandatory = $false,
			HelpMessage = "Show New Folder Button when used")]
		[Switch]$ShowNewFolderButton
	)

	# Load Assembly
	Add-Type -AssemblyName System.Windows.Forms

	# Open Class
	$FolderBrowser= New-Object System.Windows.Forms.FolderBrowserDialog

	# Define Title
	$FolderBrowser.Description = $Description

	# Define Initial Directory
	if (-Not [String]::IsNullOrWhiteSpace($SelectedPath))
	{
		$FolderBrowser.SelectedPath=$SelectedPath
	}

	if($folderBrowser.ShowDialog() -eq "OK")
	{
		$Folder += $FolderBrowser.SelectedPath
	}
	return $Folder
}

Write-Host "Creating junction in $Path"

$name = Read-Host -Prompt "Junction Name"

if ($name.Length -le 0) {
	Write-Host "No name provided. Exiting."
	exit
}

$target = Get-FolderName "$Path"

if ($target.Length -le 0) {
	Write-Host "No target provided. Exiting."
	exit
}

New-Item -ItemType Junction -Target "$target" -Name "$name" -Path "$Path"