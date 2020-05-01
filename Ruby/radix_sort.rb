require_relative "./counting_sort.rb"

# O(d*(n + b))
# where d is the number of digits in the largest number
# and b is the base we are using (in this case 10)
def radix_sort(arr)
    max = arr.max
    sorted = arr
    i = 0
    while max / (10 ** i) > 0
        sorted = sorted.counting_sort { |num| (num / (10 ** i)) % 10 }
        i += 1
    end
    sorted
end

if $PROGRAM_NAME == __FILE__
    arr = [1,4,12,511,25,12,515,3252,362,32,3,26535]
    p radix_sort(arr)
end