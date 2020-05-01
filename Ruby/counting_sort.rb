# Time complexity is O(n + k) where k is the range of possible values

class Array
    def counting_sort!
        counts = Array.new(19, 0)

        # Counting pass
        self.each do |num|
            raise ArgumentError, "num should be numeric!" unless Numeric === num
            raise ArgumentError "|#{num}| should be less than 10" unless num.abs < 10
            counts[num + 9] += 1
        end

        # Summing pass
        (-8..9).each { |i| counts[i+9] += counts[i + 8] }

        # Re-writing array
        num = 0
        (0...self.size).each do |i| 
            num += 1 while i + 1 > counts[num]
            self[i] = num - 9
        end

        # Return
        self
    end

    def counting_sort
        self.dup.counting_sort!
    end
end

if $PROGRAM_NAME == __FILE__
    arr = [1,4,3,4,3,4,2,4,2,3,1,2,3,4,1,2]
    p arr.counting_sort
    
    arr = [-1, 3, -3, 2, -2, 3, -1, 1, -2, 3, -3, -3]
    p arr.counting_sort
end