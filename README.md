# Dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Quick Setup

Install chezmoi and apply dotfiles in one command:

### Linux/MacOS (bash)

```bash
CHEZMOI_INCLUDE_SSH=1 sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply jpalmour
```

### Windows (pwsh)

1. Install PowerShell 7 and ChezMoi:
   ```pwsh
   winget install Microsoft.PowerShell twpayne.chezmoi
   ```
2. In a new `pwsh` session, apply this repo:
   ```pwsh
   $env:CHEZMOI_INCLUDE_SSH=1; chezmoi init --apply jpalmour
   ```

## Applying Changes

```bash
# Quick apply (skips .ssh/ generation)
ca

# Full apply (includes .ssh/ generation from 1Password)
ca-all
```
