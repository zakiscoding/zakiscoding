## Repository Overview

This workspace contains a multi-project sandbox:

- `projects/web-app`
- `projects/api-service`
- `projects/data-pipeline`
- `projects/ml-model`

## Utility Scripts

### `realistic-sparse.ps1`

Generates sparse commit activity across project folders.

Examples:

```powershell
./realistic-sparse.ps1 -Branch main -StartDate 2025-01-01 -TotalDays 90 -DryRun
./realistic-sparse.ps1 -Branch main -StartDate 2025-01-01 -TotalDays 90
./realistic-sparse.ps1 -Branch main -StartDate 2025-01-01 -TotalDays 90 -ForcePush
```

Notes:

- Use `-DryRun` to preview commit volume without writing commits.
- `-ForcePush` is optional and should only be used intentionally.
