#!/usr/bin/env bash

# Expects
# 1: Item a
# 2: Item b
function comp {
  local a="$1" b="$2"

  if [ "$a" -lt "$b" ]; then
    echo -n '-1'
  elif [ "$a" -gt "$b" ]; then
    echo -n '1'
  else
    echo -n '0'
  fi
}

# Expects:
# 1: Len of the array to sort
# 2: The array to sort
# 3: Function to compare with
function selection_sort {
  local arr=()
  local len="$1"
  shift
  while [ "$len" -gt 0 ]; do
    arr+=("$1")
    len=$((len - 1))
    shift
  done
  comp="$1"

  local len="${#arr[@]}"
  [ "$len" -le 1 ] && echo "${arr[@]}" && return 0
  [ -z "$comp" ] && comp='comp'

  for i in ${!arr[@]}; do
    local min_idx="$i"
    local min_item="${arr[i]}"

    for j in $(seq "$((i + 1))" "$((len-1))"); do
      if [ "$("$comp" "$min_item" "${arr[j]}")" -gt 0 ]; then
        min_idx="$j"
        min_item="${arr[j]}"
      fi
    done
    
    local tmp="${arr[i]}"
    arr[i]="$min_item"
    arr[min_idx]="$tmp"
  done

  echo "${arr[@]}"
}

selection_sort "$@"