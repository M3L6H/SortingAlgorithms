# Time complexity is O(n + k) where k is the range of possible values

class Array
    # Accepts an optional block to map the contents of the array into the range
    # (-9..9)
    def counting_sort(&prc)
        prc ||= Proc.new { |num| num }
        
        counts = Array.new(19, 0)

        # Counting pass
        self.each do |num|
            raise ArgumentError, "#{prc.call(num)} should be numeric!" unless Numeric === prc.call(num)
            raise ArgumentError "|#{prc.call(num)}| should be less than 10" unless prc.call(num).abs < 10
            counts[prc.call(num) + 9] += 1
        end

        # Summing pass
        (-8..9).each { |i| counts[i+9] += counts[i + 8] }

        # Re-writing array
        new_arr = Array.new(self.size)
        (self.size - 1).downto(0) do |i|
            counts[prc.call(self[i]) + 9] -= 1
            new_arr[counts[prc.call(self[i]) + 9]] = self[i]
        end


        # Return
        new_arr
    end
end

if $PROGRAM_NAME == __FILE__
    arr = [1,4,3,4,3,4,2,4,2,3,1,2,3,4,1,2]
    p arr.counting_sort
    
    arr = [-1, 3, -3, 2, -2, 3, -1, 1, -2, 3, -3, -3]
    p arr.counting_sort
    
    arr = [10, 14, 15, 13, 13, 12, 15, 14, 13, 14, 13, 12, 13]
    p arr.counting_sort { |num| num % 10 }
end