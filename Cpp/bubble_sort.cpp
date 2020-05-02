#include <bits/stdc++.h>

#define ANSI_COLOR_RED     "\x1b[31m"
#define ANSI_COLOR_GREEN   "\x1b[32m"
#define ANSI_COLOR_YELLOW  "\x1b[33m"
#define ANSI_COLOR_BLUE    "\x1b[34m"
#define ANSI_COLOR_MAGENTA "\x1b[35m"
#define ANSI_COLOR_CYAN    "\x1b[36m"
#define ANSI_COLOR_RESET   "\x1b[0m"

using namespace std;

vector<int> bubble_sort(vector<int>& nums) {
    bool sorted = false;

    while (!sorted) {
        sorted = true;

        for (int i = 0; i < nums.size() - 1; ++i) {
            if (nums[i] > nums[i + 1]) {
                int temp = nums[i];
                nums[i] = nums[i + 1];
                nums[i + 1] = temp;
                sorted = false;
            }
        }
    }

    return nums;
}

void test_case() {
    int n;
    scanf("%d", &n);
    vector<int> inp(n), ans(n);
    for (int i = 0; i < n; ++i) scanf("%d", &inp[i]);
    for (int i = 0; i < n; ++i) scanf("%d", &ans[i]);
    assert(bubble_sort(inp) == ans);
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