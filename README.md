# Dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Quick Setup (New Machine)

Install chezmoi and apply dotfiles in one command:

### Linux/MacOS (bash)

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply jpalmour --exclude=false '.ssh/**'
```

### Windows (pwsh)

1. Install PowerShell 7 and ChezMoi:
   ```pwsh
   winget install Microsoft.PowerShell twpayne.chezmoi
   ```
2. In a new `pwsh` session, apply this repo:
   ```pwsh
   chezmoi init --apply jpalmour --exclude=false '.ssh/**'
   ```

## Updating SSH Configurations

`.ssh/` generation is skipped by default as it depends on 1password and is slow. To update SSH configurations:

```bash
# Linux/macOS
chezmoi apply --exclude=false '.ssh/**'
```

```pwsh
# PowerShell
chezmoi apply --exclude=false '.ssh/**'
```