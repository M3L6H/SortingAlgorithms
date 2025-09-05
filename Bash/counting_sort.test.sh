#!/usr/bin/env bash

# Enable alias expansion
shopt -s expand_aliases

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
counting_sort="${script_dir}/counting_sort.sh"

chmod +x "$counting_sort"

alias c_sort="$counting_sort"

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

eval_test 'empty' "$(c_sort 0)" ''
eval_test 'single' "$(c_sort 1 5)" '5'
eval_test 'double' "$(c_sort 2 7 2)" '2 7'
eval_test 'same' "$(c_sort 3 8 8 8)" '8 8 8'
eval_test 'big case' "$(c_sort 10 12 12 -4 -7 -4 3 8 12 4 5)" '-7 -4 -4 3 4 5 8 12 12 12'