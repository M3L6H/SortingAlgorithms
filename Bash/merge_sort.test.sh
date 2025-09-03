#!/usr/bin/env bash

merge_sort="$(dirname "$0")/merge_sort.sh"

# empty case
actual="$(merge_sort 0)"
empty_case="$([ "$actual" = '' ])"