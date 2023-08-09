# Set variables
$OneDriveUrl = "INSERT_ONEDRIVE_URL_HERE"
$LocalPath = "C:\Program Files\CLP-Config\wallpaper.jpg"

# Download image from OneDrive
Invoke-WebRequest -Uri $OneDriveUrl -OutFile $LocalPath

# Check if image exists
if (Test-Path $LocalPath) {
    # Set desktop wallpaper
    Set-ItemProperty -Path "HKCU:Control Panel\Desktop" -Name Wallpaper -Value $LocalPath
    rundll32.exe user32.dll, UpdatePerUserSystemParameters
}
