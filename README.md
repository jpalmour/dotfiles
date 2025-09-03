# Dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Quick Setup (New Machine)

Install chezmoi and apply dotfiles in one command:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply jpalmour
```

## Daily Usage

- **Pull latest changes**: `chezmoi update`
- **Navigate to source dir to edit files**: `chezmoi cd`
- **See what would change**: `chezmoi diff`
- **Apply changes**: `chezmoi apply`

## External Dependencies

This repository uses `.chezmoiexternal.toml` to manage external dependencies like oh-my-zsh, plugins, and themes.

- **Initial setup**: After the first `chezmoi apply`, external files are downloaded automatically
- **Update externals**: Run `chezmoi --refresh-externals apply` to fetch the latest versions of external dependencies (respects the refresh period set in `.chezmoiexternal.toml`)
- **Note**: Regular `chezmoi apply` uses cached versions and only refreshes when the period expires (currently set to 168 hours/1 week)

## Repository Structure

- Supports Linux, macOS, and Windows
- Uses `.chezmoiignore` for OS-specific file management
- Template files (`.tmpl`) for machine-specific configurations