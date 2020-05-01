# Slow. O(n^2)
# In-place and stable

def bubble_sort!(arr, &prc)
    prc ||= Proc.new { |a, b| a <=> b }
    sorted = false
    sort_count = 0
    while !sorted
        sorted = true
        arr[0...-1 - sort_count].each_with_index do |ele, i|
            if prc.call(ele, arr[i + 1]) == 1
                sorted = false
                arr[i], arr[i + 1] = arr[i + 1], arr[i]
            end
        end
    end
    arr
end

def bubble_sort(arr, &prc)
    bubble_sort!(arr.dup, &prc)
end

if $PROGRAM_NAME == __FILE__
    arr = [1,5,43,46,2,24,17,4,654,2,67,457,345,7,2,436,73,4,345,3,1,4,6,567,7,64]
    
    p bubble_sort(arr)
    p arr
    
    p bubble_sort!(arr) { |b, a| a <=> b }
end

