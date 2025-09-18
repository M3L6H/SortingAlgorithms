require_relative "./counting_sort.rb"

# O(d*(n + b))
# where d is the number of digits in the largest number
# and b is the base we are using (in this case 10)
def radix_sort(arr, &prc)
    prc ||= Proc.new { |num| num }
    max = arr.max_by { |num| prc.call(num) }
    sorted = arr
    i = 0
    while prc.call(max) / (10 ** i) > 0
        sorted = sorted.counting_sort(10) { |num| (prc.call(num) / (10 ** i)) % 10 }
        i += 1
    end
    sorted
end

if $PROGRAM_NAME == __FILE__
    arr = [1,4,12,511,25,12,515,3252,362,32,3,26535]
    p radix_sort(arr)

    alpha = ("a".."z").to_a
    arr = []
    10.times do
        str = ""
        3.times { str << alpha.sample }
        arr << str
    end
    p radix_sort(arr) { |num| num.to_i(36) }
    p arr.sort
end