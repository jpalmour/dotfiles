#!/bin/bash

export REPO_DIR=~/Developer/repos
export NOTES_DIR=~/Developer/notes
export TODO_DIR=~/Developer/todo

# open notes and todo in vim in 2 vertical splits
# create today's todo from previous day if today's todo doesn't exist
# -n does this in new tmux window
nt () {
  local OPTIND
  local opt
  createTodo
  date_format=+%-m-%-d-%y
  todo_today=$(date $date_format).md
  getopts "n" opt
  if [ ! -z $opt ] && [ $opt = "n" ]; then
    tmux new-window -n "notes/todo"
    tmux send-keys -t "notes/todo" "cd ~/Developer" 'C-m'
    tmux send-keys -t "notes/todo" "vim $TODO_DIR/$todo_today" 'C-m'
    tmux send-keys -t "notes/todo" ":vsplit $NOTES_DIR" 'C-m'
    tmux select-window -t "notes/todo"
  else
    tmux rename-window "notes/todo"
    tmux send-keys "cd ~/Developer" 'C-m'
    tmux send-keys "vim $TODO_DIR/$todo_today" 'C-m'
    tmux send-keys ":vsplit $NOTES_DIR" 'C-m'
  fi
}

createTodo () {
  date_format=+%-m-%-d-%y
  todo_today=$(todoFileName)
  if [ ! -e $TODO_DIR/$todo_today ]; then
    num="1"
    todo_prev=$(gdate -d"-$num day" $date_format).md
    echo $todo_prev
    while [ ! -e $TODO_DIR/$todo_prev ]
    do
      num=$[$num+1]
      todo_prev=$(gdate -d"-$num day" $date_format).md
      echo $todo_prev
    done
    cp $TODO_DIR/$todo_prev $TODO_DIR/$todo_today
  fi
}

todoFileName () {
  date_format=+%-m-%-d-%y
  echo -n $(date $date_format).md
}

# take repo name as arg and prepare repo workspace
# -n does this in new tmux window
rp () {
  local OPTIND
  local opt
  getopts "n" opt
  if [ ! -z $opt ] && [ $opt = "n" ]; then
    window_name=${2/./_}
    tmux new-window -n "$window_name"
    tmux send-keys -t "$window_name" "cd $REPO_DIR/$2" 'C-m'
    tmux send-keys -t "$window_name" "vim" 'C-m'
    tmux split-window -t "$window_name" -p 15
    tmux send-keys -t "$window_name.2" "cd $REPO_DIR/$2" 'C-m'
    tmux select-window -t "$window_name.1"
  else
    window_name=${1/./_}
    tmux rename-window "$window_name"
    tmux send-keys "cd $REPO_DIR/$1" 'C-m'
    tmux send-keys "vim" 'C-m'
    tmux split-window -p 15
    tmux send-keys -t "$window_name.2" "cd $REPO_DIR/$1" 'C-m'
  fi
}

# take docker-compose service as arg and log
# -n does this in new tmux window
dcl () {
  local window_name="$1"-logs
  tmux new-window -n "$window_name"
  tmux send-keys -t "$window_name" "docker-env" 'C-m'
  local dir=$(pwd)
  tmux send-keys -t "$window_name" "cd $dir" 'C-m'
  tmux send-keys -t "$window_name" "docker-compose logs $1" 'C-m'
  tmux select-window -t "$window_name"
}
