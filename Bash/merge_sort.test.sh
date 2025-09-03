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

echo "Passed: ${passed}"
echo "Failed: ${failed}"
exit "$([ $failed -eq 0 ])"