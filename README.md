# Dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Quick Setup (New Machine)

Install chezmoi and apply dotfiles in one command:

### Linux/MacOS (bash)

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply jpalmour
```

### Windows (pwsh)

1. Install PowerShell 7 and ChezMoi:
   ```pwsh
   winget install Microsoft.PowerShell twpayne.chezmoi
   ```
2. In a new `pwsh` session, apply this repo:
   ```pwsh
   chezmoi init --apply jpalmour
   ```

## Repository Structure

- Supports Linux, macOS, and Windows
- Uses `.chezmoiignore` for OS-specific file management
- Template files (`.tmpl`) for machine-specific configurations

## Updating SSH Configurations

SSH configs skip 1Password prompts by default. To force update:

```pwsh
# PowerShell
$env:CHEZMOI_SKIP_SSH="false"; chezmoi apply; Remove-Item Env:\CHEZMOI_SKIP_SSH
```

```bash
# Bash
CHEZMOI_SKIP_SSH=false chezmoi apply
```
