# Set variables
$folderName = "CLP-Config"
$folderPath = "${env:ProgramFiles}\$folderName"
$OneDriveUrl = "https://clpartnership.s3.amazonaws.com/uploads/asset_image/2_198.jpg?ts=1691652797"
$LocalPath = "$folderPath\CLP-Wallpaper-01.jpg"

# Check if the folder already exists
if(!(Test-Path -Path $folderPath )){
    # Create the folder
    New-Item -ItemType directory -Path $folderPath
    Write-Host "Directory Created: $folderPath"
} else {
    Write-Host "Directory Already Exists: $folderPath"
}

# Download image from OneDrive
Invoke-WebRequest -Uri $OneDriveUrl -OutFile $LocalPath

# Add a delay
Start-Sleep -Seconds 10

# Check if image exists
if (Test-Path $LocalPath) {
    # Set desktop wallpaper
    Add-Type @"
using System;
using System.Runtime.InteropServices;
using Microsoft.Win32;
namespace Wallpaper {
   public static class Setter {
      public const int SetDesktopWallpaper = 20;
      public const int UpdateIniFile = 0x01;
      public const int SendWinIniChange = 0x02;
      [DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
      private static extern int SystemParametersInfo (int uAction, int uParam, string lpvParam, int fuWinIni);
      public static void SetWallpaper ( string path ) {
         SystemParametersInfo( SetDesktopWallpaper, 0, path, UpdateIniFile | SendWinIniChange );
      }
   }
}
"@
    [Wallpaper.Setter]::SetWallpaper($LocalPath)
}
