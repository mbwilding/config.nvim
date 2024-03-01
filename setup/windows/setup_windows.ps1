function Get-GitHub-Release-Url-ByTag
{
    param(
        [string]$GitHubRepository,
        [string]$FilenamePattern,
        [string]$Tag
    )

    $releasesUri = "https://api.github.com/repos/$GitHubRepository/releases/tags/$Tag";
    $response = Invoke-RestMethod -Method "GET" -Uri $releasesUri;
    $assets = $response.assets;
    $specificReleases = $assets | Where-Object name -Match $FilenamePattern;

    if ($specificReleases.Count -eq 0)
    {
        Write-Error "No releases found matching the pattern.";
        return;
    } elseif ($specificReleases.Count -gt 1)
    {
        Write-Warning "Multiple releases found. Using the first one.";
    }

    $specificRelease = $specificReleases[0];
    $downloadUrl = $specificRelease.browser_download_url;
    $outputPath = "$env:TEMP\" + $specificRelease.name;
    Invoke-WebRequest -Uri $downloadUrl -OutFile $outputPath;

    if (!(Test-Path $outputPath))
    {
        Write-Error "Failed to download the file.";
        return;
    }

    # Install the release silently and wait for the installation to complete
    try
    {
        $arguments = "/i `"$outputPath`" /quiet /norestart";
        $process = Start-Process "msiexec.exe" -ArgumentList $arguments -Wait -PassThru;
        if ($process.ExitCode -ne 0)
        {
            Write-Error "Installation failed with exit code $($process.ExitCode).";
        }
    } catch
    {
        Write-Error "An error occurred during installation: $_";
    }
}

Get-GitHub-Release-Url-ByTag -GitHubRepository "neovim/neovim" -FilenamePattern "nvim-win64.msi" -Tag "nightly";

# Install software packages using winget
winget install Kitware.CMake zig.zig BurntSushi.ripgrep.MSVC OpenJS.NodeJS JesseDuffield.lazygit JanDeDobbeleer.OhMyPosh Golang.Go JernejSimoncic.Wget GnuWin32.UnZip GnuWin32.Zip 7zip.7zip Python.Python.3.12 RubyInstallerTeam.RubyWithDevKit.3.2 StrawberryPerl.StrawberryPerl

pip install cfn-lint
gem install cfn-nag

# Define the path for the PowerShell profile
$PowerShellDir = "$env:UserProfile\Documents\PowerShell"
$PowerShellProfile = "$PowerShellDir\Microsoft.PowerShell_profile.ps1"
$OMPLine = "oh-my-posh init pwsh | Invoke-Expression"

# Ensure the PowerShell directory exists
if (-not (Test-Path $PowerShellDir))
{
    Write-Host "Creating PowerShell Directory..."
    New-Item -Path $PowerShellDir -ItemType Directory
}

# Create PowerShell profile if it does not exist
if (-not (Test-Path $PowerShellProfile))
{
    Write-Host "Creating PowerShell Profile..."
    New-Item -Path $PowerShellProfile -ItemType File
}

# Check if oh-my-posh is already initialized in the profile
Write-Host "Checking if oh-my-posh is already initialized in the profile..."
$profileContent = @()
if (Test-Path $PowerShellProfile)
{
    $profileContent = Get-Content $PowerShellProfile
}

if ($profileContent -notcontains $OMPLine)
{
    Write-Host "Adding oh-my-posh init to the profile..."
    Add-Content -Path $PowerShellProfile -Value $OMPLine
} else
{
    Write-Host "oh-my-posh is already initialized in the profile."
}

rustup component add rust-analyzer

Write-Host "Done."
