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

# Expects
# 1: Item
# 2: Array
# 3: Start
# 4: End
# 5: Comp
function bsearch {
  local item="$1"
  local arr=($2)
  local s="$3"
  local e="$4"
  local comp="$5"
  local len="$((e - s))"
  
  echo "$item $arr $s $e $comp"

  if [ "$len" -le 1 ]; then
    if [ "$("$comp" "$item" "${arr[s]}")" -lt 0 ]; then
      echo "$s"
    else
      echo "$((s+1))"
    fi
    return 0
  fi

  local i="$((s + len / 2))"

  if [ "$("$comp" "$item" "${arr[i]}")" -lt 0 ]; then
    bsearch "$item" "${arr[@]}" "$s" "$i" "$comp"
  else
    bsearch "$item" "${arr[@]}" "$((i+1))" "$e" "$comp"
  fi
}

# Expects:
# 1: Len of the array to sort
# 2: The array to sort
# 3: Function to compare with
function insertion_sort {
  local arr=()
  local len="$1"
  shift
  while [ "$len" -gt 0 ]; do
    arr+=("$1")
    len=$((len - 1))
    shift
  done
  local comp="$1"

  local len="${#arr[@]}"
  [ "$len" -le 1 ] && echo "${arr[@]}" && return 0
  [ -z "$comp" ] && comp='comp'

  local sorted=()

  for elt in ${arr[@]}; do
    local idx="$(bsearch "$elt" "${sorted[@]}" 0 "${#sorted[@]}" "$comp")"

    local curr="${sorted[idx]}"
    sorted[idx]="$elt"

    for ((i=$idx+1;i<$len;i++)); do
      local tmp="${sorted[i]}"
      sorted[i]="$curr"
      curr="$tmp"
    done
  done

  echo "${sorted[@]}"
}

insertion_sort "$@"