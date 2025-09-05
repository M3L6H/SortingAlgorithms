#!/usr/bin/env bash

set -e

# Expects:
# 1: An element
# Returns: A number represenring a 1-1 mapping to the given element
function map {
  echo "$1"
}

# Expects:
# 1: Len of the array to sort
# 2: The array to sort
# 3: Mapping function
function counting_sort {
  local arr=()
  local len="$1"; shift
  while [ "$len" -gt 0 ]; do arr+=( "$1" ); len=$((len-1)); shift; done
  
  local len="${#arr[@]}"
  [ "$len" -le 1 ] && echo "${arr[@]}" && return 0

  local map="$1"
  [ -z "$map" ] && map='map'

  local min="$(map "${arr[0]}")"

  local counts=()
  local rev_map=()

  for elt in "${arr[@]}"; do
    local key="$(map "$elt")"
    
    if [ -n "${rev_map[$key]}" ]; then
      if [ "${rev_map[$key]}" != "$elt" ]; then
        echo "Duplicate mapping '${elt}' & '${rev_map[$key]}' map to same key: '${key}'"
        exit 1
      else
        rev_map[$key]="$elt"
      fi
    fi
    
    [ "$min" -gt "$key" ] && min="$key"
    local count="${counts[$key]}"
    [ -z "$count" ] && count=0
    count=$((count+1))
    counts[$key]="$count"
  done

  local key="$min"

  local output=()

  while [ "$len" -gt 0 ]; do
    local count="${counts[$key]}"
    local elt="${rev_map[$key]}"
    while [ -n "$count" ] && [ "$count" -gt 0 ]; do
      output+=( "$elt" )
      count=$((count-1))
      len=$((len-1))
    done
    key=$((key+1))
  done

  echo "${output[@]}"
}

[ "$_" != "$0" ] || counting_sort "$@"