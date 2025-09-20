# Working with this Chezmoi Repository

## Overview
This is a chezmoi-managed dotfiles repository. Chezmoi is a tool for managing configuration files (dotfiles) across multiple machines using templates and version control.

This repository supports **three operating systems** (Linux, macOS, and Windows) and aims to:
- Be DRY (Don't Repeat Yourself) wherever possible
- Provide a consistent experience across all OSes
- Use `.chezmoiignore` to ensure appropriate resources are created on each OS

## Key Concepts

### Directory Structure
- **Source directory**: `chezmoi source-path` (this repository)
- **Target directory**: Your home directory (`~`)
- Files in this repo are templates/sources that get applied to your actual home directory

### File Naming Conventions
- `dot_` prefix: Becomes a dotfile (e.g., `dot_zshrc` → `~/.zshrc`)
- `.tmpl` suffix: Template file processed with variables
- `executable_` prefix: Makes file executable
- `private_` prefix: Removes group/world permissions
- `readonly_` prefix: Removes write permissions
- `create_` prefix: Creates file if it doesn't exist

### Multi-OS Support
- **.chezmoiignore**: Controls which files are applied on which OS
- Uses Go template syntax to conditionally ignore files based on OS, architecture, or other factors
- Example: Files specific to macOS can be ignored on Linux/Windows
- Enables DRY principles by sharing common configs while supporting OS-specific needs

## Essential Commands for Development

### Viewing Changes
- `chezmoi status` - Show what would change
- `chezmoi diff` - Show detailed differences
- `chezmoi data` - Show available template variables

### Making Changes
1. Edit files directly in this source directory
2. Test changes with `chezmoi diff` to preview
3. Ask user to apply changes with `chezmoi apply` to update actual dotfiles

## CRITICAL: Git Operations

### ⚠️ AI Assistants Must NEVER perform ANY git operations in this repository ⚠️
- DO NOT use `git add`, `git commit`, `git push`, or any other git commands
- DO NOT create pull requests
- DO NOT modify `.git` directory or git configuration
- The repository owner will handle ALL version control operations manually

## Working with Templates

Template files (`.tmpl` extension) can use Go template syntax:
- Access variables with `{{ .variable }}`
- Common variables include `{{ .chezmoi.hostname }}`, `{{ .chezmoi.os }}`, `{{ .chezmoi.arch }}`
- View all available data with `chezmoi data`

## Best Practices for AI Assistants

1. **Test before asking user to apply**: Always use `chezmoi diff`
2. **Edit source files**: Make changes in this repository, not in the target files
3. **No git operations**: Leave all version control to the repository owner
4. **OS awareness**: Consider multi-OS support when making changes
5. **DRY principle**: Avoid duplication, use templates and shared configs where possible
