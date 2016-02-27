#!/bin/bash

export REPO_DIR=~/Developer/repos
export NOTES_DIR=~/Developer/notes
export TODO_DIR=~/Developer/todo

nt () {
  local OPTIND
  local opt
  date_format=+%-m-%-d-%y
  todo_today=$(date $date_format).md
  if [ ! -e $TODO_DIR/$todo_today ]; then
    todo_yesterday=$(date -d'yesterday' $date_format).md
    cp $TODO_DIR/$todo_yesterday $TODO_DIR/$todo_today
  fi
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
