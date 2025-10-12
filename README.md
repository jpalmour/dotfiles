# Dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Quick Setup (New Machine)

Install chezmoi and apply dotfiles in one command:

### Linux/MacOS (bash)

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply jpalmour
```

### Windows (PowerShell)

```powershell
winget install twpayne.chezmoi
chezmoi init --apply jpalmour
```

## Repository Structure

- Supports Linux, macOS, and Windows
- Uses `.chezmoiignore` for OS-specific file management
- Template files (`.tmpl`) for machine-specific configurations
