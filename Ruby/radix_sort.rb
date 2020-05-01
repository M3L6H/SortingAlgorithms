require_relative "./counting_sort.rb"

class Array
    def radix_sort
        max = self.max
        sorted = self
        i = 0
        while max / (10 ** i) > 0
            sorted = sorted.counting_sort { |num| (num / (10 ** i)) % 10 }
            i += 1
        end
        sorted
    end
end

if $PROGRAM_NAME == __FILE__
    arr = [1,4,12,511,25,12,515,3252,362,32,3,26535]
    p arr.radix_sort
end