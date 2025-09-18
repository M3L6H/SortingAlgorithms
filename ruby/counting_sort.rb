# Time complexity is O(n + k) where k is the range of possible values

class Array
    # Accepts an optional block to map the contents of the array into the range
    # given
    def counting_sort(range, &prc)
        prc ||= Proc.new { |num| num }
        
        counts = Array.new(range, 0)

        # Counting pass
        self.each do |num|
            raise ArgumentError, "#{prc.call(num)} should be numeric!" unless Numeric === prc.call(num)
            raise ArgumentError "#{prc.call(num)} should be less than #{range}" unless prc.call(num) < range
            counts[prc.call(num)] += 1
        end

        # Summing pass
        (1...range).each { |i| counts[i] += counts[i - 1] }

        # Re-writing array
        new_arr = Array.new(self.size)
        (self.size - 1).downto(0) do |i|
            counts[prc.call(self[i])] -= 1
            new_arr[counts[prc.call(self[i])]] = self[i]
        end


        # Return
        new_arr
    end
end

if $PROGRAM_NAME == __FILE__
    arr = [1,4,3,4,3,4,2,4,2,3,1,2,3,4,1,2]
    p arr.counting_sort(10)
    
    arr = [-1, 3, -3, 2, -2, 3, -1, 1, -2, 3, -3, -3]
    p arr.counting_sort(19) { |num| num + 9 }
    
    arr = [10, 14, 15, 13, 13, 12, 15, 14, 13, 14, 13, 12, 13]
    p arr.counting_sort(10) { |num| num % 10 }

    alpha = ("a".."z").to_a
    arr = Array.new(10) { alpha.sample }
    p arr.counting_sort(26) { |num| num.to_i(36) - 10 }
end