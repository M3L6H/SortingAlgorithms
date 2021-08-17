#!/bin/bash

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
# 1: Len of list a
# 2: List a
# 3: Len of list b
# 4: List b
# 5: Function to compare with
function merge {
  local a=() b=() arr=()
  local len="$1"; shift
  while [ "$len" -gt 0 ]; do a+=( "$1" ); len=$((len-1)); shift; done
  len="$1"; shift
  while [ "$len" -gt 0 ]; do b+=( "$1" ); len=$((len-1)); shift; done
  comp="$1"

  local i=0 j=0
  while [ "$i" -lt "${#a[@]}" ] && [ "$j" -lt "${#b[@]}" ]; do
    if [ "$("$comp" "${a[i]}" "${b[j]}")" -eq -1 ]; then
      arr+=("${a[i]}")
      i=$((i+1))
    else
      arr+=("${b[j]}")
      j=$((j+1))
    fi
  done

  while [ "$i" -lt "${#a[@]}" ]; do
    arr+=("${a[i]}")
    i=$((i+1))
  done

  while [ "$j" -lt "${#b[@]}" ]; do
    arr+=("${b[j]}")
    j=$((j+1))
  done

  echo -n "${arr[@]}"
}

# Expects:
# 1: Len of the array to sort
# 2: The array to sort
# 3: Function to compare with
function merge_sort {
  local arr=()
  local len="$1"; shift
  while [ "$len" -gt 0 ]; do arr+=( "$1" ); len=$((len-1)); shift; done
  comp="$1"
  
  local len="${#arr[@]}"
  [ "$len" -le 1 ] && echo "${arr[@]}" && return 0
  [ -z "$comp" ] && comp='comp'

  local half=$((len/2))
  local first_half=(${arr[@]:0:half})
  local second_half=(${arr[@]:half})

  local a=($(merge_sort "${#first_half[@]}" ${first_half[@]}  "$comp"))
  local b=($(merge_sort "${#second_half[@]}" ${second_half[@]} "$comp"))

  merge "${#a[@]}" ${a[@]} "${#b[@]}" ${b[@]} "$comp"
}

[ "$_" != "$0" ] || merge_sort "$@"
