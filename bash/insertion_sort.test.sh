#!/usr/bin/env bash

# Enable alias expansion
shopt -s expand_aliases

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
insertion_sort="${script_dir}/insertion_sort.sh"

chmod +x "$insertion_sort"

sort="$insertion_sort"

passed=0
failed=0

# Evaluate the results of a test:
#    1: name - test name
#    2: expected - expected value
#    3: cmd - command under test
#    4: args to command
function eval_test {
    local name="$1"; shift
    local expected="$1"; shift
    local cmd="$1"; shift
    actual="$("$cmd" "$@")"
    exit_status=$?
    if [ "$exit_status" -ne 0 ]; then
        failed=$((failed+1))
        echo 'error'
        return
    fi
    
    echo -n "${name}: "
    if [ "$actual" = "$expected" ]; then
        passed=$((passed+1))
        echo 'passed'
    else
        failed=$((failed+1))
        echo "failed. Expected: '${expected}'. Actual: '${actual}'"
    fi
}

eval_test 'empty' '' $sort 0
eval_test 'single' '5' $sort 1 5
eval_test 'double' '2 7' $sort 2 7 2
eval_test 'same' '8 8 8' $sort 3 8 8 8
eval_test 'big case' '-7 -4 -4 3 4 5 8 12 12 12' $sort 10 12 12 -4 -7 -4 3 8 12 4 5
eval_test 'custom' '8 8 6 3 1 1' $sort 6 1 6 1 8 3 8 rev-cmp

echo "Passed: ${passed}"
echo "Failed: ${failed}"
exit $([ $failed -eq 0 ])