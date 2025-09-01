# Dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Quick Setup (New Machine)

Install chezmoi and apply dotfiles in one command:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply jpalmour
```

## Manual Setup

1. Install chezmoi:
   ```bash
   sh -c "$(curl -fsLS get.chezmoi.io)"
   ```

2. Initialize and apply dotfiles:
   ```bash
   chezmoi init --apply jpalmour
   ```

## Daily Usage

- **Pull latest changes**: `chezmoi update`
- **Edit a file**: `chezmoi edit ~/.zshrc`
- **See what would change**: `chezmoi diff`
- **Apply changes**: `chezmoi apply`

## Repository Structure

- Supports Linux, macOS, and Windows
- Uses `.chezmoiignore` for OS-specific file management
- Template files (`.tmpl`) for machine-specific configurations
- See `CLAUDE.md` for detailed development guidelines