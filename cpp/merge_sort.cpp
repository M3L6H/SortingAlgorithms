#include <bits/stdc++.h>

#define ANSI_COLOR_RED     "\x1b[31m"
#define ANSI_COLOR_GREEN   "\x1b[32m"
#define ANSI_COLOR_YELLOW  "\x1b[33m"
#define ANSI_COLOR_BLUE    "\x1b[34m"
#define ANSI_COLOR_MAGENTA "\x1b[35m"
#define ANSI_COLOR_CYAN    "\x1b[36m"
#define ANSI_COLOR_RESET   "\x1b[0m"

using namespace std;

vector<int> merge(vector<int> const& a, vector<int> const& b) {
    int i = 0, j = 0, k = 0;
    vector<int> merged(a.size() + b.size());

    while (i < a.size() && j < b.size()) {
        if (a[i] < b[j]) {
            merged[k] = a[i];
            ++i;
        } else {
            merged[k] = b[j];
            ++j;
        }
        ++k;
    }

    while (i < a.size()) {
        merged[k] = a[i];
        ++i; ++k;
    }
    
    while (j < b.size()) {
        merged[k] = b[j];
        ++j; ++k;
    }

    return merged;
}

vector<int> merge_sort(vector<int>& nums) {
    if (nums.size() <= 1) return nums;
    int mid = nums.size() / 2;
    vector<int> left(nums.begin(), nums.begin() + mid);
    vector<int> right(nums.begin() + mid, nums.end());
    return merge(merge_sort(left), merge_sort(right));
}

void test_case() {
    int n;
    scanf("%d", &n);
    vector<int> inp(n), ans(n);
    for (int i = 0; i < n; ++i) scanf("%d", &inp[i]);
    for (int i = 0; i < n; ++i) scanf("%d", &ans[i]);
    assert(merge_sort(inp) == ans);
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