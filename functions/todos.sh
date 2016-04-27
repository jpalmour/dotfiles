#!/bin/bash

export REPO_DIR=~/Developer/repos
export NOTES_DIR=~/Developer/notes
export TODO_DIR=~/Developer/todo

createTodoAndCleanPrevious () {
  date_format=+%m-%d
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
    # copy todo list and following headers only to new todo
    awk -f ~/functions/create-new-todo.awk $TODO_DIR/$todo_prev > $TODO_DIR/$todo_today

    # remove todo list and only leave completed items from $todo_prev
    awk -f ~/functions/clean-old-todo.awk $TODO_DIR/$todo_prev > /tmp/new-todo.md
    mv /tmp/new-todo.md $TODO_DIR/$todo_prev
  fi
}

todoFileName () {
  date_format=+%m-%d
  echo -n $(date $date_format).md
}
