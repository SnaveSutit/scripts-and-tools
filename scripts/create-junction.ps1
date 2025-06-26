param (
	# The path where the junction will be created
	[Parameter(Mandatory=$false)][string]$Path
	# The target path for the junction
	,[Parameter(Mandatory=$false)][string]$Target
	# The name of the junction
	,[Parameter(Mandatory=$false)][string]$Name
)

if (-not $Path) {
	$Path = (Get-Location).Path
}

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

if (-not $Name) {
	$Name = Read-Host -Prompt "Junction Name"
}

if ($Name.Length -le 0) {
	Write-Host "No name provided. Exiting."
	exit
}

if (-not $Target) {
	$Target = Get-FolderName "$Path" -Description "Select the target for the junction"
}

if ($Target.Length -le 0) {
	Write-Host "No target provided. Exiting."
	exit
}

New-Item -ItemType Junction -Target "$Target" -Name "$Name" -Path "$Path"