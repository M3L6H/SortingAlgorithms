#include <bits/stdc++.h>

#define ANSI_COLOR_RED     "\x1b[31m"
#define ANSI_COLOR_GREEN   "\x1b[32m"
#define ANSI_COLOR_YELLOW  "\x1b[33m"
#define ANSI_COLOR_BLUE    "\x1b[34m"
#define ANSI_COLOR_MAGENTA "\x1b[35m"
#define ANSI_COLOR_CYAN    "\x1b[36m"
#define ANSI_COLOR_RESET   "\x1b[0m"

using namespace std;

int median(vector<int> const& nums, int a, int b, int c) {
    if (nums[a] > nums[b]) {
        if (nums[a] > nums[c]) {
            return (nums[c] > nums[b]) ? c : b;
        } else {
            return a;
        }
    } else {
        if (nums[b] > nums[c]) {
            return (nums[c] > nums[a]) ? c : a;
        } else {
            return b;
        }
    }
}

// Quick sort with median 3 sampling
vector<int> quick_sort(vector<int>& nums, int start, int end) {
    // Base cases
    if (start >= end) return nums;
    if (end - start == 1) {
        if (nums[end] < nums[start]) swap(nums[start], nums[end]);
        return nums;
    }

    // Optimal sampling
    int rand_off = rand() % (end - start - 1);
    rand_off = (rand_off == 0) ? 1 : rand_off;
    int pivot = median(nums, start, start + rand_off, end);

    int lesser_swap = start;
    int greater_swap = end;
    int pivot_num = nums[pivot];

    // Swapping elements
    for (int i = start; i <= end; ++i) {
        if (nums[i] > nums[pivot] && greater_swap > i) {
            swap(nums[i], nums[greater_swap]); 
            if (nums[i] == pivot_num) pivot = i;
            greater_swap--;
            i--;
        } else if (nums[i] < nums[pivot] && lesser_swap < i) {
            swap(nums[i], nums[lesser_swap]);
            if (nums[i] == pivot_num) pivot = i;
            lesser_swap++;
            i--;
        }
    }

    quick_sort(nums, start, pivot - 1);
    quick_sort(nums, pivot + 1, end);
    return nums;
}

void test_case() {
    int n;
    scanf("%d", &n);
    vector<int> inp(n), ans(n);
    for (int i = 0; i < n; ++i) scanf("%d", &inp[i]);
    for (int i = 0; i < n; ++i) scanf("%d", &ans[i]);
    assert(quick_sort(inp, 0, inp.size() - 1) == ans);
}

int main() {
    ios::sync_with_stdio(0);cin.tie(0);cout.tie(0);
    int t;
    scanf("%d", &t);
    for (int i = 0; i < t; ++i) {
        test_case();
        printf(ANSI_COLOR_GREEN "Test %d passed.\n" ANSI_COLOR_RESET, i + 1);
    }
    return 0;
}