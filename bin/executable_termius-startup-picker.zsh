#!/usr/bin/env zsh
# tmux/repo picker v2 — with worktree support

REPO_ROOT="$HOME/repos/github.com/jpalmour"
setopt pipefail no_nomatch

# --- collect sessions (names only) ---
sessions=()
if tmux list-sessions -F '#S' >/dev/null 2>&1; then
  sessions=(${(f)"$(tmux list-sessions -F '#S' 2>/dev/null)"})
fi

# --- collect repos (basename list) ---
repos=()
if [[ -d $REPO_ROOT ]]; then
  repos=(${(f)"$(find "$REPO_ROOT" -mindepth 1 -maxdepth 1 -type d -print | sort | sed "s#^$REPO_ROOT/##")"})
fi

# --- build list of repo entries (either plain repos or worktrees) ---
typeset -A has_session
for s in $sessions; do has_session[$s]=1; done

repo_entries=()
repo_paths=()

for r in $repos; do
  repo_path="$REPO_ROOT/$r"
  
  # Check if this repo uses worktrees structure
  if [[ -d "$repo_path/worktrees" ]] && { [[ -d "$repo_path/main" ]] || [[ -d "$repo_path/master" ]]; }; then
    # This repo uses worktrees
    # Determine default branch name
    if [[ -d "$repo_path/main" ]]; then
      default_branch="main"
    else
      default_branch="master"
    fi
    
    # Add entry for default branch if no matching session exists
    session_name="${r}_${default_branch}"
    if [[ -z ${has_session[$session_name]} ]]; then
      repo_entries+=("$session_name")
      repo_paths+=("$repo_path/$default_branch")
    fi
    
    # Add entries for each worktree
    if [[ -d "$repo_path/worktrees" ]]; then
      worktrees=(${(f)"$(find "$repo_path/worktrees" -mindepth 1 -maxdepth 1 -type d -print 2>/dev/null | sort)"})
      for wt in $worktrees; do
        wt_name="${wt##*/}"
        session_name="${r}_${wt_name}"
        if [[ -z ${has_session[$session_name]} ]]; then
          repo_entries+=("$session_name")
          repo_paths+=("$wt")
        fi
      done
    fi
  else
    # Regular repo without worktrees
    if [[ -z ${has_session[$r]} ]]; then
      repo_entries+=("$r")
      repo_paths+=("$repo_path")
    fi
  fi
done

while true; do
  clear

  # Option 1: home (no heading above it)
  printf "%2d) [dir]  home\n" 1
  
  # Option 2: new project
  printf "%2d) [new]  new project\n" 2

  echo "=== tmux sessions ==="
  i=3
  for s in $sessions; do
    printf "%2d) [tmux] %s\n" $i "$s"
    ((i++))
  done

  echo "=== repos (new tmux) ==="
  for j in {1..${#repo_entries}}; do
    printf "%2d) [repo] %s\n" $i "${repo_entries[$j]}"
    ((i++))
  done

  total=$(( 2 + ${#sessions} + ${#repo_entries} ))
  if (( total == 1 )); then
    echo "No tmux sessions or repos found."
    return 0
  fi

  printf "Select 1-%d (q to quit): " $total
  read sel
  
  [[ $sel == [qQ] ]] && return 0
  [[ $sel = <-> ]] || continue
  (( sel >= 1 && sel <= total )) || continue

  if (( sel == 1 )); then
    # [dir] home
    if builtin cd "$HOME"; then
      echo "📂 $(pwd)"
    else
      echo "Failed to cd into \$HOME"
    fi
    break
  fi
  
  if (( sel == 2 )); then
    # [new] new project
    printf "Enter project name: "
    read project_name
    
    if [[ -z "$project_name" ]]; then
      echo "Project name cannot be empty"
      sleep 2
      continue
    fi
    
    project_path="$REPO_ROOT/$project_name"
    
    if [[ -d "$project_path" ]]; then
      echo "Project directory already exists: $project_path"
      sleep 2
      continue
    fi
    
    echo "Creating new project: $project_name"
    
    # Create project structure
    mkdir -p "$project_path/worktrees"
    mkdir -p "$project_path/main"
    
    # Navigate to main directory and create repo from template
    if cd "$project_path/main"; then
      echo "Creating GitHub repository from template..."
      if gh repo create "$project_name" --clone --private --template jpalmour/agent-container-template; then
        echo "✅ Project created successfully!"
        # Start a new tmux session in the main directory
        tmux new-session -s "${project_name}_main" -c "$project_path/main"
      else
        echo "Failed to create GitHub repository"
        # Clean up directories on failure
        rm -rf "$project_path"
        sleep 3
      fi
    else
      echo "Failed to navigate to project directory"
      rm -rf "$project_path"
      sleep 3
    fi
    break
  fi

  # Sessions range
  sess_count=${#sessions}
  if (( sel <= 2 + sess_count )); then
    idx=$(( sel - 2 ))         # sessions start at menu index 3
    name="${sessions[$idx]}"
    tmux attach -t "$name" || tmux new -s "$name"
    break
  fi

  # Repos range → new tmux session
  repo_index=$(( sel - 2 - sess_count ))
  session_name="${repo_entries[$repo_index]}"
  session_path="${repo_paths[$repo_index]}"

  if [[ -d "$session_path" ]]; then
    # If a session somehow exists now, attach; else create in directory.
    if tmux has-session -t "$session_name" 2>/dev/null; then
      tmux attach -t "$session_name"
    else
      tmux new-session -s "$session_name" -c "$session_path"
    fi
  else
    echo "Missing directory: $session_path"
  fi
  break
done