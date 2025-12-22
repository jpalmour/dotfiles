# Working with this Chezmoi Repository

## Overview
This is a chezmoi-managed dotfiles repository. Chezmoi is a tool for managing configuration files (dotfiles) across multiple machines using templates and version control.

This repository supports **three operating systems** (Linux, macOS, and Windows) and aims to:
- Be DRY (Don't Repeat Yourself) wherever possible
- Provide a consistent experience across all OSes
- Use templates/conditionals to ensure appropriate resources are created on each OS
- Include all practical, non-sensitive setup logic and scripts needed to configure machines

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
- `.chezmoiignore.tmpl` controls which files are applied per OS and setup context
- Uses Go template syntax to conditionally ignore files based on OS/architecture/flags

### Package Installation
- Package lists live in `.chezmoi.toml.tmpl` (brew/apt/snap/winget)

### Automation Scripts
- OS-specific setup scripts live in `.chezmoiscripts/`
- Script ordering uses filename prefixes (e.g., `run_onchange_before_1_*`)

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

## External Resources

`.chezmoiexternal.toml.tmpl` downloads external dependencies (e.g., oh-my-zsh, powerlevel10k).
This can require network access for `chezmoi diff/apply`.

## Best Practices for AI Assistants

1. **Test before asking user to apply**: Always use `chezmoi diff`
2. **Edit source files**: Make changes in this repository, not in the target files
3. **No git operations**: Leave all version control to the repository owner
4. **OS awareness**: Consider multi-OS support when making changes
5. **DRY principle**: Avoid duplication, use templates and shared configs where possible
