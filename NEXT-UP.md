# Chezmoi Repository Improvements - NEXT UP

This document contains the remaining improvements and fixes for the chezmoi dotfiles repository, organized by priority with detailed problem descriptions and solutions.

## HIGH PRIORITY

### 3. Fix Shell Option Handling for nvm
**Problem:** The current `set -u` (nounset) workaround in Ubuntu setup is fragile. The nvm script uses unbound variables internally, which conflicts with the strict error handling using `set -euo pipefail`.

**Current Code:** Lines 123-138 in `run_once_010_ubuntu_setup.sh.tmpl`
```bash
# Save current nounset state, disable -u just for nvm
case "$-" in *u*) had_u=1 ;; *) had_u=0 ;; esac
set +u
# ... nvm commands ...
[ "$had_u" = 1 ] && set -u
```

**Solution:** Consider using `.chezmoiexternal.toml` for nvm installation instead of script-based installation. This would be cleaner and avoid shell option conflicts entirely.

**Alternative Solution:** Create a dedicated function that wraps nvm commands with proper error handling, or source nvm in a subshell to isolate the environment changes.

## MEDIUM PRIORITY

### 5. Use .chezmoiexternal.toml for External Tools
**Problem:** Oh-my-zsh and nvm are currently installed via curl-piping in scripts, which is less maintainable and harder to version control.

**Solution:** Create a `.chezmoiexternal.toml` file to manage external tools:
```toml
[".oh-my-zsh"]
type = "archive"
url = "https://github.com/ohmyzsh/ohmyzsh/archive/master.tar.gz"
exact = true
stripComponents = 1
refreshPeriod = "168h"

[".nvm"]
type = "git-repo"
url = "https://github.com/nvm-sh/nvm.git"
refreshPeriod = "168h"
```

This provides better version control, automatic updates, and cleaner installation process.

### 6. Create Unified Package Management Approach
**Problem:** Package lists are scattered throughout scripts with no central source of truth. Different OSes have different package names for the same tools.

**Solution:** Create a packages configuration file (YAML or TOML) that maps common tool names to OS-specific package names:
```yaml
packages:
  ripgrep:
    ubuntu: ripgrep
    macos: ripgrep
    windows: BurntSushi.ripgrep.MSVC
  vscode:
    ubuntu: code
    macos: visual-studio-code
    windows: Microsoft.VisualStudioCode
```

Then use templates to generate OS-specific installation commands from this central configuration.

### 7. Improve Script Naming
**Problem:** Current naming (`010`, `020`) is unclear about what each script does. The numbers indicate order but not purpose.

**Current Structure:**
- `run_once_000_bootstrap.sh` - unclear what "bootstrap" means
- `run_once_010_[os]_setup.sh` - main OS setup
- `run_once_020_ai_tools_setup.sh` - AI tools

**Solution:** Use descriptive names:
- `run_once_01_install-base-packages.sh.tmpl`
- `run_once_02_configure-shell.sh.tmpl`
- `run_once_03_install-development-tools.sh.tmpl`
- `run_once_04_install-ai-tools.sh.tmpl`

### 8. Add .chezmoi.toml.tmpl Configuration
**Problem:** No initial configuration collection for user preferences, leading to hardcoded values and no personalization.

**Solution:** Create `.chezmoi.toml.tmpl` with prompts:
```toml
[data]
email = {{ promptStringOnce . "email" "Your email address" }}
name = {{ promptStringOnce . "name" "Your full name" }}
github_username = {{ promptStringOnce . "github_username" "Your GitHub username" }}
editor = {{ promptStringOnce . "editor" "Your preferred editor" "vim" }}
```

This allows personalization while maintaining a clean setup process.

## LOW PRIORITY

### 9. Reduce Template Duplication
**Problem:** Separate scripts for each OS contain duplicated logic. For example, oh-my-zsh installation is nearly identical across platforms.

**Solution:** Create a single template with OS conditionals:
```bash
#!/usr/bin/env bash
set -euo pipefail

{{ if eq .chezmoi.os "linux" -}}
# Linux-specific setup
install_cmd="apt-get install -y"
{{ else if eq .chezmoi.os "darwin" -}}
# macOS-specific setup
install_cmd="brew install"
{{ end -}}

# Common logic
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing oh-my-zsh..."
  # ... common installation code
fi
```

### 10. Add Error Handling and Logging
**Problem:** Scripts don't provide clear feedback on failures or progress for long-running operations.

**Solution:** 
- Add a logging function:
```bash
log() { echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*"; }
error() { log "ERROR: $*" >&2; exit 1; }
```
- Add progress indicators for long operations
- Implement retry logic for network operations
- Create a log file for debugging failed installations

### 11. Document Dependencies
**Problem:** No clear documentation about why each tool is installed or what depends on what.

**Solution:** Create a `TOOLS.md` file documenting:
- Tool name and purpose
- Why it's included
- Dependencies (what needs to be installed first)
- Optional vs required status
- Configuration notes

Example:
```markdown
## Development Tools

### ripgrep
- **Purpose:** Fast text search tool
- **Required:** Yes (used by many development tools)
- **Dependencies:** None
- **Notes:** Aliased to `rg`, used by VS Code search

### Docker
- **Purpose:** Container runtime
- **Required:** Optional (for containerized development)
- **Dependencies:** Requires user to be in docker group
- **Notes:** Requires logout/login after installation
```

## SPECIFIC BUGS TO FIX

### Ubuntu: Docker Installation for Ubuntu Derivatives
**Problem:** Line 90 in `run_once_010_ubuntu_setup.sh.tmpl` uses `${UBUNTU_CODENAME}` which may not exist on Ubuntu derivatives like Pop!_OS or Linux Mint.

**Solution:** Add fallback logic:
```bash
. /etc/os-release
if [ -n "${UBUNTU_CODENAME:-}" ]; then
  DISTRO_CODENAME="$UBUNTU_CODENAME"
else
  # Fallback for derivatives
  DISTRO_CODENAME=$(lsb_release -cs)
fi
```

### macOS: nvm Installation Conflicts
**Problem:** Installing nvm through brew (line 70) can conflict with the official nvm installation method and may not properly set up shell integration.

**Solution:** Use the official nvm installation method consistently across all platforms, or fully commit to brew-based installation with proper post-install configuration.

### Windows: Inconsistent Error Handling
**Problem:** Windows PowerShell script has different error handling patterns compared to Unix scripts. Some operations may fail silently.

**Solution:** Standardize error handling:
```powershell
$ErrorActionPreference = "Stop"
try {
    # Installation commands
} catch {
    Write-Error "Failed to install: $_"
    exit 1
}
```

## NICE-TO-HAVE ENHANCEMENTS

### Add Dotfile Validation
Create a validation script that checks:
- All expected files are present
- Templates compile without errors
- No secrets are exposed in public files
- Dependencies are satisfied

### Create Installation Report
Generate a summary after installation showing:
- What was installed successfully
- What failed
- What requires manual intervention
- Next steps for the user

### Add Rollback Capability
Implement a way to rollback changes if something goes wrong:
- Backup existing configs before overwriting
- Provide a `chezmoi rollback` wrapper command
- Keep history of applied changes

### Implement Update Notifications
Add a mechanism to notify users when updates are available:
- Check upstream repository for updates
- Notify about new tools or configuration changes
- Provide safe update path that preserves local modifications

## Implementation Order

1. Fix critical bugs (Docker on Ubuntu derivatives)
2. Implement `.chezmoiexternal.toml` for external tools
3. Create unified package management
4. Improve script naming and organization
5. Add configuration prompts
6. Enhance error handling and logging
7. Create documentation
8. Implement nice-to-have features

## Testing Checklist

Before considering improvements complete, test on:
- [ ] Fresh Ubuntu installation
- [ ] Ubuntu derivative (Pop!_OS or Mint)
- [ ] macOS (Intel)
- [ ] macOS (Apple Silicon)
- [ ] Windows 10/11
- [ ] WSL2 environment
- [ ] Existing system with some tools already installed