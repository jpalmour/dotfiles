#!/bin/bash

export NOTES_DIR=~/Developer/td-notes
export TODO_DIR=~/Developer/todo

nt () {
  date_format=+%-m-%-d-%y
  todo_today=$(date $date_format).md
  if [ ! -e $TODO_DIR/$todo_today ]; then
    todo_yesterday=$(date -d'yesterday' $date_format).md
    cp $TODO_DIR/$todo_yesterday $TODO_DIR/$todo_today
  fi
  tmux new-window -n "notes/todo"
  tmux send-keys -t "notes/todo" "vim $TODO_DIR/$todo_today" 'C-m'
  tmux send-keys -t "notes/todo" ":vsplit $NOTES_DIR" 'C-m'
  tmux select-window -t "notes/todo"
}

rp () {
  tmux new-window -n "$1"
  tmux send-keys -t "$1" "vim $REPO_DIR/$1" 'C-m'
  tmux split-window -t "$2" -p 15
  tmux send-keys -t "$1" "cd $REPO_DIR/$1" 'C-m'
  tmux select-window -t "$1"
}
