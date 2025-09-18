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
function bubble_sort {
  local arr=()
  local len="$1"; shift
  while [ "$len" -gt 0 ]; do arr+=( "$1" ); len=$((len-1)); shift; done
  comp="$1"
  
  local len="${#arr[@]}"
  [ "$len" -le 1 ] && echo "${arr[@]}" && return 0
  [ -z "$comp" ] && comp='comp'

  local sorted='false'
  local prev=''
  local next=''

  while ! "$sorted"; do
    sorted='true'
    for i in "${#arr[@]}"; do
      prev="$next"
      next="${arr[i]}"
      [ -z "$prev" ] && continue
      res="$("$comp" "$prev" "$next")"
      if [ "$res" -gt 0 ]; then
        arr[i-1]="$next"
        arr[i]="$prev"
        sorted='false'
      fi
    done
  done

  echo "${arr[@]}"
}

[ "$_" != "$0" ] || bubble_sort "$@"