param(
    [string]$ScriptPath = "C:\Users\cashh\zakiscoding\daily-activity.ps1",
    [string]$TaskName   = "GitHubDailyActivity",
    [int]$Hour          = 10,
    [int]$Minute        = 0
)

$ErrorActionPreference = "Stop"

# Resolve absolute path
$ScriptPath = (Resolve-Path $ScriptPath).Path

Write-Host "Setting up daily GitHub activity scheduler..."
Write-Host "  Script : $ScriptPath"
Write-Host "  Time   : $($Hour.ToString('D2')):$($Minute.ToString('D2')) every day"
Write-Host "  Task   : $TaskName"
Write-Host ""

# Build the scheduled task
$action  = New-ScheduledTaskAction `
    -Execute "powershell.exe" `
    -Argument "-NonInteractive -WindowStyle Hidden -ExecutionPolicy Bypass -File `"$ScriptPath`""

$trigger = New-ScheduledTaskTrigger `
    -Daily `
    -At ([datetime]::Today.AddHours($Hour).AddMinutes($Minute))

$settings = New-ScheduledTaskSettingsSet `
    -ExecutionTimeLimit (New-TimeSpan -Hours 1) `
    -StartWhenAvailable `
    -RunOnlyIfNetworkAvailable

# Register (or update) the task for the current user, with highest privileges
$principal = New-ScheduledTaskPrincipal `
    -UserId $env:USERNAME `
    -LogonType S4U `
    -RunLevel Highest

# Remove any existing task with the same name first
Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false -ErrorAction SilentlyContinue

Register-ScheduledTask `
    -TaskName   $TaskName `
    -Action     $action `
    -Trigger    $trigger `
    -Settings   $settings `
    -Principal  $principal `
    -Description "Runs daily GitHub activity: commit, issue, PR, review, merge across rotating repos." `
    | Out-Null

Write-Host "Scheduler registered successfully."
Write-Host ""
Write-Host "What happens every day at $($Hour.ToString('D2')):$($Minute.ToString('D2')):"
Write-Host "  1. Commit       - pushes a small log update to a repo"
Write-Host "  2. Issue        - opens a code-review issue on a different repo"
Write-Host "  3. Pull Request - creates a branch + PR on a third repo"
Write-Host "  4. Review       - approves that PR with a short review comment"
Write-Host "  5. Merge        - merges the PR and deletes the branch"
Write-Host ""
Write-Host "Repos rotate daily across: zakiscoding, Tinker-1, Stackz, mysterygame,"
Write-Host "  coding-, web-programming, projects, testing, wp"
Write-Host ""
Write-Host "To verify the task is registered:"
Write-Host "  Get-ScheduledTask -TaskName '$TaskName'"
Write-Host ""
Write-Host "To run it right now manually:"
Write-Host "  Start-ScheduledTask -TaskName '$TaskName'"
Write-Host ""
Write-Host "To remove it:"
Write-Host "  Unregister-ScheduledTask -TaskName '$TaskName' -Confirm:`$false"
Write-Host ""
Write-Host "To run a dry run without touching GitHub:"
Write-Host "  & '$ScriptPath' -DryRun"
