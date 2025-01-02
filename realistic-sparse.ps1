param(
    [string]$Branch = "main",
    [string]$StartDate = "2025-01-01",
    [int]$TotalDays = 430
)

$ErrorActionPreference = "Stop"

$messages = @(
    "fix bug",
    "refactor code",
    "update docs",
    "improve performance",
    "add tests",
    "update dependencies",
    "implement feature",
    "shipping code"
)

$projects = @(
    "projects/web-app",
    "projects/api-service",
    "projects/data-pipeline",
    "projects/ml-model"
)

function Get-Message {
    return $messages | Get-Random
}

# Parse start date
$currentDate = [DateTime]::ParseExact($StartDate, "yyyy-MM-dd", $null)
$endDate = $currentDate.AddDays($TotalDays - 1)
$commitCount = 0

Write-Host "Rebuilding realistic history from $($currentDate.ToString('yyyy-MM-dd')) with smart gaps..."

$daysProcessed = 0

while ($currentDate -lt $endDate) {
    $dayOfWeek = $currentDate.DayOfWeek
    
    # Skip weekends 60% of the time
    if ($dayOfWeek -eq "Saturday" -or $dayOfWeek -eq "Sunday") {
        if ((Get-Random -Minimum 0 -Maximum 100) -lt 60) {
            Write-Host -NoNewline "-"
            $currentDate = $currentDate.AddDays(1)
            $daysProcessed++
            continue
        }
    }
    
    # Skip random weekdays 30% of the time (simulate days off)
    if ((Get-Random -Minimum 0 -Maximum 100) -lt 30) {
        Write-Host -NoNewline "-"
        $currentDate = $currentDate.AddDays(1)
        $daysProcessed++
        continue
    }
    
    # On a commit day: 30% chance of 2-3 commits, 70% chance of 1 commit
    $numCommits = if ((Get-Random -Minimum 0 -Maximum 100) -lt 30) { Get-Random -Minimum 2 -Maximum 4 } else { 1 }
    
    for ($i = 0; $i -lt $numCommits; $i++) {
        $project = $projects | Get-Random
        $filePath = "$project/activity.log"
        
        if (-not (Test-Path $project)) {
            New-Item -ItemType Directory -Path $project -Force | Out-Null
        }

        Add-Content -Path $filePath -Value $currentDate.ToString("yyyy-MM-dd HH:mm:ss") -ErrorAction SilentlyContinue
        
        git add -A > $null 2>&1
        
        $msg = Get-Message
        $env:GIT_AUTHOR_DATE = $currentDate.ToString("ddd MMM dd HH:mm:ss yyyy +0000")
        $env:GIT_COMMITTER_DATE = $currentDate.ToString("ddd MMM dd HH:mm:ss yyyy +0000")
        
        git commit -m "$msg [$project]" > $null 2>&1
        
        $commitCount++
        
        if ($numCommits -gt 1) {
            $currentDate = $currentDate.AddHours(6)
        }
    }
    
    if ($commitCount % 50 -eq 0) {
        Write-Host " [$commitCount commits]"
    } else {
        Write-Host -NoNewline "."
    }
    
    $currentDate = $currentDate.AddDays(1)
    $daysProcessed++
}

Write-Host "`n`nCreated $commitCount commits across $daysProcessed days (realistic sparse pattern)"
Write-Host "Pushing to $Branch..."
git push origin $Branch -f

Write-Host "Done! Realistic dev history with gaps and natural patterns."
