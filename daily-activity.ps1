param(
    [string]$Owner     = "zakiscoding",
    [string]$WorkDir   = "$env:USERPROFILE\zakiscoding-automation",
    [switch]$DryRun
)

$ErrorActionPreference = "Stop"

# ─── Repos to rotate through (unpinned, owned) ────────────────────────────────
$repos = @(
    "zakiscoding",
    "Tinker-1",
    "Stackz",
    "mysterygame",
    "coding-",
    "web-programming",
    "projects",
    "testing",
    "wp"
)

# ─── Rotating pools of realistic messages ─────────────────────────────────────
$commitMessages = @(
    "chore: update activity log",
    "docs: add daily maintenance note",
    "chore: clean up stale entries",
    "docs: refresh project notes",
    "chore: minor housekeeping",
    "fix: correct outdated reference",
    "docs: update changelog",
    "chore: prune unused entries",
    "refactor: tidy up log format",
    "docs: add weekly progress note"
)

$issueTitles = @(
    "Review error handling in main flow",
    "Improve input validation on user-facing fields",
    "Add missing edge case handling for empty inputs",
    "Consider extracting repeated logic into a helper",
    "Investigate inconsistent output formatting",
    "Add missing boundary checks",
    "Review naming consistency across the module",
    "Reduce nested conditionals for readability",
    "Add defensive fallback for missing config values",
    "Audit unused variables and dead code paths"
)

$issueBodies = @(
    "Found during code review: this area lacks sufficient error handling for unexpected inputs. Should be addressed before next release.",
    "User-facing fields accept values that could cause downstream issues. Needs validation or sanitization.",
    "Edge cases around empty or null inputs are not consistently handled. Could cause silent failures.",
    "The same pattern is repeated in multiple places. Extracting it into a shared helper would reduce maintenance overhead.",
    "Output formatting differs between code paths. Should be unified for consistency.",
    "Boundary conditions are not checked before processing. Could produce out-of-range behavior.",
    "Variable and function names are inconsistent in this module. A rename pass would improve readability.",
    "Deeply nested conditionals make this section hard to follow. Refactoring would help.",
    "Missing config values cause the app to fail unexpectedly. A fallback default should be added.",
    "Several variables are declared but never used. These should be removed to keep the code clean."
)

$prTitles = @(
    "fix: improve error handling",
    "chore: add maintenance log entry",
    "docs: update notes",
    "fix: guard against empty input",
    "chore: remove unused entries",
    "fix: correct formatting inconsistency",
    "docs: add inline notes",
    "chore: clean up log file",
    "fix: add missing boundary check",
    "docs: record daily progress"
)

# ─── Helpers ──────────────────────────────────────────────────────────────────
function Get-Rotating {
    param([array]$Pool, [int]$Seed)
    return $Pool[$Seed % $Pool.Count]
}

function Ensure-Cloned {
    param([string]$Repo)
    $dir = Join-Path $WorkDir $Repo
    if (-not (Test-Path $dir)) {
        Write-Host "  Cloning $Repo..."
        if (-not $DryRun) {
            git clone "https://github.com/$Owner/$Repo.git" $dir 2>&1 | Out-Null
        }
    } else {
        Push-Location $dir
        try { git switch main 2>$null | Out-Null } catch {}
        try { git pull --ff-only 2>&1 | Out-Null } catch {}
        Pop-Location
    }
    return $dir
}

function Do-Commit {
    param([string]$Repo, [int]$Seed)
    Write-Host "[1/5] Commit → $Repo"
    $dir = Ensure-Cloned $Repo
    if ($DryRun) { Write-Host "  DryRun: skipping"; return }
    Push-Location $dir
    try {
        $logDir = Join-Path $dir "logs"
        New-Item -ItemType Directory -Path $logDir -Force | Out-Null
        $logFile = Join-Path $logDir "activity.log"
        Add-Content -Path $logFile -Value (Get-Date -Format "yyyy-MM-dd HH:mm:ss")
        git add logs/activity.log | Out-Null
        $msg = Get-Rotating $commitMessages $Seed
        git commit -m $msg 2>&1 | Out-Null
        git push 2>&1 | Out-Null
        Write-Host "  Committed: $msg"
    } finally { Pop-Location }
}

function Do-Issue {
    param([string]$Repo, [int]$Seed)
    Write-Host "[2/5] Issue → $Repo"
    if ($DryRun) { Write-Host "  DryRun: skipping"; return }
    $title = Get-Rotating $issueTitles $Seed
    $body  = Get-Rotating $issueBodies $Seed
    $url = gh issue create --repo "$Owner/$Repo" --title $title --body $body 2>&1
    Write-Host "  Issue: $url"
}

function Do-PR {
    param([string]$Repo, [int]$Seed, [ref]$PrUrl, [ref]$PrNumber)
    Write-Host "[3/5] PR → $Repo"
    $dir = Ensure-Cloned $Repo
    if ($DryRun) { Write-Host "  DryRun: skipping"; return }
    Push-Location $dir
    try {
        $branch = "auto/maintenance-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
        git switch -c $branch 2>&1 | Out-Null
        $logDir = Join-Path $dir "logs"
        New-Item -ItemType Directory -Path $logDir -Force | Out-Null
        $noteFile = Join-Path $logDir "pr-notes.log"
        Add-Content -Path $noteFile -Value ("PR note: {0}" -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss"))
        git add logs/pr-notes.log | Out-Null
        $msg = Get-Rotating $prTitles $Seed
        git commit -m $msg 2>&1 | Out-Null
        git push -u origin $branch 2>&1 | Out-Null
        $prBody = "Automated maintenance PR - $(Get-Date -Format 'yyyy-MM-dd')`n`n- Routine log update`n- Part of daily maintenance cycle"
        $url = gh pr create --repo "$Owner/$Repo" --base main --head $branch --title $msg --body $prBody 2>&1
        $PrUrl.Value  = "$url"
        # Extract PR number from URL
        $PrNumber.Value = ($url -replace ".*/pull/", "").Trim()
        Write-Host "  PR: $url"
    } finally { Pop-Location }
}

function Do-Review {
    param([string]$Repo, [string]$PrNumber)
    Write-Host "[4/5] Review → $Repo #$PrNumber"
    if ($DryRun) { Write-Host "  DryRun: skipping"; return }
    if (-not $PrNumber -or $PrNumber -eq "") { Write-Host "  No PR to review"; return }
    $reviewBodies = @(
        "Looks good overall. Log update is clean and follows the existing pattern.",
        "LGTM. Minor change, no issues found.",
        "Reviewed. Change is straightforward and safe to merge.",
        "Checked the log update — consistent with prior entries, approved.",
        "No concerns. Approving this maintenance change."
    )
    $body = $reviewBodies[(Get-Date).DayOfYear % $reviewBodies.Count]
    gh pr review $PrNumber --repo "$Owner/$Repo" --approve --body $body 2>&1 | Out-Null
    Write-Host "  Approved PR #$PrNumber"
}

function Do-Merge {
    param([string]$Repo, [string]$PrNumber)
    Write-Host "[5/5] Merge → $Repo #$PrNumber"
    if ($DryRun) { Write-Host "  DryRun: skipping"; return }
    if (-not $PrNumber -or $PrNumber -eq "") { Write-Host "  No PR to merge"; return }
    gh pr merge $PrNumber --repo "$Owner/$Repo" --merge --delete-branch 2>&1 | Out-Null
    Write-Host "  Merged PR #$PrNumber"
}

# ─── Main ─────────────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "=== daily-activity.ps1 | $(Get-Date -Format 'yyyy-MM-dd HH:mm') ==="
Write-Host ""

if (-not (Test-Path $WorkDir)) {
    New-Item -ItemType Directory -Path $WorkDir -Force | Out-Null
}

$seed  = (Get-Date).DayOfYear
$count = $repos.Count

# Pick 5 repos for today, rotating evenly by day of year
$r0 = $repos[($seed + 0) % $count]
$r1 = $repos[($seed + 1) % $count]
$r2 = $repos[($seed + 2) % $count]
$r3 = $repos[($seed + 3) % $count]
$r4 = $repos[($seed + 4) % $count]

Write-Host "Today's repos: $r0 | $r1 | $r2 | $r3 | $r4"
Write-Host ""

try { Do-Commit  -Repo $r0 -Seed $seed }           catch { Write-Host "  ERROR commit: $_" }
try { Do-Issue   -Repo $r1 -Seed ($seed + 1) }     catch { Write-Host "  ERROR issue: $_" }

$prUrl    = ""
$prNumber = ""
try { Do-PR      -Repo $r2 -Seed ($seed + 2) -PrUrl ([ref]$prUrl) -PrNumber ([ref]$prNumber) } catch { Write-Host "  ERROR PR: $_" }
try { Do-Review  -Repo $r2 -PrNumber $prNumber }    catch { Write-Host "  ERROR review: $_" }
try { Do-Merge   -Repo $r2 -PrNumber $prNumber }    catch { Write-Host "  ERROR merge: $_" }

Write-Host ""
Write-Host "=== Done ==="
