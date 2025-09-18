def swap_down!(arr, i, &prc)
    while i > 0 && prc.call(arr[i - 1], arr[i]) != -1
        arr[i - 1], arr[i] = arr[i], arr[i - 1]
        i -= 1
    end
    arr
end

def insertion_sort!(arr, &prc)
    prc ||= Proc.new { |a, b| a <=> b }
    (arr.size - 1).times { |i| swap_down!(arr, i + 1, &prc) }
    arr
end

def insertion_sort(arr, &prc)
    prc ||= Proc.new { |a, b| a <=> b }
    new_arr = []
    arr.each_with_index { |ele, i| swap_down!(new_arr << ele, i, &prc) }
    new_arr
end

if $PROGRAM_NAME == __FILE__
    arr = [1,5,43,46,2,24,17,4,654,2,67,457,345,7,2,436,73,4,345,3,1,4,6,567,7,64]
    
    p insertion_sort(arr)
    p arr
    
    p insertion_sort!(arr) { |b, a| a <=> b }
end

