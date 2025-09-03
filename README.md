# Dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Quick Setup (New Machine)

Install chezmoi and apply dotfiles in one command:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply jpalmour
```

## Daily Usage

- **Pull latest changes**: `chezmoi update`
- **Navigae to source dir to edit files**: `chezmoi cd`
- **See what would change**: `chezmoi diff`
- **Apply changes**: `chezmoi apply`

## Repository Structure

- Supports Linux, macOS, and Windows
- Uses `.chezmoiignore` for OS-specific file management
- Template files (`.tmpl`) for machine-specific configurations