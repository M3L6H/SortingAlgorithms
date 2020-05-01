require_relative "bubble_sort.rb"
require_relative "insertion_sort.rb"
require_relative "merge_sort.rb"
require_relative "quick_sort.rb"
require_relative "radix_sort.rb"
require_relative "selection_sort.rb"

require "benchmark"


arr = Array.new(100_000_000) { rand(1000) }

Benchmark.bm(9) do |x|
    # x.report("bubble:") { bubble_sort(arr) }
    # x.report("insert:") { insertion_sort(arr) }
    x.report("merge:") { merge_sort(arr) }
    # x.report("quick:") { quick_sort(arr) }
    x.report("radix:") { radix_sort(arr) }
    # x.report("select:") { selection_sort(arr) }
end

# n = 1000
#                 user     system      total        real
# bubble:     0.187500   0.000000   0.187500 (  0.191983)
# insert:     0.062500   0.000000   0.062500 (  0.059098)
# merge:      0.000000   0.000000   0.000000 (  0.004343)
# quick:      0.000000   0.000000   0.000000 (  0.002281)
# radix:      0.000000   0.000000   0.000000 (  0.003073)
# select:     0.109375   0.000000   0.109375 (  0.097448)

# n = 10,000
#                 user     system      total        real
# bubble:    18.656250   0.015625  18.671875 ( 18.674602) # a literal 10^2 increase!
# insert:     5.140625   0.000000   5.140625 (  5.172819) # increase was 82.25
# merge:      0.031250   0.000000   0.031250 (  0.031818)
# quick:      0.031250   0.000000   0.031250 (  0.037974)
# radix:      0.046875   0.000000   0.046875 (  0.035212)
# select:     9.265625   0.093750   9.359375 (  9.372419) # increase was 84.71

# n = 100,000
#                 user     system      total        real
# bubble:   1870.187500   0.437500 1870.625000 (1878.263178)
# insert:   558.765625   0.046875 558.812500 (560.793729)
# merge:      0.437500   0.015625   0.453125 (  0.454295)
# quick:      0.968750   0.000000   0.968750 (  0.981130)
# radix:      0.250000   0.000000   0.250000 (  0.243737)
# select:   961.234375   0.046875 961.281250 (964.166271)

# n = 1,000,000
#                 user     system      total        real
# merge:      4.562500   0.046875   4.609375 (  4.612920)
# quick:     77.078125   0.015625  77.093750 ( 77.264385)
# radix:      2.546875   0.015625   2.562500 (  2.566047)

# n = 10,000,000
#                 user     system      total        real
# merge:     49.218750   0.500000  49.718750 ( 49.830216)
# radix:     25.390625   0.109375  25.500000 ( 25.527622)

# n = 100,000,000
#                 user     system      total        real
# merge:    612.843750   4.453125 617.296875 (618.268642)
# radix:    272.343750   1.968750 274.312500 (274.585527)