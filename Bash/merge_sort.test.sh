#!/usr/bin/env bash

# Enable alias expansion
shopt -s expand_aliases

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
merge_sort="${script_dir}/merge_sort.sh"

chmod +x "$merge_sort"

alias merge_sort="$merge_sort"

passed=0
failed=0

# Evaluate the results of a test:
#    $1: name - test name
#    $2: actual - value produced by subject
#    $3: expected - expected valud
function eval_test {
    local name="$1"
    local actual="$2"
    local expected="$3"
    echo -n "${name}: "
    if [ "$actual" = "$expected" ]; then
        passed=$((passed + 1))
        echo 'passed'
    else
        failed=$((failed + 1))
        echo 'failed'
    fi
}

eval_test 'empty case' "$(merge_sort 0)" ''
eval_test 'single case' "$(merge_sort 1 22)" '22'
eval_test 'two elements' "$(merge_sort 2 8 3)" '3 8'
eval_test 'three elements' "$(merge_sort 3 9 1 5)" '1 5 9'
eval_test 'already sorted' "$(merge_sort 5 5 12 47 51 88)" '5 12 47 51 88'
eval_test 'reversed' "$(merge_sort 6 103 95 40 38 23 19)" '19 23 38 40 95 103'
eval_test 'swapped' "$(merge_sort 8 203 150 245 162 222 155 270 187)" '150 155 162 187 203 222 245 270'
eval_test 'same' "$(merge_sort 16 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2" '2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2'

function rev_comp {
  local a="$1" b="$2"

  if [ "$a" -lt "$b" ]; then
    echo -n '1'
  elif [ "$a" -gt "$b" ]; then
    echo -n '-1'
  else
    echo -n '0'
  fi
}

eval_test 'custom' "$(merge_sort 8 203 150 245 162 222 155 270 187 rev_comp)" '270 245 222 203 187 162 155 150'

echo "Passed: ${passed}"
echo "Failed: ${failed}"
exit $([ $failed -eq 0 ])