#include <bits/stdc++.h>

#define ANSI_COLOR_RED     "\x1b[31m"
#define ANSI_COLOR_GREEN   "\x1b[32m"
#define ANSI_COLOR_YELLOW  "\x1b[33m"
#define ANSI_COLOR_BLUE    "\x1b[34m"
#define ANSI_COLOR_MAGENTA "\x1b[35m"
#define ANSI_COLOR_CYAN    "\x1b[36m"
#define ANSI_COLOR_RESET   "\x1b[0m"

using namespace std;

vector<int> counting_sort(vector<int>& nums, vector<int>& new_nums, int digit) {
    int counts[10] = {};

    // Calculating the counts
    for (int i = 0; i < nums.size(); ++i) {
        int idx = ((int)(nums[i] / pow(10, digit))) % 10;
        counts[idx]++;
    }

    // Propogating the counts
    for (int i = 9; i >= 1; --i) { counts[i] = counts[i - 1]; }
    counts[0] = 0;
    for (int i = 1; i < 10; ++i) {
        counts[i] += counts[i - 1];
    }

    for (int num : nums) {
        int idx = ((int)(num / pow(10, digit))) % 10;
        new_nums[counts[idx]++] = num;
    }

    return new_nums;
}

vector<int> radix_sort(vector<int>& nums) {
    int max_num = nums[0];
    for (int num : nums) { max_num = max(max_num, num); }
    int digit = 0;
    vector<int> new_nums(nums);
    while ((int)(max_num / pow(10, digit)) > 0) {
        nums = counting_sort(nums, new_nums, digit);
        ++digit;
    }
    
    return nums;
}

void test_case() {
    int n;
    scanf("%d", &n);
    vector<int> inp(n), ans(n);
    for (int i = 0; i < n; ++i) scanf("%d", &inp[i]);
    for (int i = 0; i < n; ++i) scanf("%d", &ans[i]);
    assert(radix_sort(inp) == ans);
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