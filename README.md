# Dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Quick Setup

Install chezmoi and apply dotfiles in one command:

### Linux/MacOS (bash)

```bash
CHEZMOI_FETCH_1PASS=1 sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply jpalmour
```

### Windows (pwsh)

1. Install PowerShell 7 and ChezMoi:
   ```pwsh
   winget install Microsoft.PowerShell twpayne.chezmoi
   ```
2. In a new `pwsh` session, apply this repo:
   ```pwsh
   $env:CHEZMOI_FETCH_1PASS=1; chezmoi init --apply jpalmour
   ```

## Applying Changes

```bash
# Quick apply (alias for `chezmoi apply`; skips 1Password-backed files)
ca

# Full apply (alias for `CHEZMOI_FETCH_1PASS=1 chezmoi apply`)
ca-all
```
