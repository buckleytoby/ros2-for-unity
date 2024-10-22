$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition

if (([string]::IsNullOrEmpty($Env:ROS_DISTRO)))
{
    Write-Host "Can't detect ROS2 version. Source your ros2 distro first. Foxy, Galactic, Humble, and Iron are supported." -ForegroundColor Red
    exit
}

$ros2cs_repos = Join-Path -Path $scriptPath -ChildPath "\ros2cs.repos"
$custom_repos = Join-Path -Path $scriptPath -ChildPath "\ros2_for_unity_custom_messages.repos"

Write-Host "========================================="
Write-Host "* Pulling ros2cs repository:"
vcs import --input $ros2cs_repos

Write-Host ""
Write-Host "========================================="
Write-Host "Pulling custom repositories:"
vcs import --input $custom_repos

Write-Host ""
Write-Host "========================================="
Write-Host "Pulling ros2cs dependencies:"
& "$scriptPath/src/ros2cs/get_repos.ps1"
